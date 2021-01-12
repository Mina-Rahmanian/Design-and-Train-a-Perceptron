using System;
using System.Collections.Generic;
using System.IO;

namespace ArtificialNeuralNetwork
{
   class Program
   {
      static void Main(string[] args)
      {
         Console.WriteLine("*****************************************************************************************");
         Console.WriteLine("*                         Mina Rahmanian ; PERCEPTRON                   *");
         Console.WriteLine("*                               September, 2019                                      *");
         Console.WriteLine("*****************************************************************************************");
         Console.WriteLine();
         Console.WriteLine("Please give me the address of the training csv file:\n");
         Console.WriteLine("Each line in the files represents a separate data point " +
                           "\n where each data point includes the following comma separated values:");
         Console.WriteLine("Sepal length (cm), Sepal width (cm), Petal length (cm), Petal width (cm), class label.");
         Console.WriteLine();
         var filePath = Console.ReadLine();
       

         var sepalLengthList = new List<double>();
         var sepalWidthList = new List<double>();
         var petalLengthList = new List<double>();
         var petalWidthList = new List<double>();
         var classLableList = new List<string>();
         var categories = new List<string>();

         // create a dictionary to store length, width and class lable
         var dataSet = new List<double[]>();

         // make sure the file exist
         if (!IsValidPath(filePath))
         {
            Console.WriteLine("Could not find the file in provide path. ");
         }
         else
         {
            int rowLength = 0;
            using (var reader = new StreamReader(filePath))
            {
               // read file line by line and add the data
               while (!reader.EndOfStream)
               {
                  var line = reader.ReadLine();
                  var values = line.Split(',');
                  rowLength = values.Length;
                  double sepalLength;
                  double.TryParse(values[0], out sepalLength);
                  sepalLengthList.Add(sepalLength);
                  double sepalWidth;
                  double.TryParse(values[1], out sepalWidth);
                  sepalWidthList.Add(sepalWidth);
                  double petalLength;
                  double.TryParse(values[2], out petalLength);
                  petalLengthList.Add(petalLength);
                  double petalWidth;
                  double.TryParse(values[3], out petalWidth);
                  petalWidthList.Add(petalWidth);
                  string classLable = values[4];
                  classLableList.Add(classLable);
                  if (!categories.Contains(classLable))
                  {
                     categories.Add(classLable);
                  }
               }
            }

            // prepare dataset in a desired format
            for (int iData = 0, nData = petalLengthList.Count; iData < nData; iData++)
            {
               var row = new double[rowLength + categories.Count - 1];
               int i = 0;
               row[i++] = sepalLengthList[iData];
               row[i++] = sepalWidthList[iData];
               row[i++] = petalLengthList[iData];
               row[i++] = petalWidthList[iData];

               foreach (var category in categories)
               {
                  row[i++] = classLableList[iData] == category ? 1.0 : 0.0;
               }

               dataSet.Add(row);
            }
         }

         // create an perceptron instance
         var perceptron = new Perceptron(dataSet, categories);

         // train the perceptron
         perceptron.GetTrained();

         Console.WriteLine("*****************************************************************************************");
         Console.WriteLine("Perceptron training is done ...!");
         Console.WriteLine("*****************************************************************************************");
         Console.WriteLine();

         // test the ANN by user; asking for input
         // the loop will end by pressing ESC
         do
         {
            Console.WriteLine("Please enter Sepal Length:");
            double sepalLength;
            double.TryParse(Console.ReadLine(), out sepalLength);

            Console.WriteLine("Please enter Sepal Width:");
            double sepalWidth;
            double.TryParse(Console.ReadLine(), out sepalWidth);

            Console.WriteLine("Please enter Petal Length:");
            double petalLength;
            double.TryParse(Console.ReadLine(), out petalLength);

            Console.WriteLine("Please enter Petal Width:");
            double petalWidth;
            double.TryParse(Console.ReadLine(), out petalWidth);

            string guessedCategory = perceptron.GuessCategory(sepalLength, sepalWidth, petalLength, petalWidth);

            Console.WriteLine();
            Console.WriteLine(guessedCategory);
            Console.WriteLine();

            Console.WriteLine("\nDo you want to try another case?! ");
            Console.WriteLine("Press any key to continue! Press ESC to quit.");
            Console.WriteLine();
            Console.WriteLine("*****************************************************************************************");

         } while (Console.ReadKey(true).Key != ConsoleKey.Escape);

         Console.WriteLine();
         Console.WriteLine("If you want, you can provide a csv file to test the algorithm.");

         Console.WriteLine("Press any key to provide a test csv file ! or Press ESC again to quit.");
         if ((Console.ReadKey(true).Key != ConsoleKey.Escape))
         {

         }

      }

      // a method to make sure the file path exists
      public static bool IsValidPath(string path)
      {
         bool isValid = true;

         try
         {
            string root = Path.GetPathRoot(path);
            isValid = string.IsNullOrEmpty(root.Trim('\\', '/')) == false;
         }
         catch (Exception ex)
         {
            isValid = false;
         }

         return isValid;
      }
   }
}

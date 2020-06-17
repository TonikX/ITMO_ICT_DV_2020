using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Runtime.ExceptionServices;
using System.Threading;
using System.Threading.Tasks.Dataflow;
using System.Xml.Schema;
using Microsoft.VisualBasic.FileIO;

namespace ConsoleApp1
{
    class Program
    {
        static void Main()
        {
            var data = CsvReader(@"E:\university\2 курс\4 семестр\визуализация и моделирование\lab2\data\steam.csv");
            var rate = data
                .GroupBy(x => x[7])
                .Where(x => x.Key != "0")
                .Select(x => new[] {x.Key, x.Count().ToString()})
                .ToList();
            CsvWriter(@"E:\university\2 курс\4 семестр\визуализация и моделирование\lab2\data\steam-1.csv", rate, "age,count");

            var priceYear = data.Select(x => new[] {$"{x[2].Split('-')[0]}.{(double.Parse(x[2].Split('-')[1])/12).ToString().Split(',').Last()}", x.Last()}).ToList();
            CsvWriter(@"E:\university\2 курс\4 семестр\визуализация и моделирование\lab2\data\steam-2.csv", priceYear, "Year,Price");

            var online = data
                .GroupBy(x => x[2].Split('-')[0])
                .Select(x =>
                {
                    var count = x.Count();
                    var hasOnline = x.Count(x => x[8].ToLower().Contains("online"));
                    var hasntOnline = count - hasOnline;
                    return new[] { x.Key, hasOnline.ToString(), hasntOnline.ToString(), count.ToString() };
                })
                .OrderBy(x => x[0])
                .ToList();
            CsvWriter(@"E:\university\2 курс\4 семестр\визуализация и моделирование\lab2\data\steam-3.csv", online, "date,hasOnline,notOnline,count");

            var releaseDates = data
                .GroupBy(x => x[2].Split('-')[0])
                .Select(x => new[] {x.Key, x.Count().ToString()})
                .OrderBy(x => x[0])
                .ToList();
            CsvWriter(@"E:\university\2 курс\4 семестр\визуализация и моделирование\lab2\data\steam-4.csv", releaseDates, "date,count");

            var devCount = data
                .GroupBy(x => x[4])
                .Select(x => (x.Key, x.Count()))
                .OrderByDescending(x => x.Item2)
                .Select(x => new[]{x.Key.Split(',').First(), x.Item2.ToString()})
                .Take(30)
                .ToList();
            CsvWriter(@"E:\university\2 курс\4 семестр\визуализация и моделирование\lab2\data\steam-5.csv", devCount, "Developer,Count");
        }

        private static List<string[]> CsvReader(string path)
        {
            var result = new List<string[]>();
            var isFirst = true;
            using (var parser = new TextFieldParser(path))
            {
                parser.TextFieldType = FieldType.Delimited;
                parser.SetDelimiters(",");
                while (!parser.EndOfData)
                {
                    //Process row
                    var fields = parser.ReadFields();
                    if (isFirst)
                    {
                        isFirst = false;
                    }
                    else
                    {
                        result.Add(fields);
                    }
                }
            }

            return result;
        }

        private static void CsvWriter(string path, List<string[]> hyperResults, string firstLine)
        {
            using var stream = new StreamWriter(path);
            stream.WriteLine(firstLine);
            foreach (var item in hyperResults)
            {
                stream.WriteLine(string.Join(",", item));
            }
        }
    }
}
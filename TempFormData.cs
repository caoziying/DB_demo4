using System;

namespace DB_demo4
{
    public class Coordinates
    {
        public string Longitude { get; set; }
        public string Latitude { get; set; }
    }

    public class TempFormData
    {
        public string SSname { get; set; }
        public string SScity { get; set; }
        public string SSopen_start_time { get; set; }
        public string SSopen_end_time { get; set; }
        public string SSphone { get; set; }
        public string SScap_res { get; set; }

        public TempFormData(string ssname, string sscity, string ssopen_start_time, string ssopen_end_time, string ssphone, string sscap_res)
        {
            SSname = ssname;
            SScity = sscity;
            SSopen_start_time = ssopen_start_time;
            SSopen_end_time = ssopen_end_time;
            SSphone = ssphone;
            SScap_res = sscap_res;
        }
    }
    public class DistanceCalculator
    {
        public static double CalculateDistance(string lat1, string lon1, string lat2, string lon2)
        {
            double dLat = ToRadians(Double.Parse(lat2) - Double.Parse(lat1));
            double dLon = ToRadians(Double.Parse(lon2) - Double.Parse(lon1));

            double a = Math.Sin(dLat / 2) * Math.Sin(dLat / 2) +
                       Math.Cos(ToRadians(Double.Parse(lat1))) * Math.Cos(ToRadians(Double.Parse(lat2))) *
                       Math.Sin(dLon / 2) * Math.Sin(dLon / 2);

            double c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));

            // 地球半径（单位：千米）
            const double radius = 6371;

            // 计算距离
            double distance = radius * c;

            // 舍入到两位小数
            distance = Math.Round(distance, 2);
            return distance;
        }

        private static double ToRadians(double degrees)
        {
            return degrees * (Math.PI / 180);
        }
    }
}
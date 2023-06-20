namespace DB_demo4
{
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
}
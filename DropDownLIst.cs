using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MemberManagement
{
    public class DropDownLIst
    {
        public ArrayList DepDropDownList()
        {
            ArrayList arr = new ArrayList();
            arr.Add("--선택--");
            arr.Add("개발1팀");
            arr.Add("개발2팀");
            arr.Add("개발3팀");
            arr.Add("개발4팀");
            arr.Add("유지보수");
            arr.Add("디자인팀");
            arr.Add("영업팁");
            arr.Add("경영관리팀");
            return arr;
            
        }

        public ArrayList PositionDropDownList()
        {
            ArrayList arr = new ArrayList();
            arr.Add("--선택--");
            arr.Add("대표이사");
            arr.Add("상무");
            arr.Add("이사");
            arr.Add("부장");
            arr.Add("차장");
            arr.Add("과장");
            arr.Add("대리");
            arr.Add("사원");
            arr.Add("인턴");
            return arr;

        }

    }
}
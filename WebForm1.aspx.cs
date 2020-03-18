using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;

namespace MemberManagement
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        //DB 연결객체
        SqlConnection conn = 
            new SqlConnection(ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString);

        //드랍다운 리스트 객체
        DropDownLIst DL = new DropDownLIst();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                
                ArrayList depItem = DL.DepDropDownList();
                dep.DataSource = depItem;
                dep.DataBind();

                ArrayList positionItem = DL.PositionDropDownList();
                position.DataSource = positionItem;
                position.DataBind();


            }
        }

        //신규
        protected void BtnNew_Click(object sender, EventArgs e)
        {
            //신규버튼 클릭시 테이블 클린
            TableReset();
        }

        //저장
        protected void BtnSave_Click(object sender, EventArgs e)
        {
            //사번이 없으면 데이터 삽입
            if (pNo.Text.Equals(""))
            {
                string sql = "INSERT INTO 회원관리(성명,주민번호,성별,이메일,전화번호,우편번호,주소,부서,직위) " +
                    "VALUES(@성명,@주민번호,@성별,@이메일,@전화번호,@우편번호,@주소,@부서,@직위)";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@성명", username.Text);
                cmd.Parameters.AddWithValue("@주민번호", front_SSNumber.Text + back_SSNumber.Text);
                
                //주민뒷자리 젤 앞번호 성별구분
                string sex = back_SSNumber.Text;
                cmd.Parameters.AddWithValue("@성별", sex.Substring(0, 1));

                cmd.Parameters.AddWithValue("@이메일", email.Text);
                cmd.Parameters.AddWithValue("@전화번호", phone.Text);
                cmd.Parameters.AddWithValue("@우편번호", psCode.Text);
                cmd.Parameters.AddWithValue("@주소", address.Text);
                cmd.Parameters.AddWithValue("@부서", dep.Text);
                cmd.Parameters.AddWithValue("@직위", position.Text);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

            }
            //사번이 있으면 데이터 수정
            else
            {
                string sql = "UPDATE 회원관리 SET " +
                    "성명=@성명, 주민번호=@주민번호, 이메일=@이메일, " +
                    "전화번호=@전화번호, 우편번호=@우편번호, 주소=@주소, " +
                    "부서=@부서, 직위=@직위 " +
                    "WHERE 사번 = @사번";
                SqlCommand cmd = new SqlCommand(sql,conn);
                cmd.Parameters.AddWithValue("@성명",username.Text);
                cmd.Parameters.AddWithValue("@주민번호", front_SSNumber.Text + back_SSNumber.Text);
                cmd.Parameters.AddWithValue("@이메일", email.Text);
                cmd.Parameters.AddWithValue("@전화번호", phone.Text);
                cmd.Parameters.AddWithValue("@우편번호", psCode.Text);
                cmd.Parameters.AddWithValue("@주소", address.Text);
                cmd.Parameters.AddWithValue("@부서", dep.Text);
                cmd.Parameters.AddWithValue("@직위", position.Text);
                cmd.Parameters.AddWithValue("@사번", pNo.Text);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                
            }
                //삽입 OR 수정 후 그리드뷰 데이터바인딩
                GridView1.DataBind();

        }

        //삭제
        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            string sql = "DELETE FROM 회원관리 WHERE 사번 = @사번";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@사번", pNo.Text);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            TableReset();
            GridView1.DataBind();
        }

        private void TableReset()
        {
            pNo.Text = "";
            username.Text = "";
            front_SSNumber.Text = "";
            back_SSNumber.Text = "";
            email.Text = "";
            phone.Text = "";
            psCode.Text = "";
            address.Text = "";
            dep.Text = "--선택--";
            position.Text = "--선택--";
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "selectNumber")
            {
                string selectedNumber = e.CommandArgument.ToString();
                string sql = "SELECT * FROM 회원관리 WHERE 사번 = @사번";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@사번", selectedNumber);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                

                while (reader.Read())
                {
                    pNo.Text = reader["사번"].ToString();
                    username.Text = reader["성명"].ToString();
                    string FN = reader["주민번호"].ToString().Substring(0, 6);
                    string BN = reader["주민번호"].ToString().Substring(6, 7);
                    front_SSNumber.Text = FN;
                    back_SSNumber.Text = BN;
                    email.Text = reader["이메일"].ToString();
                    phone.Text = reader["전화번호"].ToString();
                    psCode.Text = reader["우편번호"].ToString();
                    address.Text = reader["주소"].ToString();
                    dep.Text = reader["부서"].ToString();
                    position.Text = reader["직위"].ToString();

                }

                conn.Close();
            }
        }
    }
}
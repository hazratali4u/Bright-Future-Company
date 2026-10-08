using System;
using System.Data;
using System.Web.UI;
using SAMSBusinessLayer.Classes;
using SAMSCommon.Classes;
using System.Web.UI.WebControls;


public partial class Forms_RptCustomerSaleCategoryWise : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            LoadLocation();
            LoadArea();
            LoadCreditCustomer();
            LoadPrincipal();
            LoadCategory();

            DateTime dt = (DateTime)Session["CurrentWorkDate"];

            txtStartDate.Text = dt.ToString("dd-MMM-yyyy");
            txtEndDate.Text = dt.ToString("dd-MMM-yyyy");

            txtStartDate.Attributes.Add("readonly", "readonly");

            txtEndDate.Attributes.Add("readonly", "readonly");
        }
    }

    protected void LoadLocation()
    {
        try
        {
            DistributorController DController = new DistributorController();
            DataTable dt = DController.SelectDistributorInfo(Constants.IntNullValue, int.Parse(Session["UserId"].ToString()), int.Parse(Session["CompanyId"].ToString()));
            drpDistributor.DataSource = dt;
            drpDistributor.DataTextField = "DISTRIBUTOR_NAME";
            drpDistributor.DataValueField = "DISTRIBUTOR_ID";
            drpDistributor.DataBind();
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }
    private void LoadArea()
    {
        if (drpDistributor.Items.Count > 0)
        {
            ddlArea.Items.Clear();
            DistributorAreaController mController = new DistributorAreaController();
            DataTable dt = mController.SelectDist_Area(Constants.LongNullValue, Constants.DateNullValue, Constants.DateNullValue, int.Parse(drpDistributor.SelectedValue.ToString()), Constants.IntNullValue, null, null);
            ddlArea.Items.Add(new ListItem("All", Constants.IntNullValue.ToString()));
            clsWebFormUtil.FillDropDownList(ddlArea, dt, 0, 6);
        }
        else
        {
            ddlArea.Items.Clear();
        }
    }
    private void LoadCreditCustomer()
    {
        ddlCustomer.Items.Clear();
        if (drpDistributor.Items.Count > 0 && ddlArea.Items.Count > 0)
        {
            CustomerDataController mController = new CustomerDataController();
            DataTable dt = mController.SelectPrincipalCustomer(int.Parse(drpDistributor.SelectedValue.ToString()), int.Parse(ddlArea.SelectedValue.ToString()), Constants.IntNullValue, Constants.IntNullValue);
            ddlCustomer.Items.Add(new ListItem("All", Constants.IntNullValue.ToString()));
            clsWebFormUtil.FillDropDownList(ddlCustomer, dt, 0, 4);
        }
        else
        {
            ddlCustomer.Items.Add(new ListItem("Customer Not Found", Constants.IntNullValue.ToString()));
        }
    }
    protected void LoadPrincipal()
    {
        try
        {
            SKUPriceDetailController PController = new SKUPriceDetailController();
            DataTable m_dt = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(Session["CurrentWorkDate"].ToString()));
            drpPrincipal.Items.Add(new ListItem("All", Constants.IntNullValue.ToString()));
            clsWebFormUtil.FillDropDownList(drpPrincipal, m_dt, "Company_Id", "Company_Name");
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }

   
    private void LoadCategory()
    {
        ddlCategory.Items.Clear();
        SkuHierarchyController mController = new SkuHierarchyController();
        DataTable dt = mController.SelectSKUCategory(Convert.ToInt32(drpPrincipal.SelectedValue), Constants.SKUCategory);
        ddlCategory.Items.Add(new ListItem("All", Constants.IntNullValue.ToString()));
        clsWebFormUtil.FillDropDownList(ddlCategory, dt, "SKU_HIE_ID", "SKU_HIE_NAME");
    }
    protected void btnViewPDF_Click(object sender, EventArgs e)
    {
        try
        {
            SAMSBusinessLayer.Classes.DocumentPrintController DPrint = new SAMSBusinessLayer.Classes.DocumentPrintController();
            RptCustomerController RptCustomerCtl = new RptCustomerController();
            DataTable dt = DPrint.SelectReportTitle(int.Parse(drpDistributor.SelectedValue.ToString()));

            DateTime parsed_date_fromdate = DateTime.Parse(txtStartDate.Text);
            DateTime parsed_date_todate = DateTime.Parse(txtEndDate.Text);
            string FromDate = parsed_date_fromdate.ToShortDateString();
            string ToDate = parsed_date_todate.ToShortDateString();

            SAMSBusinessLayer.Reports.CrpCategoryWiseCustomerSale CrpReport = new SAMSBusinessLayer.Reports.CrpCategoryWiseCustomerSale();
            DataSet ds = null;
           

            ds = RptCustomerCtl.OutletWiseSale(int.Parse(drpPrincipal.SelectedValue.ToString()), Convert.ToInt32(drpDistributor.SelectedValue.ToString())
                , Convert.ToDateTime(FromDate + " 00:00:00"), Convert.ToDateTime(ToDate + " 00:00:00") , int.Parse(ddlArea.SelectedValue)
                , int.Parse(ddlCustomer.SelectedValue),int.Parse(ddlCategory.SelectedValue));

            CrpReport.SetDataSource(ds);
            CrpReport.Refresh();

            CrpReport.SetParameterValue("Principal", drpPrincipal.SelectedItem.Text.ToString());
            CrpReport.SetParameterValue("Branch", drpDistributor.SelectedItem.Text.ToString());
            CrpReport.SetParameterValue("CompanyName", dt.Rows[0]["COMPANY_NAME"].ToString());
            CrpReport.SetParameterValue("Area", ddlArea.SelectedItem.Text);
            CrpReport.SetParameterValue("Customer", ddlCustomer.SelectedItem.Text);
            CrpReport.SetParameterValue("Category", ddlCategory.SelectedItem.Text);
            CrpReport.SetParameterValue("FromDate", txtStartDate.Text);
            CrpReport.SetParameterValue("ToDate", txtEndDate.Text);

            Session.Add("CrpReport", CrpReport);
            Session.Add("ReportType", 0);
            string url = "'Default.aspx'";
            string script = "<script language='JavaScript' type='text/javascript'> window.open(" + url + ",\"Link\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=10,top=10\");</script>";
            Type cstype = GetType();
            ClientScriptManager cs = Page.ClientScript;
            cs.RegisterStartupScript(cstype, "OpenWindow", script);
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }

    protected void btnViewExcel_Click(object sender, EventArgs e)
    {
        try
        {
            SAMSBusinessLayer.Classes.DocumentPrintController DPrint = new SAMSBusinessLayer.Classes.DocumentPrintController();
            RptCustomerController RptCustomerCtl = new RptCustomerController();
            DataTable dt = DPrint.SelectReportTitle(int.Parse(drpDistributor.SelectedValue.ToString()));

            DateTime parsed_date_fromdate = DateTime.Parse(txtStartDate.Text);
            DateTime parsed_date_todate = DateTime.Parse(txtEndDate.Text);
            string FromDate = parsed_date_fromdate.ToShortDateString();
            string ToDate = parsed_date_todate.ToShortDateString();


            SAMSBusinessLayer.Reports.CrpCategoryWiseCustomerSale CrpReport = new SAMSBusinessLayer.Reports.CrpCategoryWiseCustomerSale();
            DataSet ds = null;


            ds = RptCustomerCtl.OutletWiseSale(int.Parse(drpPrincipal.SelectedValue.ToString()), Convert.ToInt32(drpDistributor.SelectedValue.ToString())
                , Convert.ToDateTime(FromDate + " 00:00:00"), Convert.ToDateTime(ToDate + " 00:00:00"), int.Parse(ddlArea.SelectedValue)
                , int.Parse(ddlCustomer.SelectedValue), int.Parse(ddlCategory.SelectedValue));

            CrpReport.SetDataSource(ds);
            CrpReport.Refresh();

            CrpReport.SetParameterValue("Principal", drpPrincipal.SelectedItem.Text.ToString());
            CrpReport.SetParameterValue("Branch", drpDistributor.SelectedItem.Text.ToString());
            CrpReport.SetParameterValue("CompanyName", dt.Rows[0]["COMPANY_NAME"].ToString());
            CrpReport.SetParameterValue("Area", ddlArea.SelectedItem.Text);
            CrpReport.SetParameterValue("Customer", ddlCustomer.SelectedItem.Text);
            CrpReport.SetParameterValue("Category", ddlCategory.SelectedItem.Text);
            CrpReport.SetParameterValue("FromDate", txtStartDate.Text);
            CrpReport.SetParameterValue("ToDate", txtEndDate.Text);

            Session.Add("CrpReport", CrpReport);
            Session.Add("ReportType", 1);
            string url = "'Default.aspx'";
            string script = "<script language='JavaScript' type='text/javascript'> window.open(" + url + ",\"Link\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=10,top=10\");</script>";
            Type cstype = GetType();
            ClientScriptManager cs = Page.ClientScript;
            cs.RegisterStartupScript(cstype, "OpenWindow", script);
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }

    protected void drpDistributor_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        LoadArea();
    }

    protected void ddlArea_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadCreditCustomer();
    }

    protected void drpPrincipal_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadCategory();
    }

}
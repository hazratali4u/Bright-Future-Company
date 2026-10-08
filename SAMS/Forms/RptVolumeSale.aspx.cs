using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMSBusinessLayer.Classes;
using SAMSCommon.Classes;
using SAMSBusinessLayer.Reports;

/// <summary>
/// Form For Target Vs Achievement Report
/// </summary>
public partial class Forms_RptVolumeSale : System.Web.UI.Page
{
    /// <summary>
    /// Page_Load Function
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadRegion();
            LoadPrincipal();
            LoadLocation();
            DateTime dt = (DateTime)Session["CurrentWorkDate"];
            txtDate.Text = dt.ToString("MMM-yyyy");



           
        }
    }

    /// <summary>
    /// Loads Regions
    /// </summary>
    protected void LoadRegion()
    {
        GeoHierarchyController GControler = new GeoHierarchyController();
        DataTable dt = GControler.SelectGeoHierarchy(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, null, null, true, Constants.IntNullValue, Constants.Region, Constants.IntNullValue, Constants.DateNullValue, Constants.DateNullValue, int.Parse(Session["CompanyId"].ToString()));
        DrpRegion.Items.Add(new ListItem("All", Constants.IntNullValue.ToString()));
        clsWebFormUtil.FillDropDownList(DrpRegion, dt, 0, 4);
    }

    /// <summary>
    /// Loads Principals To Principal Combo
    /// </summary>
    protected void LoadPrincipal()
    {
        SKUPriceDetailController PController = new SKUPriceDetailController();
        DataTable m_dt = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(Session["CurrentWorkDate"].ToString()));
        drpPrincipal.Items.Add(new ListItem("All", Constants.IntNullValue.ToString()));
        clsWebFormUtil.FillDropDownList(drpPrincipal, m_dt, 0, 1);
        
    }

    /// <summary>
    /// Loads Locations To Location Combo
    /// </summary>
    protected void LoadLocation()
    {
        try
        {
            DistributorController DController = new DistributorController();
            DataTable dt = DController.SelectDistributorInfo(Constants.IntNullValue, int.Parse(Session["UserId"].ToString()), int.Parse(Session["CompanyId"].ToString()));
           
            clsWebFormUtil.FillDropDownList(DrpLocation, dt, 0, 2);
                
        }
        catch(Exception ex)
        {
            ex.ToString();
        }
    }
    
    /// <summary>
    /// Loads Locations
    /// </summary>
    protected void DrpRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadLocation(); 
    }


    private void GetDateMonth()
    {
        DateTime dtMonth = (DateTime)Session["CurrentWorkDate"];

        var CurrentMonth = dtMonth.Month + '-' + dtMonth.Year;

        var dtSelectMonth = DateTime.Parse(txtDate.Text);
        var dtToMonth2 = dtSelectMonth.Month + '-' + dtSelectMonth.Year;
        if (CurrentMonth == dtToMonth2)
        {
            DateTime Cdt = (DateTime)Session["CurrentWorkDate"];
            txtDate.Text = Cdt.ToString();//.ToString("dd-MMM-yyyy");
        }
    }
    /// <summary>
    /// Shows Target Vs Achievement in PDF
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnViewPDF_Click(object sender, EventArgs e)
    {
        try
        {
           GetDateMonth();

            SAMSBusinessLayer.Classes.DocumentPrintController DPrint = new SAMSBusinessLayer.Classes.DocumentPrintController();
            RptSaleController RptSaleCtl = new RptSaleController();

            DataTable dt = DPrint.SelectReportTitle(int.Parse(DrpLocation.SelectedValue.ToString()));

            SAMSBusinessLayer.Reports.CrpVolumeSalesDetail CrpReport = new SAMSBusinessLayer.Reports.CrpVolumeSalesDetail();

            DataSet ds = null;

            ds = RptSaleCtl.SelectVolumeSale(int.Parse(drpPrincipal.SelectedValue.ToString()), int.Parse(DrpLocation.SelectedValue.ToString()), Convert.ToDateTime(txtDate.Text), 0, int.Parse(Session["UserId"].ToString()), 0);
            CrpReport.SetDataSource(ds);
            CrpReport.Refresh();

            CrpReport.SetParameterValue("Location", DrpLocation.SelectedItem.Text.ToString());
            CrpReport.SetParameterValue("Principal", drpPrincipal.SelectedItem.Text.ToString());
            CrpReport.SetParameterValue("CompanyName", dt.Rows[0]["COMPANY_NAME"].ToString());

            DateTime TargetDate = (DateTime)Session["CurrentWorkDate"];
            txtDate.Text = TargetDate.ToString("MMM-yyyy");

            CrpReport.SetParameterValue("TargetDate", txtDate.Text);

            Session.Add("CrpReport", CrpReport);
            Session.Add("ReportType", 0);
            const string url = "'Default.aspx'";
            const string script = "<script language='JavaScript' type='text/javascript'> window.open(" + url + ",\"Link\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=10,top=10\");</script>";
            Type cstype = GetType();
            ClientScriptManager cs = Page.ClientScript;
            cs.RegisterStartupScript(cstype, "OpenWindow", script);
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }

    /// <summary>
    /// Shows Target Vs Achievement in Excel
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnViewExcel_Click(object sender, EventArgs e)
    {
        try
        {
            SAMSBusinessLayer.Classes.DocumentPrintController DPrint = new SAMSBusinessLayer.Classes.DocumentPrintController();
            RptSaleController RptSaleCtl = new RptSaleController();

            DataTable dt = DPrint.SelectReportTitle(int.Parse(DrpLocation.SelectedValue.ToString()));

            SAMSBusinessLayer.Reports.CrpVolumeSalesDetail CrpReport = new SAMSBusinessLayer.Reports.CrpVolumeSalesDetail();

            DataSet ds = null;

            ds = RptSaleCtl.SelectVolumeSale(int.Parse(drpPrincipal.SelectedValue.ToString()), int.Parse(DrpLocation.SelectedValue.ToString()), Convert.ToDateTime(txtDate.Text), 0, int.Parse(Session["UserId"].ToString()), 0);
            CrpReport.SetDataSource(ds);
            CrpReport.Refresh();

            CrpReport.SetParameterValue("Location", DrpLocation.SelectedItem.Text.ToString());
            CrpReport.SetParameterValue("Principal", drpPrincipal.SelectedItem.Text.ToString());
            CrpReport.SetParameterValue("CompanyName", dt.Rows[0]["COMPANY_NAME"].ToString());

            DateTime TargetDate = (DateTime)Session["CurrentWorkDate"];
            txtDate.Text = TargetDate.ToString("MMM-yyyy");

            CrpReport.SetParameterValue("TargetDate", txtDate.Text);

            Session.Add("CrpReport", CrpReport);
            Session.Add("ReportType", 1);
            const string url = "'Default.aspx'";
            const string script = "<script language='JavaScript' type='text/javascript'> window.open(" + url + ",\"Link\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=10,top=10\");</script>";
            Type cstype = GetType();
            ClientScriptManager cs = Page.ClientScript;
            cs.RegisterStartupScript(cstype, "OpenWindow", script);
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }    
}
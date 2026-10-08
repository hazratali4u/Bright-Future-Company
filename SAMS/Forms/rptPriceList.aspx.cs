using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SAMSBusinessLayer.Classes;
using SAMSCommon.Classes;
using SAMSBusinessLayer.Reports;

/// <summary>
/// Form For SKU Price List Report
/// </summary>
public partial class Forms_rptPriceList : System.Web.UI.Page
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
            //this.LoadDistributor();
            //LoadPrincipal();
            //LoadCatagory();
            this.DistributorType();
            this.LoadAssingned();
            this.LoadPrincipal();
            this.LoadCategory();
            this.LoadBrand();
            this.LoadSKU();
        }
    }

    /// <summary>
    /// Loads Location Types
    /// </summary>
    private void DistributorType()
    {
        DistributorController dController = new DistributorController();
        DataTable dt = dController.SelectDistributorTypeInfo(Constants.IntNullValue);
        clsWebFormUtil.FillDropDownList(ddDistributorType, dt, 0, 2);
    }
    /// <summary>
    /// Loads Locations To Location Combo
    /// </summary>
    private void LoadDistributor()
    {
        DistributorController DController = new DistributorController();
        DataTable dt = DController.SelectDistributorInfo(Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), int.Parse(this.Session["CompanyId"].ToString()));
        clsWebFormUtil.FillDropDownList(this.DrpDistributor, dt, 0, 2, true);
    }

    //protected void LoadCatagory()
    //{
    //    SkuHierarchyController Hierarchy = new SkuHierarchyController();
    //    DataTable dtCatagory = Hierarchy.SelectSkuHierarchyView(5, int.Parse(this.Session["CompanyId"].ToString()));
    //    DataView dv = new DataView(dtCatagory);
    //    dv.RowFilter = "Company_id = " + Convert.ToInt32(drpPrincipal.SelectedValue.ToString());
    //    dtCatagory = dv.ToTable();
    //    this.DrpCatagory.Items.Add(new ListItem("All", Constants.IntNullValue.ToString()));
    //    clsWebFormUtil.FillDropDownList(this.DrpCatagory, dtCatagory, "Category_Id", "Category_Name");
    //}

    //protected void LoadPrincipal()
    //{
    //    try
    //    {
    //        SKUPriceDetailController PController = new SKUPriceDetailController();
    //        DataTable m_dt = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()));
    //        //this.drpPrincipal.Items.Add(new ListItem("All", "0"));
    //        clsWebFormUtil.FillDropDownList(this.drpPrincipal, m_dt, "Company_Id", "Company_Name");
    //    }
    //    catch (Exception ex)
    //    {
    //        ex.ToString();
    //    }
    //}

    /// <summary>
    /// Loads SKU Categories
    /// </summary>
    /// 
    /// <summary>
    /// Loads User Assigned Locations To Location Combo
    /// </summary>
    private void LoadAssingned()
    {
        if (ddDistributorType.Items.Count > 0)
        {
            DrpDistributor.Items.Clear();
            UserController mUserController = new UserController();
            DataTable dt = mUserController.SelectUserAssignment(int.Parse(this.Session["UserId"].ToString()), int.Parse(ddDistributorType.SelectedValue.ToString()), 1, int.Parse(this.Session["CompanyId"].ToString()));
            DrpDistributor.Items.Add(new ListItem("All", Constants.IntNullValue.ToString()));
            clsWebFormUtil.FillDropDownList(DrpDistributor, dt, 0, 1);
        }
    }

    /// <summary>
    /// Loads Principals To Principal Combo
    /// </summary>
    private void LoadPrincipal()
    {
        SKUPriceDetailController PController = new SKUPriceDetailController();
        DataTable m_dt = PController.SelectDataPrice(Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()), Constants.IntNullValue, 0, DateTime.Parse(this.Session["CurrentWorkDate"].ToString()));
        clsWebFormUtil.FillListBox(this.cblPrincipal, m_dt, 0, 1);

        foreach (ListItem li in cblPrincipal.Items)
        {
            li.Selected = true;
        }
    }

    private void LoadCategory()
    {
        string PrincipalIDs = null;
        foreach (ListItem li in cblPrincipal.Items)
        {
            if (li.Selected)
            {
                PrincipalIDs += li.Value + ",";
            }
        }

        SkuHierarchyController mHer_Controller = new SkuHierarchyController();
        DataTable dt = mHer_Controller.SelectSkuHierarchy(1, PrincipalIDs);
        clsWebFormUtil.FillListBox(cblCategory, dt, 0, 1, true);

        foreach (ListItem li in cblCategory.Items)
        {
            li.Selected = true;
        }
    }

    private void LoadBrand()
    {
        string CategoryIDs = null;
        foreach (ListItem li in cblCategory.Items)
        {
            if (li.Selected)
            {
                CategoryIDs += li.Value + ",";
            }
        }

        SkuHierarchyController mHer_Controller = new SkuHierarchyController();
        DataTable dt = mHer_Controller.SelectSkuHierarchy(2, CategoryIDs);
        clsWebFormUtil.FillListBox(cblBrand, dt, 0, 1, true);

        foreach (ListItem li in cblBrand.Items)
        {
            li.Selected = true;
        }
    }

    private void LoadSKU()
    {
        string BrandIDs = null;
        foreach (ListItem li in cblBrand.Items)
        {
            if (li.Selected)
            {
                BrandIDs += li.Value + ",";
            }
        }

        SkuHierarchyController mHer_Controller = new SkuHierarchyController();
        DataTable dt = mHer_Controller.SelectSkuHierarchy(3, BrandIDs);
        clsWebFormUtil.FillListBox(cblSKU, dt, 0, 1, true);

        foreach (ListItem li in cblSKU.Items)
        {
            li.Selected = true;
        }
    }

    protected void ddDistributorType_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadAssingned();
    }

    private void ShowReport(int ReportType)
    {
        System.Text.StringBuilder sbSKUs = new System.Text.StringBuilder();
        foreach (ListItem li in cblSKU.Items)
        {
            if (li.Selected)
            {
                sbSKUs.Append(li.Value);
                sbSKUs.Append(",");
            }
        }
        DocumentPrintController DPrint = new DocumentPrintController();
        RptSaleController RptSaleCtl = new RptSaleController();
        DataTable dt = DPrint.SelectReportTitle(int.Parse(DrpDistributor.SelectedValue.ToString()));
        if (rdbRateType.SelectedValue != "2")
        {
            CrpPriceList CrpReport = new CrpPriceList();
            DataSet ds = null;
            ds = RptSaleCtl.PriceList(int.Parse(ddDistributorType.SelectedItem.Value), sbSKUs.ToString(), int.Parse(DrpDistributor.SelectedValue.ToString()), Constants.IntNullValue, Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()),1);
            CrpReport.SetDataSource(ds);
            CrpReport.Refresh();
            CrpReport.SetParameterValue("reportTitle", "SKU Price List " + rdbRateType.SelectedItem.Text + " Wise");
            CrpReport.SetParameterValue("reportTypeTitle", DrpReportType.SelectedItem.Text);
            CrpReport.SetParameterValue("reportType", DrpReportType.SelectedValue);
            CrpReport.SetParameterValue("rateType", rdbRateType.SelectedValue);
            CrpReport.SetParameterValue("Branch", ddDistributorType.SelectedItem.Text);
            CrpReport.SetParameterValue("CompanyName", dt.Rows[0]["COMPANY_NAME"].ToString());
            Session.Add("CrpReport", CrpReport);
            Session.Add("ReportType", ReportType);
            const string url = "'Default.aspx'";
            const string script = "<script language='JavaScript' type='text/javascript'> window.open(" + url + ",\"Link\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=10,top=10\");</script>";
            Type cstype = this.GetType();
            ClientScriptManager cs = Page.ClientScript;
            cs.RegisterStartupScript(cstype, "OpenWindow", script);
        }
        else
        {
            CrpPriceList2 CrpReport = new CrpPriceList2();
            DataSet ds = null;
            ds = RptSaleCtl.PriceList(int.Parse(ddDistributorType.SelectedItem.Value), sbSKUs.ToString(), int.Parse(DrpDistributor.SelectedValue.ToString()), Constants.IntNullValue, Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()),1);
            CrpReport.SetDataSource(ds);
            CrpReport.Refresh();
            CrpReport.SetParameterValue("reportTitle", "SKU Price List Unit & Ctn Wise");
            CrpReport.SetParameterValue("reportTypeTitle", DrpReportType.SelectedItem.Text);
            CrpReport.SetParameterValue("reportType", DrpReportType.SelectedValue);
            CrpReport.SetParameterValue("rateType", rdbRateType.SelectedValue);
            CrpReport.SetParameterValue("Branch", ddDistributorType.SelectedItem.Text);
            CrpReport.SetParameterValue("CompanyName", dt.Rows[0]["COMPANY_NAME"].ToString());
            Session.Add("CrpReport", CrpReport);
            Session.Add("ReportType", ReportType);
            const string url = "'Default.aspx'";
            const string script = "<script language='JavaScript' type='text/javascript'> window.open(" + url + ",\"Link\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=10,top=10\");</script>";
            Type cstype = this.GetType();
            ClientScriptManager cs = Page.ClientScript;
            cs.RegisterStartupScript(cstype, "OpenWindow", script);
        }
    }

    protected void btnViewPDF_Click(object sender, EventArgs e)
    {
        ShowReport(0);        
    }

    /// <summary>
    /// Shows SKU Price List in Excel
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    protected void btnViewExcel_Click(object sender, EventArgs e)
    {
        RptSaleController RptSaleCtl = new RptSaleController();
        DataTable dt = null;
        System.Text.StringBuilder sbSKUs = new System.Text.StringBuilder();
        foreach (ListItem li in cblSKU.Items)
        {
            if (li.Selected)
            {
                sbSKUs.Append(li.Value);
                sbSKUs.Append(",");
            }
        }

        DataControl dc = new DataControl();
        if (rdbRateType.SelectedValue != "2")
        {
            dt = RptSaleCtl.PriceListDatatale(int.Parse(ddDistributorType.SelectedItem.Value), sbSKUs.ToString(), int.Parse(DrpDistributor.SelectedValue.ToString()), Constants.IntNullValue, Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()),2);
        }
        else
        {
            dt = RptSaleCtl.PriceListDatatale(int.Parse(ddDistributorType.SelectedItem.Value), sbSKUs.ToString(), int.Parse(DrpDistributor.SelectedValue.ToString()), Constants.IntNullValue, Constants.IntNullValue, int.Parse(this.Session["UserId"].ToString()),2);
        }
        DataSetToExcel dsexcel = new DataSetToExcel();
        string path = SAMSCommon.Classes.Configuration.GetAppInstallationPath() + "\\Exported.xls";
        DataSetToExcel.exportToExcel(dt, path);
        System.IO.FileInfo file = new System.IO.FileInfo(path);
        if (file.Exists)
        {
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
            Response.AddHeader("Content-Length", file.Length.ToString());
            Response.ContentType = "application/octet-stream";
            Response.WriteFile(file.FullName);
            Response.End();
        }
        else
        {
            Response.Write("This file does not exist.");
        }
    }

    protected void cbAllPrincipal_CheckedChanged(object sender, EventArgs e)
    {
        foreach (ListItem li in cblPrincipal.Items)
        {
            li.Selected = cbAllPrincipal.Checked;
        }
        cblPrincipal_SelectedIndexChanged(null, null);
    }

    protected void cbAllCategory_CheckedChanged(object sender, EventArgs e)
    {
        foreach (ListItem li in cblCategory.Items)
        {
            li.Selected = cbAllCategory.Checked;
        }
        cblCategory_SelectedIndexChanged(null, null);
    }

    protected void cbAllBrand_CheckedChanged(object sender, EventArgs e)
    {
        foreach (ListItem li in cblBrand.Items)
        {
            li.Selected = cbAllBrand.Checked;
        }
        cblBrand_SelectedIndexChanged(null, null);
    }

    protected void cbAllSKU_CheckedChanged(object sender, EventArgs e)
    {
        foreach (ListItem li in cblSKU.Items)
        {
            li.Selected = cbAllSKU.Checked;
        }
    }

    protected void cblPrincipal_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadCategory();
        this.LoadBrand();
        this.LoadSKU();
    }

    protected void cblCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadBrand();
        this.LoadSKU();
    }

    protected void cblBrand_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.LoadSKU();
    }    
}

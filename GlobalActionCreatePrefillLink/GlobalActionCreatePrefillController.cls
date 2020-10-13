global  class GlobalActionCreatePrefillController {
    public List<SelectOption> formstackForms {get;set;} 
    public string selectedFomstackForm{get;set;}
    public id recordId {get;set;}
    public string shortUrl {get;set;}
    public GlobalActionCreatePrefillController() 
    {
        formstackForms = getFormstackFormsList();
        recordId = ApexPages.currentPage().getParameters().get('id');
        shortUrl = GetPublicSiteUrl();
    }

    @RemoteAction 
    global static string createPrefillLink(string selectedForm, string recordId,string siteUrl){
        list<string> listRecordId = new list<string>{recordId};
            if(string.isEmpty(siteURL)){
                siteUrl = null;
            }
        map<string,string> prefilLink = VisualAntidote.FastFormsUtilities.generatePrefillUrlLink(selectedForm, listRecordId, siteUrl);
        
        return prefilLink.get(recordId);
    }
     public static String GetPublicSiteUrl(){
        String siteurl=''; 
		VisualAntidote__FastFormsAuth__c ffAuthCS = VisualAntidote__FastFormsAuth__c.getInstance('FastFormsNativeApp');
        if(ffAuthCS!=null && ffAuthCS.VisualAntidote__Site_Url__c!=null && ffAuthCS.VisualAntidote__Site_Url__c!=''){
            siteurl=ffAuthCS.VisualAntidote__Site_Url__c;
        }
        
        return siteurl;
    }
    public list<selectOption> getFormstackFormsList(){
        List<SelectOption> options = new List<SelectOption>();
        list<VisualAntidote__Previous_Form__c> listOfForm = [select id, name from VisualAntidote__Previous_Form__c where VisualAntidote__Draft_Form__c = null];
        for(sObject Forms : listOfForm)
        {
            string formName = (string)Forms.get('Name');
            options.add(new SelectOption(Forms.id, formName));
        }
        return options;
    }

}
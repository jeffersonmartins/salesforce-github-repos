/**
 * @description       : Classe responsável por realizar a sincronização dos repositórios do github com mais estrelas.
 * @author            : Jefferson Martins
 * @group             : 
 * @last modified on  : 12-28-2021
 * @last modified by  : Jefferson Martins
**/
public class RepositoryService_Callout {
    private final static String URL_REPOSITORIES = 'https://api.github.com/search/repositories?q=language:Java&sort=stars&per_page=100&page={0}';
    private final static String METHOD_GET = 'GET';

    @future(callout=true)
    public static void getRepositories() {
        List<Repository__c> repositoriesList = new List<Repository__c>();
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        Boolean hasMorePage = true;
        Integer pageNumber = 1;
        while (hasMorePage) {

            request.setEndpoint(String.format(URL_REPOSITORIES, new List<String>{String.valueOf(pageNumber)}));
            request.setMethod(METHOD_GET);

            HttpResponse response = http.send(request);
            hasMorePage = response.getStatusCode() == 200;
            
            if (!hasMorePage) {
                break;
            }

            Map<String, Object> repositories = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            List<Object> repositoriesItems = (List<Object>)repositories.get('items');            
    
            for (Integer i = 0; i < repositoriesItems.size(); i++) {
                Map<String, Object> repository = (Map<String, Object>)repositoriesItems[i];
                Map<String, Object> owner = (Map<String, Object>)repository.get('owner');
                Repository__c repositoryObj = new Repository__c(Name = (String)repository.get('name'),
                                                                Stargazers_Count__c = (Integer)repository.get('stargazers_count'),
                                                                Forks_Count__c =  (Integer)repository.get('forks_count'),
                                                                GitHub_Id__c = (Integer)repository.get('id'),
                                                                Language__c = (String)repository.get('language'),
                                                                Url__c = (String)repository.get('html_url'),
                                                                Owner_Login__c = (String)owner.get('login')
                                                                );
                
                repositoriesList.add(repositoryObj);            
            }  

            pageNumber++;
        }

        if (repositoriesList.size() > 0) {
            delete [SELECT Id FROM Repository__c];
        
            insert repositoriesList;
        }
    }

}

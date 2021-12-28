/**
 * @description       : Classe para testar o agendamento da sincronização
 * @author            : Jefferson Martins
 * @group             : 
 * @last modified on  : 12-28-2021
 * @last modified by  : Jefferson Martins
**/
@IsTest
public class Repository_SchedulableTest {

    private class CalloutMock implements HttpCalloutMock {
        public HttpResponse respond(System.HttpRequest req) {
            if (req.getEndpoint().endsWith('page=1')) {
                HttpResponse res = new HttpResponse();
                res.setBody(
                    '{'+
                    '    "total_count": 10763827,'+
                    '    "incomplete_results": true,'+
                    '    "items": ['+
                    '      {'+
                    '        "id": 121395510,'+
                    '        "node_id": "MDEwOlJlcG9zaXRvcnkxMjEzOTU1MTA=",'+
                    '        "name": "CS-Notes",'+
                    '        "full_name": "CyC2018/CS-Notes",'+
                    '        "private": false,'+
                    '        "owner": {'+
                    '          "login": "CyC2018"'+
                    '    },'+
                    '    "html_url": "https://github.com/CyC2018/CS-Notes",'+
                    '    "stargazers_count": 115925,'+
                    '    "language": "Java",'+
                    '    "forks_count": 49260 '+      
                    '  },'+
                    '  {'+
                    '    "id": 132464395,'+
                    '        "node_id": "MDEwOlJlcG9zaXRvcnkxMzI0NjQzOTU=",'+
                    '        "name": "JavaGuide",'+
                    '        "full_name": "Snailclimb/JavaGuide",'+
                    '        "private": false,'+
                    '        "owner": {'+
                    '          "login": "Snailclimb"'+
                    '        },'+
                    '        "html_url": "https://github.com/Snailclimb/JavaGuide",'+
                    '        "stargazers_count": 114945,'+
                    '        "language": "Java",'+
                    '        "forks_count": 39260'+
                    '      }'+
                    '    ]'+
                    '  }'
                );
                res.setStatusCode(200);
                return res;
            } else {
                HttpResponse res = new HttpResponse();
                res.setBody('{}');
                res.setStatusCode(422);
                return res;                
            }
        }
    }
    
    @IsTest
    public static void SchedulerTest() {
        Test.setMock(HttpCalloutMock.class, new CalloutMock());
        
        Test.startTest();
        Boolean scheduled = ScheduleSynchronizationTime.scheduleTime('22:00:00.000');
        Test.stopTest();
        System.assertEquals(true, scheduled, 'was expected true, but found ' + scheduled);

        // Chamada para testar cancelamento da anterior
        ScheduleSynchronizationTime.scheduleTime('22:00:00.000');
        
    }

    @IsTest
    public static void SchedulerFailTest() {
        Test.setMock(HttpCalloutMock.class, new CalloutMock());
        
        Test.startTest();
        Boolean scheduled = ScheduleSynchronizationTime.scheduleTime('1A:00:00.000');
        Test.stopTest();
        System.assertEquals(false, scheduled, 'was expected false, but found ' + scheduled);

        
    }
}

import JsonTool from './JsonTool.js';
import PropertiesTool from './PropertiesTool.js';
import ResponseTool from './ResponseTool.js';
import ServiceTool from './ServiceTool.js';

class DocumentTool {

    async insert () {

        let propertiesTool = new PropertiesTool ();

        let collection = await propertiesTool.get ('document.collection');
        let database = await propertiesTool.get ('document.database');
        let datasource = await propertiesTool.get ('document.datasource');
        let host = await propertiesTool.get ('document.host');
        let token = await propertiesTool.get ('document.token');

        host = host + 'action/insertOne';

        let headers = new JsonTool ();

        headers.add ('content-type', 'application/ejson');
        headers.add ('api-key', token);

        let params = new JsonTool ();

        params.add ('collection', collection);
        params.add ('database', database);
        params.add ('dataSource', datasource);
        params.add ('document', {
            'text': 'Hello from the Data API!'
        });

        let serviceTool = new ServiceTool ();

        let result;

        try {

            result = await serviceTool.post (host, headers, params);

        } catch (error) {

            result = ResponseTool.DOCUMENT_EXCEPTION ();

        }
console.log(result);
        return result;

    }

}

export default DocumentTool;
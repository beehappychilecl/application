import JsonToolkit from '../toolkit/JsonToolkit.js';
import PropertiesToolkit from '../toolkit/PropertiesToolkit.js';
import ResponseToolkit from '../toolkit/ResponseToolkit.js';
import ServiceToolkit from '../toolkit/ServiceToolkit.js';

class DocumentToolkit {

    async add () {

        let propertiesToolkit = new PropertiesToolkit ();

        let collection = await propertiesToolkit.get ('document.collection');
        let database = await propertiesToolkit.get ('document.database');
        let datasource = await propertiesToolkit.get ('document.datasource');
        let host = await propertiesToolkit.get ('document.host');
        let token = await propertiesToolkit.get ('document.token');

        host = host + 'action/find';

        let headers = new JsonToolkit ();

        headers.add ('content-type', 'application/ejson');
        headers.add ('api-key', token);

        let params = new JsonToolkit ();

        params.add ('collection', collection);
        params.add ('database', database);
        params.add ('dataSource', datasource);
        //params.add ('filter', '{"_id":"10570041"}');
        params.add ('limit', 10);

        let serviceToolkit = new ServiceToolkit ();

        let result;

        try {

            result = await serviceToolkit.post (host, headers, params);

        } catch (error) {

            result = ResponseToolkit.DOCUMENT_EXCEPTION ();

        }

        return result;

    }

}

export default DocumentToolkit;
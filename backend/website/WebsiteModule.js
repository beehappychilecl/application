import DatabaseToolkit from '../toolkit/DatabaseToolkit.js';

class WebsiteModule {

    async staff (params) {

        let databaseToolkit = new DatabaseToolkit ();

        let result = await databaseToolkit.run ('website_get_name_information', params);

        return result;

    }

}

export default WebsiteModule;
import {MongoClient} from "mongodb";

import PropertiesTool from '../toolkit/PropertiesTool.js';

class DocumentTool {

    async insert (data) {

        let propertiesTool = new PropertiesTool ();

        let collection = await propertiesTool.get ('document.collection');
        let database = await propertiesTool.get ('document.database');
        let host = await propertiesTool.get ('document.host');

        let mongoClient = new MongoClient (host);

        await mongoClient.connect ();

        let mongoDatabase = mongoClient.db (database);

        let mongoCollection = mongoDatabase.collection (collection);

        await mongoCollection.insertOne (data);

        await mongoClient.close ();

    }

}

export default DocumentTool;
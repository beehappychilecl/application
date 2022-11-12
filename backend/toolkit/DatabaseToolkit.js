import pg from 'pg';

import PropertiesToolkit from '../toolkit/PropertiesToolkit.js';
import ResponseToolkit from '../toolkit/ResponseToolkit.js';

class DatabaseToolkit {

    async exe (line, content) {

        let propertiesToolkit = new PropertiesToolkit ();

        let connections = await propertiesToolkit.get ('database.connections');
        let database = await propertiesToolkit.get ('database.database');
        let host = await propertiesToolkit.get ('database.host');
        let pass = await propertiesToolkit.get ('database.pass');
        let port = await propertiesToolkit.get ('database.port');
        let user = await propertiesToolkit.get ('database.user');

        let postgresql = new pg.Pool ({
            database: database,
            host: host,
            max: connections,
            password: pass,
            port: port,
            user: user
        });

        let result;

        try {

            await postgresql.query (content);

            result = ResponseToolkit.REBUILD_SUCCESSFUL (line)

        } catch (error) {

            result = ResponseToolkit.REBUILD_FAILED (line)

        }

        await postgresql.end ();

        return result;

    }

    async run (procedure, params) {

        let propertiesToolkit = new PropertiesToolkit ();

        let connections = await propertiesToolkit.get ('database.connections');
        let database = await propertiesToolkit.get ('database.database');
        let host = await propertiesToolkit.get ('database.host');
        let pass = await propertiesToolkit.get ('database.pass');
        let port = await propertiesToolkit.get ('database.port');
        let user = await propertiesToolkit.get ('database.user');

        let postgresql = new pg.Pool ({
            database: database,
            host: host,
            max: connections,
            password: pass,
            port: port,
            user: user
        });

        let result;

        try {

            //pool.query ("select * from " + procedure + " ($1)", [params], function (error, result) {
            result = await postgresql.query ('select now()', null);
            result = result.rows[0];

        } catch (error) {

            result = ResponseToolkit.DATABASE_EXCEPTION ();

        }

        await postgresql.end ();

        return result;

    }

}

export default DatabaseToolkit;
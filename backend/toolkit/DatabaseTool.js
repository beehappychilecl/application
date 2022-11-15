import pg from 'pg';

import PropertiesTool from './PropertiesTool.js';
import ResponseTool from './ResponseTool.js';

class DatabaseTool {

    async exe (line, content) {

        let propertiesTool = new PropertiesTool ();

        let connections = await propertiesTool.get ('database.connections');
        let database = await propertiesTool.get ('database.database');
        let host = await propertiesTool.get ('database.host');
        let pass = await propertiesTool.get ('database.pass');
        let port = await propertiesTool.get ('database.port');
        let user = await propertiesTool.get ('database.user');

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

            result = ResponseTool.REBUILD_SUCCESSFUL (line)

        } catch (error) {

            result = ResponseTool.REBUILD_FAILED (line)

        }

        await postgresql.end ();

        return result;

    }

    async run (procedure, params) {

        let propertiesTool = new PropertiesTool ();

        let connections = await propertiesTool.get ('database.connections');
        let database = await propertiesTool.get ('database.database');
        let host = await propertiesTool.get ('database.host');
        let pass = await propertiesTool.get ('database.pass');
        let port = await propertiesTool.get ('database.port');
        let user = await propertiesTool.get ('database.user');

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

            result = await postgresql.query ("select * from " + procedure + " ($1)", [params.all ()]);
            result = result.rows[0][procedure];

        } catch (error) {

            result = ResponseTool.DATABASE_EXCEPTION ();

        }

        await postgresql.end ();

        return result;

    }

}

export default DatabaseTool;
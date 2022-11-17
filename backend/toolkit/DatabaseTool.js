import pg from 'pg';

import LogTool from "../toolkit/LogTool.js";
import PropertiesTool from '../toolkit/PropertiesTool.js';
import ResponseTool from '../toolkit/ResponseTool.js';

class DatabaseTool {

    async exe (traceTool, line, content) {

        let logTool = new LogTool ('DatabaseTool', 'exe', traceTool);

        await logTool.initialize ();

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

        await logTool.realize (result);
        await logTool.finalize ();

        return result;

    }

    async run (traceTool, procedure, params) {

        let logTool = new LogTool ('DatabaseTool', 'run', traceTool);

        await logTool.initialize ();

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

        await logTool.realize (result);
        await logTool.finalize ();

        return result;

    }

}

export default DatabaseTool;
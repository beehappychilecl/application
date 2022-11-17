import ResponseTool from '../toolkit/ResponseTool.js';
import ServiceTool from '../toolkit/ServiceTool.js';
import LogTool from "../toolkit/LogTool.js";
import JsonTool from "../toolkit/JsonTool.js";

class ScheduleModule {

    async awake (traceTool, host) {

        let logTool = new LogTool ('ScheduleModule', 'awake', traceTool);

        await logTool.initialize ();

        let serviceTool = new ServiceTool ();

        let params = new JsonTool ();

        params.add ('level', traceTool.level);
        params.add ('thread', traceTool.thread);

        let result;

        try {

            result = await serviceTool.get (logTool.traceTool, host, null, params);
            result = result.data;

        } catch (error) {

            result = ResponseTool.WORKFLOW_EXCEPTION ('ScheduleModule', 'awake');

        }

        await logTool.realize (result);
        await logTool.finalize ();

        return result;

    }

    async dollarIndicator (traceTool, host, params) {

        let logTool = new LogTool ('ScheduleModule', 'dollarIndicator', traceTool);

        await logTool.initialize ();

        let serviceTool = new ServiceTool ();

        let result;

        try {

            result = await serviceTool.get (logTool.traceTool, host, null, params);
            result = result.Dolares;

        } catch (error) {

            result = ResponseTool.WORKFLOW_EXCEPTION ('ScheduleModule', 'dollarIndicator');

        }

        await logTool.realize (result);
        await logTool.finalize ();

        return result;

    }

    async euroIndicators (traceTool, host, params) {

        let logTool = new LogTool ('ScheduleModule', 'euroIndicators', traceTool);

        await logTool.initialize ();

        let serviceTool = new ServiceTool ();

        let result;

        try {

            result = await serviceTool.get (logTool.traceTool, host, null, params);
            result = result.Euros;

        } catch (error) {

            result = ResponseTool.WORKFLOW_EXCEPTION ('ScheduleModule', 'euroIndicators');

        }

        await logTool.realize (result);
        await logTool.finalize ();

        return result;

    }

    async fomentUnitIndicators (traceTool, host, params) {

        let logTool = new LogTool ('ScheduleModule', 'fomentUnitIndicators', traceTool);

        await logTool.initialize ();

        let serviceTool = new ServiceTool ();

        let result;

        try {

            result = await serviceTool.get (logTool.traceTool, host, null, params);
            result = result.UFs;

        } catch (error) {

            result = ResponseTool.WORKFLOW_EXCEPTION ('ScheduleModule', 'fomentUnitIndicators');

        }

        await logTool.realize (result);
        await logTool.finalize ();

        return result;

    }

    async monthlyTaxUnitIndicators (traceTool, host, params) {

        let logTool = new LogTool ('ScheduleModule', 'monthlyTaxUnitIndicators', traceTool);

        await logTool.initialize ();

        let serviceTool = new ServiceTool ();

        let result;

        try {

            result = await serviceTool.get (logTool.traceTool, host, null, params);
            result = result.UTMs;

        } catch (error) {

            result = ResponseTool.WORKFLOW_EXCEPTION ('ScheduleModule', 'monthlyTaxUnitIndicators');

        }

        await logTool.realize (result);
        await logTool.finalize ();

        return result;

    }

}

export default ScheduleModule;
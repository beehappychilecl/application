import ResponseTool from '../toolkit/ResponseTool.js';
import ServiceTool from '../toolkit/ServiceTool.js';

class ScheduleModule {

    async dollarIndicator (host, params) {

        let serviceTool = new ServiceTool ();

        let result;

        try {

            result = await serviceTool.get (host, null, params);
            result = result.data;

        } catch (error) {

            result = ResponseTool.WORKFLOW_EXCEPTION ('ScheduleModule', 'dollarIndicator');

        }

        return result;

    }

    async euroIndicators (host, params) {

        let serviceTool = new ServiceTool ();

        let result;

        try {

            result = await serviceTool.get (host, null, params);
            result = result.data;

        } catch (error) {

            result = ResponseTool.WORKFLOW_EXCEPTION ('ScheduleModule', 'euroIndicators');

        }

        return result;

    }

    async fomentUnitIndicators (host, params) {

        let serviceTool = new ServiceTool ();

        let result;

        try {

            result = await serviceTool.get (host, null, params);
            result = result.data;

        } catch (error) {

            result = ResponseTool.WORKFLOW_EXCEPTION ('ScheduleModule', 'fomentUnitIndicators');

        }

        return result;

    }

    async monthlyTaxUnitIndicators (host, params) {

        let serviceTool = new ServiceTool ();

        let result;

        try {

            result = await serviceTool.get (host, null, params);
            result = result.data;

        } catch (error) {

            result = ResponseTool.WORKFLOW_EXCEPTION ('ScheduleModule', 'monthlyTaxUnitIndicators');

        }

        return result;

    }

    async uptime (host) {

        let serviceTool = new ServiceTool ();

        let result;

        try {

            result = await serviceTool.get (host, null, null);
            result = result.data;

        } catch (error) {

            result = ResponseTool.WORKFLOW_EXCEPTION ('ScheduleModule', 'monthlyTaxUnitIndicators');

        }

        return result;

    }

}

export default ScheduleModule;
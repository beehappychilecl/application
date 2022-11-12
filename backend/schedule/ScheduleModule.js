import ResponseToolkit from '../toolkit/ResponseToolkit.js';
import ServiceToolkit from '../toolkit/ServiceToolkit.js';

class ScheduleModule {

    async dollarIndicator (host, params) {

        let serviceToolkit = new ServiceToolkit ();

        let result;

        try {

            result = await serviceToolkit.get (host, null, params);
            result = result.data;

        } catch (error) {

            result = ResponseToolkit.WORKFLOW_EXCEPTION ('ScheduleModule', 'dollarIndicator');

        }

        return result;

    }

    async euroIndicators (host, params) {

        let serviceToolkit = new ServiceToolkit ();

        let result;

        try {

            result = await serviceToolkit.get (host, null, params);
            result = result.data;

        } catch (error) {

            result = ResponseToolkit.WORKFLOW_EXCEPTION ('ScheduleModule', 'euroIndicators');

        }

        return result;

    }

    async fomentUnitIndicators (host, params) {

        let serviceToolkit = new ServiceToolkit ();

        let result;

        try {

            result = await serviceToolkit.get (host, null, params);
            result = result.data;

        } catch (error) {

            result = ResponseToolkit.WORKFLOW_EXCEPTION ('ScheduleModule', 'fomentUnitIndicators');

        }

        return result;

    }

    async monthlyTaxUnitIndicators (host, params) {

        let serviceToolkit = new ServiceToolkit ();

        let result;

        try {

            result = await serviceToolkit.get (host, null, params);
            result = result.data;

        } catch (error) {

            result = ResponseToolkit.WORKFLOW_EXCEPTION ('ScheduleModule', 'monthlyTaxUnitIndicators');

        }

        return result;

    }

    async uptime (host) {

        let serviceToolkit = new ServiceToolkit ();

        let result;

        try {

            result = await serviceToolkit.get (host, null, null);
            result = result.data;

        } catch (error) {

            result = ResponseToolkit.WORKFLOW_EXCEPTION ('ScheduleModule', 'monthlyTaxUnitIndicators');

        }

        return result;

    }

}

export default ScheduleModule;
import axios from "axios";
import constants from '../toolkit/constants.js';

const indicators = async function () {

    console.log ('function indicators');

    return null;

};

const uptime = async function () {

    let result = await axios.get (constants.service_uptime);

    return result.data;

};

export default {
    indicators,
    uptime
};
const scheduler_indicators = '* 0 0,6,12,18 * * *';
const scheduler_uptime = '0 */10 * * * *';
const server_port = 8080;
//const service_uptime = 'http://127.0.0.1:8080/system/uptime';
const service_uptime = 'https://bee.onrender.com/system/uptime';

export default {
    scheduler_indicators,
    scheduler_uptime,
    server_port,
    service_uptime
}
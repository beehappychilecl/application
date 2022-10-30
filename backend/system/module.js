const uptime = async function (request, response) {

    let uptime = process.uptime ();

    let days = Math.floor (uptime / 86400);

    let time = new Date (uptime * 1000).toISOString ().slice (11, 19);

    let result = {outgoing: {}, status: {sys_result: 0, sys_message: "OK"}}

    result ['outgoing'] ['sys_uptime'] = ''.concat (days.toString (), '.', time);

    response.end (JSON.stringify (result));

};

export default {
    uptime
};
import express from 'express';
import module from '../system/module.js';

const router = express.Router ();

router.get ('/system/uptime', module.uptime);

export default router;
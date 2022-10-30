import express from 'express';
import module from './module.js';

const router = express.Router ();

router.get ('/system/wakeup', module.wakeup);

export default router;
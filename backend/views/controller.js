import express from "express";

const router = express.Router ();

router.get ('/', (request, response) => {
    response.render ('pages/landing/landing.ejs');
});

export default router;
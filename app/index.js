const puppeteer = require("puppeteer");
const express = require('express')
const { performance } = require('perf_hooks');

const app = express();
const port = process.env.PORT || 3000

const launchAndClose = async (headless) => {
  const time = performance.now();
  const browser = await puppeteer.launch({
    headless,
    args: ["--no-sandbox", '--disable-setuid-sandbox', "--disable-gpu"],
  });

  // cleanup
  await Promise.all((await browser.pages()).map(page => page.close()));
  await browser.close();
  return performance.now() - time
}

app.get('/', async (req, res) => {

  const headless = await launchAndClose(true)
  const headfull = await launchAndClose(false)

  res.send({ headless, headfull })
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})
const puppeteer = require("puppeteer");
const express = require('express')
const { performance } = require('perf_hooks');

const app = express();
const port = process.env.PORT || 3000

const launchAndClose = async () => {
  const browser = await puppeteer.launch({
    headless: true,
    args: ["--no-sandbox"],
  });

  // cleanup
  await Promise.all((await browser.pages()).map(page => page.close()));
  await browser.close();
}

app.get('/', async (req, res) => {
  const time = performance.now();
  await launchAndClose()
  res.send({ time: performance.now() - time })
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})
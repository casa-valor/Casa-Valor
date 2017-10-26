const iconv = require('iconv-lite')
const cheerio = require('cheerio')

/**
 * Obter dados da OLX de acordo com os parâmetros definidos
 * 
 * @export
 * @param {string} uri 
 * @returns {any}
 */
module.exports = function (uri) {
  return {
    uri,
    encoding: null,
    transform: html => {
      return cheerio.load(iconv.decode(html, 'ISO-8859-1'), { decodeEntities: false })
    },
    headers: {
      'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
    }
  }
}
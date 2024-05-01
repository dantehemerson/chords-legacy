#!/usr/bin/node

'use strict';

/**
 * Uses the chords-db data to generate chords.
 * It results in a JSON file that can be used by the application.
 *
 * Source: https://github.com/tombatossals/chords-db
 */

const https = require('https');
const fs = require('fs');
const crypto = require('crypto');


const chordsJsonDir = `${__dirname}/../../lib/data/chords.json`;

async function downloadJSON() {
  const url = 'https://raw.githubusercontent.com/tombatossals/chords-db/master/lib/guitar.json';

  try {
    const response = await new Promise((resolve, reject) => {
      https.get(url, resolve).on('error', reject);
    });

    let data = '';

    response.on('data', (chunk) => {
      data += chunk;
    });

    return new Promise((resolve, reject) => {
      response.on('end', () => {
        try {
          const jsonData = JSON.parse(data);
          resolve(jsonData);
        } catch (error) {
          reject(error);
        }
      });

      response.on('error', (error) => {
        reject(error);
      });
    });
  } catch (error) {
    console.error('Error downloading JSON:', error);
    throw error;
  }
}

function generateUniqueId(chordName) {
  const hash = crypto.createHash('sha256');
  hash.update(chordName);
  return hash.digest('hex');
}

async function main() {
  const data = await downloadJSON();

  const chords = Object.values(data.chords).flat().map(chordData => {
    const chordName = `${chordData.key}${chordData.suffix}`;

    return {
      // Id is hashed from the chord name, to get always the same id for the same chord
      id: generateUniqueId(chordName),
      name: chordName,
      root: chordData.key,
      // No capo support(at the moment)
      positions: chordData.positions.filter(position => position.capo !== true).map(position => {
        return {
          frets: position.frets.map(fret => fret === -1 ? 'x' : fret.toString(16)).join(''),
          fingers: position.fingers.join(''),
          baseFret: position.baseFret,
        }
      })
    }
  });


  // ovewrite chordsJSONDir file
  fs.writeFileSync(chordsJsonDir, JSON.stringify(chords, null, 2));
}

main();
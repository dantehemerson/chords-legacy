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
const { Chord } = require('tonic.ts')

const chordsJsonDir = `${__dirname}/../../lib/data/chords.json`;
const chordsInfoJsonDir = `${__dirname}/../../lib/data/chords_info.json`;


async function downloadJSON() {
  const url = 'https://raw.githubusercontent.com/tombatossals/chords-db/b7028d7140ad8a1340f9138b51210d2417a6d8f0/lib/guitar.json';

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

  const dataChords = Object.values(data.chords).flat()
    // Ignore chords with slash, as they are not currently supported by the Chord library
    .filter(chord => !chord.suffix.includes('/'))

  const chords = dataChords
    .map(chordData => {
      const chordName = `${chordData.key} ${chordData.suffix}`;

      const suffix = suffixFixes[chordData.suffix] || chordData.suffix;

      const chordKey = `${chordData.key}${suffix}`;

      let chordInstance

      try {
        chordInstance = Chord.fromString(chordKey);
      } catch (error) {

        console.error('Error parsing chord:', chordName);
        return null;
      }

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
    }).filter(chord => chord !== null);



  // console.log({
  //   chord: Chord.fromString('Bma9(omit3)')
  // })

  const chordsInfo = {
    total: dataChords.length,
    count: chords.length,
    missingToParse: dataChords.length - chords.length,
  }

  // ovewrite chordsJSONDir file
  fs.writeFileSync(chordsJsonDir, JSON.stringify(chords, null, 2));
  fs.writeFileSync(chordsInfoJsonDir, JSON.stringify(chordsInfo, null, 2));
}

main();



var suffixFixes = {
  'major': 'Major',
  'minor': 'Minor',
  'sus': 'sus4',

  'maj9': 'M9',
  'maj11': 'M11',
  'maj13': 'M13',

  'mmaj7': 'min(maj7)',
  // 'mmaj9': 'min(maj9)',
  // 'mmaj11': 'min(maj11)',
  // 'mmaj13': 'min(maj13)',

  'm11': '11',
  'm69': '69',



}
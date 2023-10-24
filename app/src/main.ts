import {
    getData,
    formatData,
    sendData
} from './nasaApodFunctions';

async function main() {
    const imageOfTheDay = await getData();

    const body = formatData(imageOfTheDay);

    await sendData(body);
}

main();

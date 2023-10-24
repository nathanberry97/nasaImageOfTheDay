import axios from 'axios';
import twilio from 'twilio';
import { apodData } from "./types";
import 'dotenv/config';

export async function getData(): Promise<apodData>{

    const apiKey: string = process.env.NSAS_API_KEY!;

    try {
        const response = await axios.request({
            method: 'get',
            baseURL: `https://api.nasa.gov/planetary/apod?api_key=${apiKey}`
        });

        const nasaData: apodData = response.data;

        return(nasaData);
    } catch {
        throw new Error('Not okay');
    }
}

export function formatData(data: apodData): string{

    const date = data.date;
    const title = data.title;
    const explanation = data.explanation;
    const url = data.url;

    const formatedData =`NSAS APOD\n\n${date}\n\n${title}\n\n${explanation}\n\n${url}`;

    return(formatedData);
}

export async function sendData(data: string) {

    const accountSid: string = process.env.TWILIO_SID!;
    const authToken: string = process.env.TWILIO_AUTH_TOKEN!;
    const twilioNumber: string = process.env.TWILIO_NUMBER!;
    const personalNumber: string = process.env.PERSONAL_NUMBER!;

    const client = twilio(accountSid, authToken);

    await client.messages.create({
        body: data,
        to: personalNumber,
        from: twilioNumber,
    });
}

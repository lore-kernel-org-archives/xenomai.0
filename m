References: <mailman.117.1496166485.4225.xenomai@xenomai.org>
 <1496167354451.78382@kth.se>
 <e1ed397b-c902-7b7d-5d1c-e78d9c5f8bf0@xenomai.org>
 <1496226896420.15161@kth.se>
 <78c2df60-f9d8-ff4e-a53d-1b64e4af5c4a@xenomai.org>
 <1497222185664.65276@kth.se> <1497265336521.90775@kth.se>
 <af63a95f-4cb0-508c-7939-eea5b2f3c62d@xenomai.org>
 <1497445019861.76883@kth.se>
 <5e092673-0f50-a2d0-662a-c6702f732f20@xenomai.org>
 <1498646840487.52373@kth.se>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d5ed27c7-6db6-823c-cd52-81b6598f0e73@xenomai.org>
Date: Fri, 30 Jun 2017 21:40:01 +0200
MIME-Version: 1.0
In-Reply-To: <1498646840487.52373@kth.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem with gpio interrupts for xenomai3 on Intel
 joule
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nitin Kulkarni <nitink@kth.se>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/28/2017 12:47 PM, Nitin Kulkarni wrote:
> Hi Philippe,
> Thanks for the review and you comments are very helpful.
> I think my fix-up would just be fine for us as we just need one gpio interrupt to process SPI transfers
> with an XMOS microcontroller.
> 
> Hence my next challenge is to do SPI communication in real-time domain (My colleague
> Stefano once had a discussion over emails with you I think about streaming audio over SPI in realtime domain),
> I know that I will have to port the spi-pxa2xx platform driver to RTDM. 
> i was looking at the bcm2835 spi driver that you have ported for RTDM. 
> Is this a good reference to start ? 

At least to understand which handler need to be provided to Cobalt's
generic SPI core, yes.

-- 
Philippe.


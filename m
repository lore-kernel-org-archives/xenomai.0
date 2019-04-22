Subject: Re: rt_dev_send() stalls periodic task
References: <CA+K1mPFgaiP3fGFnd169MXhdRWo+a1TGz5fnEoj7MOCr11UbLQ@mail.gmail.com>
 <c6a9ba79-c7c5-195d-be1e-030fb44f5abc@siemens.com>
 <CA+K1mPEvKLN+gyDPwLE0OovtSn-iQ_BBZ86zQf12Fv65Ht5KbQ@mail.gmail.com>
 <2ade719a-84c7-c53d-9895-a5e6eea354a3@siemens.com>
 <CA+K1mPHhMrw-2t0k1_AgKE4iZ+2+Vvx7TV_ScHnOFis_sBxt=Q@mail.gmail.com>
 <5CBCCE3F.5090000@freyder.net>
 <CA+K1mPGZiuAvumxhdvKk2R=UvO9WwE_ppfkXeMaWLt7dP5hB3w@mail.gmail.com>
 <ebb4d71b-3d5b-9d66-270f-ca35e7785bce@web.de>
From: Steve Freyder <steve@freyder.net>
Message-ID: <5CBE1B46.3050804@freyder.net>
Date: Mon, 22 Apr 2019 14:51:34 -0500
MIME-Version: 1.0
In-Reply-To: <ebb4d71b-3d5b-9d66-270f-ca35e7785bce@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 4/22/2019 1:45 AM, Jan Kiszka wrote:
> On 22.04.19 08:40, C Smith via Xenomai wrote:
>> Thanks for your insight, Steve. I didn't realize rt_dev_write() doesnt
>> actually stall until it is called many times and the 4K TX buffer gets
>> full. (is that right Jan?)
>> It that is the case, sure I could find a way to check the TX buffer fill
>> level to prevent my app from stalling.
>>
>> I rewrote the xeno_16550A driver RTSER_RTIOC_GET_STATUS ioctl to 
>> return to
>> userspace the contents of the IIR and the IER too.
>> I'm getting IIR = 0b 0001 0100, so the source of the latest interrupt 
>> is a
>> RX (not surprising, as I'm doing full duplex) and there is no THRE
>> interrupt pending.
>> So regardless of the ultimate cause, this state will never empty the TX
>> buffer.
>>
>> I think my only choice is to try something I had to do once before on a
>> similarly misbehaving serial port: I'll rewrite the xeno_16550A 
>> interrupt
>> handlers to redundantly check for data pending in the TX buffer whenever
>> any interrupt like an RX interrupt happens. I do have bidirectional 
>> traffic
>> after all, so the driver will wake up frequently and keep the TX data
>> transmitting.
>>
>> Interesting enough, the stall problem did not occur when I used the 
>> sample
>> serial code provided by xenomai: cross-link.c . I also rewrote 
>> cross-link.c
>> to send a 72 byte packet and receive on the same port (I installed a
>> physical loopback device on the serial port). No stalls for 12+ hours 
>> with
>> packets streaming at 100 Hz.
>> The only difference in the serial configuration between that 
>> cross-link.c
>> app and my app was :
>> struct rtser_config :
>>          .rx_timeout        = RTSER_DEF_TIMEOUT  // infinite , no 
>> stall for
>> many hours in cross-link.c
>> versus:
>>          .rx_timeout        = 500000   // 500us, stalls within an 
>> hour in my
>> app
>> I don't know why an RX setting affects TX behavior. I also can't use
>> RTSER_DEF_TIMEOUT in my application or it dies when it starts up - no 
>> clue
>> why.  But I did try setting
>>    .rx_timeout        = 5000000   // 5 ms. my app doesnt stall for 
>> several
>> hours
>> and though that did not cause the serial to stall in my app for several
>> hours of testing, it is just open-loop finger-crossing, and not a real
>> solution.
>> I need the TX interrupts to fire reliably. So I think I must rewrite 
>> that
>> interrupt handler, as above.
>>
>
> I think we have a race between rt_16550_write filling the software 
> queue that
> the tx interrupt is supposed to write out and the latter already firing,
> consuming that event without seeing the queue filled. I'll think about 
> a better
> algorithm tomorrow, one that can possibly get rid of some interrupt 
> events as well.
>
> Jan
>
Greetings again,

If cross-link.c is not stalling, but the CSmith application hangs on
startup when using similar settings to what cross-link.c is using, it
tells me that understanding why this "hang on startup" is happening
would be a good idea.  I know this has happened to me when I got an
event from a UART that my code did not handle, and because I did not
handle it, the event continued to fire over and over - a hang. I
theorized that perhaps there's an issue with there being stale data
or a data overrun condition that exists when the app starts up that's
causing this hang.  In either case, it sounds as though the difference
in settings between CSmith app and cross-link.c might be a key factor.

I went back to the previous email trail, and if I interpreted it
correctly, the overall data rate is only about 80% of 115Kbaud. This
suggests that every time there is a write, the 4K software buffer in
the driver should be completely empty - as should the TX FIFO. The
only time that won't be true is when the transmit processing got
stalled (by loss of interrupt, or whatever).

I would be interested to see what happens if the CSmith app
were to be modified to write one byte at a time, with no delay
between rt_dev_write() calls.

Finally, some searching shows that back when the original National
Semiconductor 16550[A] UARTs were first being "cloned" by other
vendors, National created a program called "COMTEST" that was
designed to reveal the "misbehaviour" of those competing chips by
doing extensive testing of the timing and other characteristics and
how it deviated from "the real thing".  I wonder if anyone in this
group knows where a copy of that program (or a more modern version)
might exist?

Regards,
Steve



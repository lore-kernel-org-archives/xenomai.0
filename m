MIME-Version: 1.0
References: <CA+K1mPFgaiP3fGFnd169MXhdRWo+a1TGz5fnEoj7MOCr11UbLQ@mail.gmail.com>
 <c6a9ba79-c7c5-195d-be1e-030fb44f5abc@siemens.com>
 <CA+K1mPEvKLN+gyDPwLE0OovtSn-iQ_BBZ86zQf12Fv65Ht5KbQ@mail.gmail.com>
 <2ade719a-84c7-c53d-9895-a5e6eea354a3@siemens.com>
 <CA+K1mPHhMrw-2t0k1_AgKE4iZ+2+Vvx7TV_ScHnOFis_sBxt=Q@mail.gmail.com>
 <5CBCCE3F.5090000@freyder.net>
In-Reply-To: <5CBCCE3F.5090000@freyder.net>
From: C Smith <csmithquestions@gmail.com>
Date: Sun, 21 Apr 2019 23:40:08 -0700
Message-ID: <CA+K1mPGZiuAvumxhdvKk2R=UvO9WwE_ppfkXeMaWLt7dP5hB3w@mail.gmail.com>
Subject: Re: rt_dev_send() stalls periodic task
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Freyder <steve@freyder.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks for your insight, Steve. I didn't realize rt_dev_write() doesnt
actually stall until it is called many times and the 4K TX buffer gets
full. (is that right Jan?)
It that is the case, sure I could find a way to check the TX buffer fill
level to prevent my app from stalling.

I rewrote the xeno_16550A driver RTSER_RTIOC_GET_STATUS ioctl to return to
userspace the contents of the IIR and the IER too.
I'm getting IIR = 0b 0001 0100, so the source of the latest interrupt is a
RX (not surprising, as I'm doing full duplex) and there is no THRE
interrupt pending.
So regardless of the ultimate cause, this state will never empty the TX
buffer.

I think my only choice is to try something I had to do once before on a
similarly misbehaving serial port: I'll rewrite the xeno_16550A interrupt
handlers to redundantly check for data pending in the TX buffer whenever
any interrupt like an RX interrupt happens. I do have bidirectional traffic
after all, so the driver will wake up frequently and keep the TX data
transmitting.

Interesting enough, the stall problem did not occur when I used the sample
serial code provided by xenomai: cross-link.c . I also rewrote cross-link.c
to send a 72 byte packet and receive on the same port (I installed a
physical loopback device on the serial port). No stalls for 12+ hours with
packets streaming at 100 Hz.
The only difference in the serial configuration between that cross-link.c
app and my app was :
struct rtser_config :
        .rx_timeout        = RTSER_DEF_TIMEOUT  // infinite ,  no stall for
many hours in cross-link.c
versus:
        .rx_timeout        = 500000   // 500us, stalls within an hour in my
app
I don't know why an RX setting affects TX behavior. I also can't use
RTSER_DEF_TIMEOUT in my application or it dies when it starts up - no clue
why.  But I did try setting
  .rx_timeout        = 5000000   // 5 ms. my app doesnt stall for several
hours
and though that did not cause the serial to stall in my app for several
hours of testing, it is just open-loop finger-crossing, and not a real
solution.
I need the TX interrupts to fire reliably. So I think I must rewrite that
interrupt handler, as above.

-C Smith

Message-ID: <cbe23c50709140112q160c809alc398ed1b9a502c40@domain.hid>
Date: Fri, 14 Sep 2007 10:12:29 +0200
From: "Eric Noulard" <eric.noulard@domain.hid>
In-Reply-To: <46EA3253.3010901@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709130245m6c73abd3tc8023237e03f70f2@domain.hid>
	<cbe23c50709130434x127c8e86nfb061ac71555cd68@domain.hid>
	<46EA3253.3010901@domain.hid>
Subject: Re: [Xenomai-help] too fast write to serialport?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

2007/9/14, Jan Kiszka <jan.kiszka@domain.hid>:
> Eric Noulard wrote:
> > 2007/9/13, Bachman Kharazmi <bahkha@domain.hid>:
> >> Hi!
> >> I try to print to serialport using rtdm according to: http://pastebin.ca/695418
> >>
> >> But if I don't have sleep(1) only "hello   " or similar is written to
> >> the serialport.
> >> But if I've sleep(1) "helloworld" is written every second as expected.
> >
> > I'm no xenomai expert but I think
> > you shouldn't write to serial device in such a tight loop:
> >
> > while(counter <100){
> >         rt_dev_write(fd, myString, strlen(myString));
> >        printf("%d\n",counter);
> >       // sleep(1);  WITHOUT THIS SLEEP helloworld is sent on serial once.
> >      counter++;
> > }
>
> The _will_ work, but the problem is that pending bytes are dropped on
> rt_dev_close + the shortcoming that there is no way to synchronise on
> the buffer being flushed reliably.

I am not sure to fully understand that.
Do you mean that the serial driver (you wrote) has currently no
way to know if written bytes have been sent on the wire by the UART ?

> That's a shortcoming of the current
> driver (+ the serial profile spec) I trapped in myself - as the
> developer of this code. :(

Meaning it _could_ be done but it is not in current implementation?

> > because you will certainly fills the send buffer without giving a chance
> > to the drive to send more data than the one that fits in the buffer
> > (this heavily depends wether if the device is opened in blocking
> >  or non-blocking mode)
>
> Nope, the problem here has nothing to do with the timeout or the
> blocking mode. That write will block (given a timeout > 0 or infinite)
> when the software buffer (4k) is full. That's not specific in the serial
> profile, and that's bad.

Ok I see blocking / timeout feature is a "software" feature of the driver.

For some kind of "realtime" serial communication ones
may need something like "synchronous" write, meaning
driver write call should block or timeout if underlying HW is not
able to send the provided data.

I hope you'll excuse me to give such approximate  [wrong] answers.
I was trying to help, may be I should check the source code
before trying to answer.

Sorry about that.

-- 
Erk


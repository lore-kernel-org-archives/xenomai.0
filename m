Message-ID: <cbe23c50709150700w59a53809paca603e8bdc6af1e@domain.hid>
Date: Sat, 15 Sep 2007 16:00:37 +0200
From: "Eric Noulard" <eric.noulard@domain.hid>
In-Reply-To: <46EAC591.4050602@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709130245m6c73abd3tc8023237e03f70f2@domain.hid>
	<cbe23c50709130434x127c8e86nfb061ac71555cd68@domain.hid>
	<46EA3253.3010901@domain.hid>
	<cbe23c50709140112q160c809alc398ed1b9a502c40@domain.hid>
	<46EAC591.4050602@domain.hid>
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
> >
> > For some kind of "realtime" serial communication ones
> > may need something like "synchronous" write, meaning
> > driver write call should block or timeout if underlying HW is not
> > able to send the provided data.
>
> Yes, I agree, I just don't want to change the semantic of rtserial's
> write service. Besides likely breaking existing apps, I don't see the
> need for the change in the _common_ case. Most scenarios I saw so far
> either used the real-time UART port just for reading (+ some
> initialisation maybe) or they synchronised on the transmission by
> waiting on a reply from the devices. The case that you just write was
> yet not required, but it is a valid one. For that case, a patter of
> "write to port" + "wait on TXDONE event" would be appropriate IMO.

May be you may mimic the POSIX termios API (cf man termios(3))
which would be "write to fd" then "tcdrain" it.
This is just the same behavior you described with a known API.

May be such API (tcdrain) only deserve to be in userland
or the serial device profile may be updated to include
feature inspired from termios.
May be another RTSER_RTIOC_DRAIN
which may be the same
as RTSER_RTIOC_WAIT_EVENT on TXDONE.

Talking about this I don't really know who (driver, kernel, libc)
is doing what (write,ioctl, ...) when I use the termios API
on a "classical" linux serial device.

However I thought termios might be inspiring for RTDM serial device profile.
-- 
Erk


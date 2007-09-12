Message-ID: <1ce16a2c0709121217l2126f55cn97c04bd53d36bf5f@domain.hid>
Date: Wed, 12 Sep 2007 21:17:35 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
In-Reply-To: <2ff1a98a0709120932x80374eaj2d4f7f6aa4a42150@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709100614u3f23fce9yd2be767406fa536a@domain.hid>
	<46E58BE4.9090109@domain.hid>
	<1ce16a2c0709101142r6cf2d624oe443807575eadcfa@domain.hid>
	<46E59235.2060506@domain.hid>
	<1ce16a2c0709110837r52eedac7vcc970d5c3b4e2d53@domain.hid>
	<46E6F290.9090901@domain.hid>
	<1ce16a2c0709120702m1d4cc503vb045f3d2e0814d67@domain.hid>
	<2ff1a98a0709120932x80374eaj2d4f7f6aa4a42150@domain.hid>
Subject: Re: [Xenomai-help] adding PCI support to 16550A.c
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

http://pastebin.ca/694372
I did add "err = rt_task_shadow(&task_desc,"mytask",20,T_CPU(0));" and
_something_ is sent out on the serialport at least, but not what I
expect.
What I do get on the other side of my nullmodem looks like:
00 00 00 00 00 00
000000a0: 00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00
000000b0: 00 00 00 00 00 00

not what I expected.. :(

thanks.
/Bachman

On 12/09/2007, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 9/12/07, Bachman Kharazmi <bahkha@domain.hid> wrote:
> > > You can copy this code almost unmodified into an application and compile
> > > it against the Xenomai POSIX skin. The serial port configuration apart
> > > (same under Linux, though), it will open "rtser<whatever>", even if
> > > given like "/dev/rtser...", and work on that port as if it where a Linux
> > > one. Life can be simple, sometimes.
> >
> > Simple? ;)
> > I've tried to write a c-program which basiclly should open the device
> > rtser0 and write 100x to it and then close.
> >
> > The simple program can be found here: http://pastebin.ca/693873
> >
> > I've connected the serial cable to a reading terminal, but there's no
> > data at all, when I run the binary. :/
>
> You are missing a call to rt_task_shadow. Note that with the POSIX
> skin, this would not happen, because the main thread is automatically
> shadowed.
>
> >
> > /Bachman
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> >
>
>
> --
>                                                Gilles Chanteperdrix
>


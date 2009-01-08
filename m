Message-ID: <4965C340.1080504@domain.hid>
Date: Thu, 08 Jan 2009 10:11:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1231328992.7413.3.camel@domain.hid>
In-Reply-To: <1231328992.7413.3.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Blackfin serial port in Xenomai
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nikolaj Fogh <nf@domain.hid>
Cc: xenomai@xenomai.org

Nikolaj Fogh wrote:
> Hi,
> 
> I am trying to interface with a serial port on a bluetechnics cm-bf537e
> board (a blackfin chip). However, it seems that the serial port in the
> blackfin is not compatible with a 8250 chip, so I cannot get the xenomai
> rtdm serial driver working. Has anyone got a driver for the blackfin
> serial port for hard real time.
> 

I don't know of any, yet.

> Right now, I am just printf'ing to a serial console to print data. I
> would like to avoid that.
>

If that is just for text output, you could build a trivial rtdm driver accepting
strings from the write_rt endpoint and relay it to the debug routine available
with the I-pipe code for this arch, i.e.:
void __ipipe_serial_debug(const char *fmt, ...);

Caution: this routine is very naive, and locks out hw interrupts until the
entire string has been sent out to the wire; you may want to either fix it for
your needs, or send small strings, one at a time.

> Thanks
>   - Nikolaj Fogh
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.


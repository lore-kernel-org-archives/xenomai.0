Message-ID: <4C43D265.9080609@domain.hid>
Date: Mon, 19 Jul 2010 06:19:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid>
In-Reply-To: <4C43C83F.5030401@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Adeos patched kernel hangs mounting root file
 system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
> I suspect that the change in the event source timer rate is confusing 
> the waiting for the root file system to mount.
> 
> Does anyone know a way to fix this?

The Adeos patch simply forces Kconfig to disable the 32kHz clock,
because with a 32kHz clock source, we would only get a 30us granularity
for timer and clock services, which we find unacceptable. But the option
exists for a vanilla kernel as well.

You should try and disable the 32kHz clock on a vanilla kernel, if you
get the same issue, you should report it to the proper mailing list. If
you do net get it, then you have another issue, such as a edge/level
interrupts issue, and should give us more details such as the contents
of /proc/interrupts.

I also happen to run an OMAP3 based system, and I can mount and write to
an SD card with Xenomai without any problem (it is a 2.6.33 kernel,
tested with I-pipe version 1.16-01 and 1.17-01).

-- 
					    Gilles.


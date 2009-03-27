Message-ID: <49CCDAF9.8080509@domain.hid>
Date: Fri, 27 Mar 2009 14:56:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20090327115934.2C40C90005@domain.hid>
In-Reply-To: <20090327115934.2C40C90005@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Unable to use Xenomai-Services on ARM/S3C2410
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: p.vonbrunn@domain.hid
Cc: xenomai@xenomai.org

p.vonbrunn@domain.hid wrote:
> Hi guys,
> 
> I am currently trying to enable Real-Time-Support on my embedded NetDCU10
> board (S3C2410), but with a lot of problems remaining so far... I am using
> Kernel 2.6.19 delivered and pre-patched (some board-specific changes) with
> my board. This kernel is configured, compiled and working well on the
> target.
> 
> After this I tried to get Xenomai running on the machine. I am using
> Xenomai 2.3.1 with Adeos-Patch ARM 2.6.19 1.70 (latest), which compiled
> well (nucleus, skins etc. built in the kernel) but isn't working
> correctly: "dmesg" tells me that the Xenomai-Domain has been registered by
> I-pipe and the Xenomai-Services have been started, but I cannot run any
> (i.e. trivial_periodic) of the Xenomai-Examples. They fail with "Xenomai
> or XENO_OPT_PERVASIVE disabled", but Pervasive is enabled in the .config.
> Did I miss anything?
> 
> I thank you for any response and suggestions!
> 
> (Shall I post my shell-script for Xenomai-compilation and/or the
> config?)

Also, does the built-in "latency" test run?

-- 
                                                 Gilles.


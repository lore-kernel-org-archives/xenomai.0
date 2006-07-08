Subject: Re: [Xenomai-help] xenomai beginner problem.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <e325d110607080808w7778fb6ayf1f033b79be7c92b@domain.hid>
References: <e325d110607071259g5ebc019bs2565887803265adc@domain.hid>
	<44AEC245.7090702@domain.hid>
	<e325d110607080632u5d80322bte8d32d8e4828030e@domain.hid>
	<17583.47182.991802.118974@domain.hid>
	<e325d110607080808w7778fb6ayf1f033b79be7c92b@domain.hid>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 17:18:24 +0200
Message-Id: <1152371904.5004.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

On Sat, 2006-07-08 at 16:08 +0100, Kim Chuan Lim wrote:
> Hi Gilles,
> 
> > Try passing "lapic=1" as kernel boot parameter, and if it still does not
> > work, recompile your kernel with APIC support disabled.
> 
> Thanks. It works.
> 
> I try to run some examples programs at /usr/xenomai/testsuite/latency/run ..
> the following is the error i received..
> warming up...
> latency: failed to set periodic, code -110
> 
> Any quick suggest?
> 

Disable CONFIG_CPU_FREQ. If things don't improve, disable CONFIG_ACPI
globally to see if this works. Make sure CONFIG_PM is disabled too.

> Regards,
> Kim Chuan.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.




Subject: Re: [Xenomai-help] Kernel panic with Xenomai SMP kernel
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4509A522.5000707@domain.hid>
References: <44F6E774.2000701@domain.hid>
	<44F72F35.4070109@domain.hid>	<44F75C54.90608@domain.hid>
	<17655.28122.163232.842311@domain.hid>
	<44F84C23.9070105@domain.hid>
	<17656.30980.846435.69720@domain.hid>
	<44F8B112.9070203@domain.hid> <1157182863.4967.2.camel@domain.hid>
	<44FF2E2C.9050209@domain.hid> <1157581459.5064.128.camel@domain.hid>
	<45081913.8000004@domain.hid> <1158163163.5076.16.camel@domain.hid>
	<4509A522.5000707@domain.hid>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 09:17:51 +0200
Message-Id: <1158304672.5009.0.camel@domain.hid>
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-09-14 at 13:53 -0500, Jeff Webb wrote:
> Philippe Gerum wrote:'
> > On Wed, 2006-09-13 at 09:43 -0500, Jeff Webb wrote:
> > > After many, many recompiles.... As it turns out, this buggy
> > > behavior occurs when I turn off CONFIG_ACPI completely, instead
> > > of just turning off CONFIG_ACPI_PROCESSOR.  I tried this same 
> > > configuration file with the non-patched vanilla kernel, and got 
> > > strange behavior as well, so the problem is probably not in the 
> > > adeos patch (unlike the other two issues we discussed).  I am not 
> > > really concerned about this, since I would rather have some of 
> > > the CONFIG_ACPI options on anyway.  I just wanted to follow up
> > > and let you know I tracked down the problem as far as I care to 
> > > take it for the moment.
> >
> > Interesting, this looks like power management quirks, maybe caused by
> > funky BIOS interactions. In any case, this is worth a new paragraph in
> > the troubleshooting file. Thanks a lot for testing and reporting this.
> 
> For what it's worth... turning off CONFIG_ACPI completely does not seem to cause a problem if I disable SMP.  So, it seems like the problem is turning off CONFIG_ACPI completely for an SMP kernel.
> 

ACPI is used to parse the SMP boot table, among other things, so this
makes sense.

> -Jeff
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.




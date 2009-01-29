From: Carlos Novaes <carlosnov@domain.hid>
Date: Thu, 29 Jan 2009 20:12:05 -0200
References: <200901282113.48357.carlosnov@domain.hid>
	<200901290714.15951.carlosnov@domain.hid>
	<49817444.6030901@domain.hid>
In-Reply-To: <49817444.6030901@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901292012.05705.carlosnov@domain.hid>
Subject: Re: [Xenomai-help] proc interface isn't created
Reply-To: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

It says something like this:

===
local APIC disabled or hardware not present
using APIC emulation
....
...
"Xenomai: Local APIC absent or disabled!
    Disable APIC support or pass "lapic" as bootparam."

...
===

I found out that lapic=1 does not work, so I will try to recompile a kernel 
without APIC support... but menuconfig does not show APIC options. I will try 
to change it by editing .config file.

I should ask... if really my old hardware dows not support LAPIC, then why 
menuconfig enable it on kernel config?

Thanks.



Em Thursday 29 January 2009 07:17:56 Philippe Gerum escreveu:
> Carlos Novaes wrote:
> > Em Thursday 29 January 2009 05:52:56 Gilles Chanteperdrix escreveu:
> > Virtual file system proc is mounted, investigating I found out that
> > /proc/ipipe registered Linux interface, but not Xenomai:
> > ====
>
> Xenomai did not boot then. What does you bootlog say?
>
> > $: ls /proc/
> > Linux
> > version
> > ====
> > attached is my .config
> >
> >> Is /proc mounted ?
> >> Otherwise, please send us your .config.
> >
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help

-- 

Carlos Novaes


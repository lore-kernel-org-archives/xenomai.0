Message-ID: <e325d110607081156n42b7d8f1m892949b16dc2e9f@domain.hid>
Date: Sat, 8 Jul 2006 19:56:22 +0100
From: "Kim Chuan Lim" <lim.kim.chuan@domain.hid>
Subject: Re: [Xenomai-help] xenomai beginner problem.
In-Reply-To: <1152371904.5004.2.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e325d110607071259g5ebc019bs2565887803265adc@domain.hid>
	<44AEC245.7090702@domain.hid>
	<e325d110607080632u5d80322bte8d32d8e4828030e@domain.hid>
	<17583.47182.991802.118974@domain.hid>
	<e325d110607080808w7778fb6ayf1f033b79be7c92b@domain.hid>
	<1152371904.5004.2.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi Philippe,

Thanks, it works again. ^ ^

I manage to run few testsuit program but two of them(switchbench and
cyclic) are crashing my xenomai machine.

May i know what is the reason?

Regards,
Kim Chuan.





On 7/8/06, Philippe Gerum <rpm@xenomai.org> wrote:
> On Sat, 2006-07-08 at 16:08 +0100, Kim Chuan Lim wrote:
> > Hi Gilles,
> >
> > > Try passing "lapic=1" as kernel boot parameter, and if it still does not
> > > work, recompile your kernel with APIC support disabled.
> >
> > Thanks. It works.
> >
> > I try to run some examples programs at /usr/xenomai/testsuite/latency/run ..
> > the following is the error i received..
> > warming up...
> > latency: failed to set periodic, code -110
> >
> > Any quick suggest?
> >
>
> Disable CONFIG_CPU_FREQ. If things don't improve, disable CONFIG_ACPI
> globally to see if this works. Make sure CONFIG_PM is disabled too.
>
> > Regards,
> > Kim Chuan.
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> --
> Philippe.
>
>
>


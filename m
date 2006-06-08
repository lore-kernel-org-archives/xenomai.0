Message-ID: <44885FDA.8080301@domain.hid>
Date: Thu, 08 Jun 2006 20:35:22 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rfc] unit testing context switches.
References: <17536.40316.183366.284818@domain.hid>	<17543.5163.684144.582942@domain.hid>	<44871DF8.9010903@domain.hid>
	<17544.6126.256649.862048@domain.hid>
In-Reply-To: <17544.6126.256649.862048@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Gilles Chanteperdrix kirjoitti:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > --- /dev/null	2006-05-03 22:25:59.000000000 +0200
>  > > +++ include/rtdm/rttesting.h	2006-06-07 18:50:14.000000000 +0200
>  > > @@ -0,0 +1,188 @@
>  > ...
>  > > + *
>  > > + * @{
>  > > + */
>  > > +
>  > > +#ifndef _RTBENCHMARK_H
>  > > +#define _RTBENCHMARK_H
>  > 
>  > Hmm, there might be further renamings required. Could you double-check
>  > (e.g. grep -ri benchmark)?
> 
> This particular define should be fixed in the version that I commited. 
> 
> I also put dummy asm/fptest.h for all other architectures than x86, I
> would now need volunteers with other hardware than x86 to implement
> asm/fptest.h for their platform and run the test.
> 
> A little explanation of what work should be done: two functions
> fp_regs_set and fp_regs_check should be implemented. fp_regs_set should
> set all fp registers to the integer value passed as
> argument. fp_regs_check should check that all fp registers are set to
> the integer value passed as argument, print the incorrect registers if
> any and return 1 if some register value is incorrect.

IMO setting every reg to a different value would be better, or like I 
did, calculate some value using every reg and only check the final 
result. That would also make pointer (to the fpu save area) 
corruptions/miscalculations and interruptions to the fpu save/restore 
routines better visible.

-- hl


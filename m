Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Adeos-main] SMP for ppc64
Date: Tue, 9 Aug 2005 08:21:30 -0500
Message-ID: <0D21CBD1298D2C4790E2F2B86D96EC1935942B@amr-ex5.ds.amrdec.army.mil>
From: "Reynolds, Terry \(Contractor-SIMTECH\)" <terry.reynolds2@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi All,

I've made my first attempt at SMP, and had some success.  I modified the
IPI for the critical entry
point to be a call to smp_call_function.  I had to add calls to
adeos_load_cpuid to several of the
ppc64.c routines ( __adeos_override_irq_enable,
__adeos_override_irq_disable,=20
__adeos_override_irq_end & __adeos_override_irq_affinity) as they seemed
to have garbage for cpuid=20
number when entered.
=20
The system boots now with SMP enabled, BUT for some reason the second
cpu is "stuck".  It fails to=20
start correctly.  This is strange, as the startup for the second cpu
happen prior to the adeos=20
pipeline starting up, but after the adeos root domain is registered.  In
that section of time, I see=20
no reason for things to behave differently than the non-adeos boot up. =20
=20
I'm still looking.  Anyone have any idea as to why the processor fails
to come up?

Thanks,

Terry.=20

-----Original Message-----
From: adeos-main-bounces@domain.hid [mailto:adeos-main-bounces@domain.hid] On
Behalf Of Terry
Sent: Thursday, August 04, 2005 10:17 PM
To: adeos-main@gna.org
Subject: [Adeos-main] SMP for ppc64

I'm looking at adding SMP support for 2.6.10 kernel on a ppc64.  I'm
having trouble scratching my way through the mpic version of using IPI's
to trigger interrupts on the other cpu's.  In the Intel ports, an irq is
assigned to
(ADEOS_CRITICAL_VECTOR) to act as the critical sync isr, and an IPI is
sent to "allbutself" to trigger it.  I need some advice on the best
approach to do this on a ppc64.

I see two options to handle this one.

The first option is to use smp_call_function (or a similar adeos
version) to send the IPI to the other cpu.  The version in smp.c says :
"You must not call this function with disabled interrupts or from a
hardware interrupt context or from a bottom half handler".  It looks as
if I'd be doing just that, as the critical_enter function first does a
local_irq_save_hw(flags)=20
before calling the send_ipi.   So I'd need a new version of one or the
other=20
to prevent deadlocks.

The other option is to create a virq for the ADEOS_CRITICAL_VECTOR, and
map that to the one unused IPI ( mpic has 4 IPI's one of which is
currently unused).  That doesn't seem like a good plan, as ppc64 linux
may decide to start using that one some day.

Anyone have any suggestions, or can explain how I misunderstood all of
the above?


Thanks in advance!

Terry=20



_______________________________________________
Adeos-main mailing list
Adeos-main@domain.hid
https://mail.gna.org/listinfo/adeos-main


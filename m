MIME-Version: 1.0
In-Reply-To: <AANLkTikGFw6dxQHC1ukWHsTP-QoHzpbDzeMdLj=jZRP5@domain.hid>
References: <AANLkTinN+KBK2B77opSCwDvb9bneObxL1+FTmmwpQGup@domain.hid>
	<4CC20AD2.4060501@domain.hid>
	<AANLkTimyj5TRgan5nE5ey6h8-WO_-na=U66si-e9Xx9F@mail.gmail.com>
	<4CC44C02.4050003@domain.hid>
	<AANLkTinjUHYvNJwcuEd2RQuQLWL3WvGx-jFb5iG88f0c@domain.hid>
	<AANLkTikGFw6dxQHC1ukWHsTP-QoHzpbDzeMdLj=jZRP5@domain.hid>
Date: Mon, 25 Oct 2010 08:19:22 +0200
Message-ID: <AANLkTimsGjmPNE1GOzmyF4pHQe6m4RmFphuhGqdTrs1D@mail.gmail.com>
From: Eric Noulard <eric.noulard@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Slow hard drive access in xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

2010/10/24 Peter Pastor <peter.pastor@domain.hid>:
> Hey Gilles,
> I am in the process to configure the xenomai kernel as you suggested.
> I found and disabled the options that you suggested (NUMA, SPARSEMEM,
> SECCOMP, AUDITSYSCALL,=A0KPROBES, FTRACE, SELINUX), However, I could not
> disable SPARSEMEM. Searching for SPARSEMEM in the kernel configuration
> simply says "Symbol: SPARSEMEM [=3Dy]" and does not give me any further i=
nfo.
> Can you tell me how to disable it ?

SPARSEMEM may be a dependence for other options.
If you look into the mm/Kconfig file
http://lxr.linux.no/#linux+v2.6.32/mm/Kconfig#L103
you may discover which options you have may need SPARSEMEM.

For example the CONFIG_MEMORY_HOTPLUG depends on SPARSEMEM.

> Also, I disabled NUMA even though the info states "For 64-bit this is
> recommended if the system is Intel Core i7 (or later), AMD Opteron, or
> EM64T" and my system is a 64bit, with 8 Intel Xeon cores. Hope that is ok=
...

NUMA stands for Non Uniform Memory Access essentially it is for multiproces=
sor
machine which have a memory layout which is not "symmetric" (aka Uniform) w=
ith
respect to each processor.
You have some "pictured" example of NUMA systems on the HWLOC project
http://www.open-mpi.org/projects/hwloc/
http://www.open-mpi.org/projects/hwloc/doc/v1.0.2/#examples

Now I really don't know if enabling NUMA handling is mandatory for NUMA sys=
tems
I guess yuo could disable NUMA handling at kernel level but yuo may
get performance
weirdness because the kernel is not aware of the NUMA nature.

This is pure guess, I let others give you a more "secure" answer to this.

> Also, I found the following option which is currently
> enabled,=A0CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS. The info states "Rero=
ute
> for broken boot IRQs". Maybe that something I could switch off and see wh=
at
> happens ??
> I attached the config and I will let you know how it goes.
> THANK you so much,
> =A0peter


--=20
Erk
Membre de l'April - =AB promouvoir et d=E9fendre le logiciel libre =BB -
http://www.april.org


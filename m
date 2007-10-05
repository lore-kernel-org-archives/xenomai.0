Message-Id: <200710050756.l957u8tH013063@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Fri, 5 Oct 2007 09:56:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <18181.15818.772625.155922@domain.hid>
Subject: Re: [Xenomai-help] rt_task crash kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

I have tried to compile Xenomai 2.3.2 with adeos patch 1.7-03 but the =
system
doesn't boot correctly. If I disable RealTime subsystem in kernel
configuration the system boots right.

I have tried to compile Xenomai 2.3.4 with adeos patch 1.7-01. The =
system
boots but when I insert my module the system crashes. Exactly like with =
the
1.7-06.

So I think that the bug is not in adeos patch but in Xenomai ?!?

Thanks

-----Message d'origine-----
De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=E9=A0: jeudi, 4. octobre 2007 21:24
=C0=A0: Patrick
Cc=A0: xenomai@xenomai.org
Objet=A0: RE: [Xenomai-help] rt_task crash kernel

Patrick wrote:
 > Hi,
 >=20
 > I have tryed to compile the 2.6.20 kernel without eabi but the issue =
is
the
 > same: the kernel crashes when I insert the module.
 >=20
 > Thanks for your help.

Ok, so I have not broken the EABI stuff.

>From now on, if you want to work with this new patch, you will have to
debug it yourself. Of course, we will provide some help on this list.

There are two ways you can go:
- either you bisect in the Adeos patches to see which patch introduced
  the bug (all I-pipe patches should work with Xenomai v2.3.4, except
  specifically 1.7-05);
- either you try and debug the crash. Hopefully, the kernel tries to
  print something before it dies, so what you can do is modify printk so
  that it does a vsnprintf and uses the printascii function (in order to
  have a working printascii, you have to enable low-level debugging
  functions in the kernel configuration "kernel hacking"
  section). Then, if you succeed, you will have to try to use the tracer
  to understand what happens.

This reminds me, last time we solved such a bug on ARM, the "schedule"
function ended up called in a loop in Xenomai domain. To detect this,
enable I-pipe debugging in kernel configuration and select the "Check
for illicit cross-domain calls" option.

Good luck if you decide to debug this new patch.

--=20


					    Gilles Chanteperdrix.



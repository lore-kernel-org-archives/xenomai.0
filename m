MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-ID: <18181.15818.772625.155922@domain.hid>
Date: Thu, 4 Oct 2007 21:23:54 +0200
In-Reply-To: <200710040856.l948uFto029224@domain.hid>
References: <2ff1a98a0710030812p6539f24fqc394a4b4eae9ff36@domain.hid>
	<200710040856.l948uFto029224@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
To: Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org

Patrick wrote:
 > Hi,
 >=20
 > I have tryed to compile the 2.6.20 kernel without eabi but the issue=
 is the
 > same: the kernel crashes when I insert the module.
 >=20
 > Thanks for your help.

Ok, so I have not broken the EABI stuff.

=46rom now on, if you want to work with this new patch, you will have to
debug it yourself. Of course, we will provide some help on this list.

There are two ways you can go:
- either you bisect in the Adeos patches to see which patch introduced
  the bug (all I-pipe patches should work with Xenomai v2.3.4, except
  specifically 1.7-05);
- either you try and debug the crash. Hopefully, the kernel tries to
  print something before it dies, so what you can do is modify printk s=
o
  that it does a vsnprintf and uses the printascii function (in order t=
o
  have a working printascii, you have to enable low-level debugging
  functions in the kernel configuration "kernel hacking"
  section). Then, if you succeed, you will have to try to use the trace=
r
  to understand what happens.

This reminds me, last time we solved such a bug on ARM, the "schedule"
function ended up called in a loop in Xenomai domain. To detect this,
enable I-pipe debugging in kernel configuration and select the "Check
for illicit cross-domain calls" option.

Good luck if you decide to debug this new patch.

--=20


=09=09=09=09=09    Gilles Chanteperdrix.


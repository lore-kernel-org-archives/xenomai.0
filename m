Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] VM killer
Date: Fri, 17 Nov 2006 19:35:49 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB015D4833@domain.hid>
In-Reply-To: <455E058C.1010404@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
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

jan.kiszka@domain.hid wrote:
=20
> Having a means to avoid that your critical process gets killed
> accidentally because some uncritical one decided to suck up all
> system resources is, IMO, a very legitimate use case. On 2.6, where
> there is no CONFIG_OOM_KILLER, you can play with /proc/<pid>/oom_adj
> and make your process "unattractive" to the OOM killer (set to -17).
> On older kernels you also had to include any parent processes in this
> protection. I think this was fixed meanwhile.     =20
>=20
> But I wonder why there should be no effect of CONFIG_OOM_KILLER on
> 2.4.=20
> Forgot to replay the updated kernel binaries?

Well double checked: no. At least if my .config in the linux kernel
directory is not magically updated after compiling the kernel. BTW: I
could not find that option in the make menuconfig configuration. Maybe
it is hidden somewhere in a submenu, but at least in the .config file it
is definetly disabled.


Best regards,

Daniel Schnell.


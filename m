From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-help] A bug of udev rules?
Date: Tue, 9 May 2006 15:59:49 +0900
References: <44603695.2020407@domain.hid>
In-Reply-To: <44603695.2020407@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_m3DYEz3WQ4c1AqQ"
Message-Id: <200605091559.50160.rlenglet@domain.hid>
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

--Boundary-00=_m3DYEz3WQ4c1AqQ
Content-Type: text/plain;
  charset="gb18030"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Liu Zhenghui wrote:
> I installed xenomai on Debian Linux sid. For some reason, I
> recently changed to udev to manage the /dev. Then udev always
> report error on
>
> rules installed by xenomai at boot time like following:
> : add_to_rules: invalid KERNEL operation
> : add_to_rules: invalid rule
> : '/etc/udev/rules.d/udev.rules:100'
>
> As a result, the device rtheap and rtp* is not controlled by
> udev rules and always has default mode "0660".
>
> I found there is wrong with rules installed by xenomai, which
> source is located at ksrc/nucleus/udev/*.rules:
>
> # real-time heap device (Xenomai:rtheap)
> KERNEL=3D"rtheap", =810=842NAME=3D"rtheap", MODE=3D"0666"
> =810=842 =810=842 =810=842 ~should be "=3D=3D" here, not "=3D"
>
> My udev version in debian is 0.091-2, kernel version is
> 2.6.15.7
>
> Is it a bug? Luckly, it works after I changed "=3D" to "=3D=3D"

I also got such errors with my own rules and rules from other=20
packages.
Debian's udev package applies an upstream patch which makes udev=20
more strict about the syntax, since version 090 (21 April 2006).
See /usr/share/doc/udev/changelog.Debian.gz.

So, you are right, it should be:
KERNEL=3D=3D"rtheap", =810=842NAME=3D"rtheap", MODE=3D"0666"
Key match and assignment are now strictly syntactically=20
different, and KERNEL is a read-only key which can't be=20
assigned.

I think that it is safe to change KERNEL=3D into KERNEL=3D=3D in=20
Xenomai's rules files, since the =3D=3D syntax has been introduced=20
since Udev version 055 (March 2005).

By the way, I think that the NAME=3D assignment is superfluous,=20
because by default NAME is the kernel-assigned name in KERNEL.


Attached is the two-line patch.

=2D-=20
Romain LENGLET

--Boundary-00=_m3DYEz3WQ4c1AqQ
Content-Type: text/x-diff; charset="gb18030";
	name="udev-rules-syntax_2006-05-09.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="udev-rules-syntax_2006-05-09.patch"

Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- ChangeLog	(r=C3=A9vision 1037)
+++ ChangeLog	(copie de travail)
@@ -1,3 +1,10 @@
+2006-05-09  Romain Lenglet  <rlenglet@domain.hid>
+
+	* ksrc/nucleus/udev/rtpipe.rules, ksrc/nucleus/udev/rtheap.rules:
+	Modified key match KERNEL=3D into KERNEL=3D=3D, to avoid errors with
+	recent versions of Udev which are stricter about the rules syntax.
+	Removed unuseful NAME=3D key assignments.
+
 2006-05-05  Jim Cromie <jim.cromie@domain.hid>
=20
 	* scripts/prepare-kernel.sh (patch_append): Do not alter link
Index: ksrc/nucleus/udev/rtheap.rules
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- ksrc/nucleus/udev/rtheap.rules	(r=C3=A9vision 1037)
+++ ksrc/nucleus/udev/rtheap.rules	(copie de travail)
@@ -1,2 +1,2 @@
 # real-time heap device (Xenomai:rtheap)
=2DKERNEL=3D"rtheap",  NAME=3D"rtheap", MODE=3D"0666"
+KERNEL=3D=3D"rtheap", MODE=3D"0666"
Index: ksrc/nucleus/udev/rtpipe.rules
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- ksrc/nucleus/udev/rtpipe.rules	(r=C3=A9vision 1037)
+++ ksrc/nucleus/udev/rtpipe.rules	(copie de travail)
@@ -1,2 +1,2 @@
 # real-time pipe devices (Xenomai:rtpipe)
=2DKERNEL=3D"rtp[0-9]*",  NAME=3D"%k", MODE=3D"0666"
+KERNEL=3D=3D"rtp[0-9]*", MODE=3D"0666"

--Boundary-00=_m3DYEz3WQ4c1AqQ--


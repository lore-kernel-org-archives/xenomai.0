From: Stelian Pop <stelian.pop@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 08 Feb 2007 17:22:13 +0100
Message-Id: <1170951733.23555.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] [PATCH] Enable usage of pthread_set_{mode,
	name}_np from kernel space
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

Is there a reason why pthread_set_{mode,name}_np are not allowed to be
called from a kernel space POSIX thread ?

If there is none, please apply the patch below.

Thanks.

Index: ksrc/skins/posix/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/posix/thread.c	(r=E9vision 2162)
+++ ksrc/skins/posix/thread.c	(copie de travail)
@@ -745,3 +745,5 @@
 EXPORT_SYMBOL(pthread_self);
 EXPORT_SYMBOL(pthread_make_periodic_np);
 EXPORT_SYMBOL(pthread_wait_np);
+EXPORT_SYMBOL(pthread_set_name_np);
+EXPORT_SYMBOL(pthread_set_mode_np);

--=20
Stelian Pop <stelian.pop@domain.hid>



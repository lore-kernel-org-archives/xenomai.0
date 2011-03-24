From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTikC-6XF9nx58AEyiuU_ZYa29jjg37km6eRer5Kz@domain.hid>
References: <AANLkTikC-6XF9nx58AEyiuU_ZYa29jjg37km6eRer5Kz@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Mar 2011 08:37:50 +0100
Message-ID: <1300952270.2077.1.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] unable to build xenomai-head
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2011-03-23 at 15:11 -0500, Jeff Weber wrote:
> I am unable to build the xenomai head. "make modules" gives
>=20
>=20
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CC [M]  kernel/xenomai/nucleus/registry.o
> kernel/xenomai/nucleus/registry.c:226:8: warning: type defaults to
> =E2=80=98int=E2=80=99 in declaration of =E2=80=98DECLARE_MUTEX=E2=80=99
> kernel/xenomai/nucleus/registry.c:226:1: warning: parameter names
> (without types) in function declaration
> kernel/xenomai/nucleus/registry.c: In function
> =E2=80=98registry_proc_callback=E2=80=99:
> kernel/xenomai/nucleus/registry.c:250:8: error: =E2=80=98export_mutex=E2=
=80=99
> undeclared (first use in this function)
> kernel/xenomai/nucleus/registry.c:250:8: note: each undeclared
> identifier is reported only once for each function it appears in
> kernel/xenomai/nucleus/registry.c: At top level:
> kernel/xenomai/nucleus/registry.c:226:8: warning: =E2=80=98DECLARE_MUTEX=
=E2=80=99
> declared =E2=80=98static=E2=80=99 but never defined
> make[3]: *** [kernel/xenomai/nucleus/registry.o] Error 1
> make[2]: *** [kernel/xenomai/nucleus] Error 2
> make[1]: *** [kernel/xenomai] Error 2
> make: *** [kernel] Error 2
> make: *** Waiting for unfinished jobs....
>=20

DECLARE_MUTEX vanished away in 2.6.37; the required compat wrapper was
merged into 2.5.x, but not to 2.6.x yet.

diff --git a/include/asm-generic/wrappers.h
b/include/asm-generic/wrappers.h
index e5b8c89..4f99fd5 100644
--- a/include/asm-generic/wrappers.h
+++ b/include/asm-generic/wrappers.h
@@ -622,4 +622,9 @@ static inline void wrap_proc_dir_entry_owner(struct
proc_dir_entry *entry)
 #define unlocked_ioctl ioctl
 #endif
=20
+#ifndef DEFINE_SEMAPHORE
+/* Legacy DECLARE_MUTEX vanished in 2.6.37 */
+#define DEFINE_SEMAPHORE(sem) DECLARE_MUTEX(sem)
+#endif
+
 #endif /* _XENO_ASM_GENERIC_WRAPPERS_H */

>=20
> this config:
> linux=3D/usr/src/linux-2.6.37.3
> xenomai=3D xenomai-head
> adeos=3Dadeos-ipipe-2.6.37-x86-2.9-00.patch
> arch=3Dx86 32-bit on SMP
>=20
>=20
> I recently successfully build the same config using the released
> xenomai-2.5.6 with no problems.
> I'm  not yet experienced in git, but I obtained the xenomai-head
> branch by:
>=20
>=20
> git clone git://xenomai.org/xenomai-head.git
>=20
>=20
> Did I fetch the branch wrong, or does the xenomai-head branch
> currently not build?
> I need the CLOCK_HOST_REALTIME feature.
>=20
>=20
> TIA,
> Jeff
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
Philippe.




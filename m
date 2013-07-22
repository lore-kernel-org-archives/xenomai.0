Message-ID: <1374478047.51902.YahooMailNeo@web172204.mail.ir2.yahoo.com>
Date: Mon, 22 Jul 2013 08:27:27 +0100 (BST)
From: Franz Engel <franz_lambert_engel@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] (no subject)
Reply-To: Franz Engel <franz_lambert_engel@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Franz Engel wrote: =0A> Philippe wrote=0A>> Philippe wrote: =0A>>>> Franz E=
ngel wrote: =0A>>>> Hi, =0A>>>> =0A>>>> I get this error when I run a progr=
amm: =0A>>>> __xn_sys_current_info failed: Operation not permitted =0A>>>> =
=0A>>>> I know that the error comes from the assert_nrt_inner(void) =0A>>>>=
 function inside the assert_context.c file. But I have no idea what =0A>>>>=
 is the reason. The Operation not permitted is the return value from =0A>>>=
> XENOMAI_SYSCALL1(__xn_sys_current_info, &info);. But I found no =0A>>>> d=
ocumentation about this function. =0A>>>>=0A>>>This is reminiscent of a sym=
ptom observed for a bug fixed in the =0A>>>=A0=A0=A0=A0 -forge tree, a whil=
e ago: =0A>>>http://git.xenomai.org/?p=3Dxenomai-forge.git;a=3Dcommit;h=3D0=
14898add6a697e1a0d69f9e20b910ade74f1940 =0A>>> =0A>>>Do you happen to call =
fork() in your=A0 application? =0A>> =0A>> Yes, I do. What I can do to solv=
e the problem. Should I try to modify =0A>> the xenomai files as discrept i=
n the git-link? =0A>> =0A>>> =A0=A0=A0 I'm unsure, although this would be p=
ossible to backport portions of the =0A>>>=A0=A0 =A0 logic, the implementat=
ion has now diverged significantly between the =0A>>>=A0=A0=A0=A0 2.x and 3=
.x code bases. =0A>>=0D>=0A>>>=A0=A0=A0=A0 Could you try the patch below? I=
t's untested, but should work around =0A>>>=A0=A0=A0=A0 the =0A>>>=A0=A0=A0=
=A0 root issue in your case: =0A>>> =0A>>>=A0=A0=A0=A0 diff --git a/include=
/nucleus/compiler.h b/include/nucleus/compiler.h =0A>>>=A0=A0=A0=A0 index 3=
0f32c7..da4ea03 100644 =0A>>>=A0=A0=A0=A0 --- a/include/nucleus/compiler.h =
=0A>>>=A0=A0=A0=A0 +++ b/include/nucleus/compiler.h =0A>>>=A0=A0=A0=A0 @@ -=
37,9 +37,11 @@ =0A>>> =0A>>>=A0=A0=A0=A0=A0=A0=A0 #ifdef __IN_XENO__ =0A>>>=
=A0=A0=A0=A0=A0=A0=A0 #if __GNUC__ =3D=3D 4 && __GNUC_MINOR__ =3D=3D 6 =0A>=
>>=A0=A0=A0=A0 -#define __constructor__ __attribute__((constructor, noclone=
)) =0A>>>=A0=A0=A0=A0 +#define __constructor__ __attribute__((constructor(2=
00), noclone)) =0A>>>=A0=A0=A0=A0 +#define __late_constructor__ __attribute=
__((constructor, noclone)) =0A>>>=A0=A0=A0=A0=A0=A0=A0 #else /* Gcc not 4.6=
 */ =0A>>>=A0=A0=A0=A0 -#define __constructor__ __attribute__((constructor)=
) =0A>>>=A0=A0=A0=A0 +#define __constructor__ __attribute__((constructor(20=
0))) =0A>>>=A0=A0=A0=A0 +#define __late_constructor__ __attribute__((constr=
uctor)) =0A>>>=A0=A0=A0=A0=A0=A0=A0 #endif /* Gcc not 4.6 */ =0A>>>=A0=A0=
=A0=A0=A0=A0=A0 #endif /* In xenomai */ =0A>>> =0A>>>=A0=A0=A0=A0 diff --gi=
t a/src/skins/common/rt_print.c b/src/skins/common/rt_print.c =0A>>>=A0=A0=
=A0=A0 index dfa8b33..e056cd6 100644 =0A>>>=A0=A0=A0=A0 --- a/src/skins/com=
mon/rt_print.c =0A>>>=A0=A0=A0=A0 +++ b/src/skins/common/rt_print.c =0A>>>=
=A0=A0=A0=A0 @@ -738,7 +738,7 @@ static void forked_child_init(void) =0A>>>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spawn_printer_thread(); =0A>>=
>=A0=A0=A0=A0 } =0A>>> =0A>>>=A0=A0=A0=A0 -static __constructor__ void __rt=
_print_init(void) =0A>>>=A0=A0=A0=A0 +static __late_constructor__ void __rt=
_print_init(void) =0A>>>=A0=A0=A0=A0=A0=A0=A0 { =0A>>>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 const char *value_str; =0A>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 unsigned long long period; =0A>>> =0A>>>=A0=A0=A0=A0 -- =0A>>>=A0=A0=A0=A0=
 Philippe. =0A>> =0A>>=A0=A0=A0=A0 I tried the patch. But I think it is not=
 the correct version of =0A>>=A0=A0=A0=A0 xenomai. In my compiler.h there i=
s no line "#define __constructor__ =0A>>=A0=A0=A0=A0 __attribute__((constru=
ctor, noclone))". I use Xenomai 2.6.2.1. =0A>> =0A=A0=0A>Simply ignore the =
noclone spec when applying the patch manually. You should end up with the >=
normal/high priority ctor at priority 200, the late one with an implicit, u=
nspecified low priority. =0A=A0=0AI'm not sure if I understand you correct.=
 I change the function in rt_print.h (line 706) from "static __attribute__(=
(constructor)) void __rt_print_init(void)" to "static __late_constructor__ =
void __rt_print_init(void)"=0Aand I insert the following lines into the com=
piler.h (absolutly new lines):=0A#ifdef __IN_XENO__=0A=A0 #if __GNUC__ =3D=
=3D 4 && __GNUC_MINOR__ =3D=3D 6=0A=A0=A0=A0=A0 #define __constructor__ __a=
ttribute__((constructor(200), noclone))=0A=A0=A0=A0=A0 #define __late_const=
ructor__ __attribute__((constructor, noclone))=0A=A0 #else /* Gcc not 4.6 *=
/=0A=A0=A0=A0=A0 #define __constructor__ __attribute__((constructor(200)))=
=0A=A0=A0=A0=A0 #define __late_constructor__ __attribute__((constructor))=
=0A=A0 #endif /* Gcc not 4.6 */=0A#endif /* In xenomai */=0A=0AIs it correc=
t? I have still the same failure.=0A=0Aregards,=0A=A0=A0=A0=A0=A0 Franz=0A

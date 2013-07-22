References: <1374143094.1082.YahooMailNeo@web172202.mail.ir2.yahoo.com>
	<51E900B7.9070604@xenomai.org>
	<1374227358.60075.YahooMailNeo@web172203.mail.ir2.yahoo.com>
	<51E9106C.3000909@xenomai.org>
	<1374231441.29790.YahooMailNeo@web172205.mail.ir2.yahoo.com>
	<51ECE12A.4070700@xenomai.org>
	<1374495002.37795.YahooMailNeo@web172201.mail.ir2.yahoo.com>
	<51ED2DA8.2060307@xenomai.org>
Message-ID: <1374503384.91881.YahooMailNeo@web172206.mail.ir2.yahoo.com>
Date: Mon, 22 Jul 2013 15:29:44 +0100 (BST)
From: Franz Engel <franz_lambert_engel@yahoo.de>
In-Reply-To: <51ED2DA8.2060307@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] __xn_sys_current_info failed: Operation not permitted
Reply-To: Franz Engel <franz_lambert_engel@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Von: Philippe Gerum <rpm@xenomai.org>=0A=0AAn: Franz Engel <franz_lambert_e=
ngel@yahoo.de> =0A>Gesendet: 15:03 Montag, 22.Juli 2013=0A>Betreff: Re: [Xe=
nomai] __xn_sys_current_info failed: Operation not permitted=0A> =0A>=0A>On=
 07/22/2013 02:10 PM, Franz Engel wrote:=0A>>=0A>>=0A>>=A0 =A0  On 07/19/20=
13 12:57 PM, Franz Engel wrote:=0A>>=0A>>=A0 =A0 =A0 >=0A>>=A0 =A0 =A0 >=A0=
 =A0 On 07/19/2013 11:49 AM, Franz Engel wrote:=0A>>=A0 =A0 =A0 >=A0 =A0 =
=A0 > Philippe wrote:=0A>>=A0 =A0 =A0 >=A0 =A0 =A0 >>> Franz Engel wrote:=
=0A>>=A0 =A0 =A0 > >>> Hi,=0A>>=A0 =A0 =A0 >=A0 =A0 =A0 >> >=0A>>=A0 =A0 =
=A0 >=A0 =A0 =A0 >>> I get this error when I run a programm:=0A>>=A0 =A0 =
=A0 >=A0 =A0 =A0 >>> __xn_sys_current_info failed: Operation not permitted=
=0A>>=A0 =A0 =A0 >=A0 =A0 =A0 >> >=0A>>=A0 =A0 =A0 >=A0=0A =A0 =A0 >>> I kn=
ow that the error comes from the assert_nrt_inner(void)=0A>>=A0 =A0 =A0 >=
=A0 =A0 function inside the assert_context.c file. But I have no idea what=
=0A>>=A0 =A0 =A0 >=A0 =A0 is the reason. The Operation not permitted is the=
 return value=0A>>=A0 =A0  from=0A>>=A0 =A0 =A0 >=A0 =A0 XENOMAI_SYSCALL1(_=
_xn_sys_current_info, &info);. But I found no=0A>>=A0 =A0 =A0 >=A0 =A0 docu=
mentation about this function.=0A>>=A0 =A0 =A0 >=A0 =A0 =A0 >=0A>>=A0 =A0 =
=A0 >=A0 =A0 =A0 >=0A>>=A0 =A0 =A0 >=A0 =A0 =A0 >>This is reminiscent of a =
symptom observed for a bug fixed=0A>>=A0 =A0  in the=0A>>=A0 =A0 =A0 >=A0 =
=A0 -forge=0A>>=A0 =A0 =A0 >=A0 =A0 =A0 >>tree, a while ago:=0A>>=A0 =A0 =
=A0=0A >=0A>>=A0 =A0 =A0 >>http://git.xenomai.org/?p=3Dxenomai-forge.git;a=
=3Dcommit;h=3D014898add6a697e1a0d69f9e20b910ade74f1940=0A>>=A0 =A0 =A0 >=A0=
 =A0 =A0 >=0A>>=A0 =A0 =A0 >=A0 =A0 =A0 >>Do you happen to call fork() in y=
our=A0 application?=0A>>=A0 =A0 =A0 >=A0 =A0 =A0 >=0A>>=A0 =A0 =A0 >=A0 =A0=
 =A0 > Yes. I do? What I can do to solve the problem. Should I=0A>>=A0 =A0 =
 try to modify=0A>>=A0 =A0 =A0 >=A0 =A0 =A0 > the xenomai files as discrept=
 in the git-link?=0A>>=A0 =A0 =A0 >=A0 =A0 =A0 >=0A>>=A0 =A0 =A0 >=0A>>=A0 =
=A0 =A0 >=A0 =A0 I'm unsure, although this would be possible to backport=0A=
>>=A0 =A0 =0A portions of the=0A>>=A0 =A0 =A0 >=A0 =A0 logic, the implement=
ation has now diverged significantly=0A>>=A0 =A0  between the=0A>>=A0 =A0 =
=A0 >=A0 =A0 2.x=0A>>=A0 =A0 =A0 >=A0 =A0 and 3.x code bases.=0A>>=A0 =A0 =
=A0 >=0A>>=A0 =A0 =A0 >=A0 =A0 Could you try the patch below? It's untested=
, but should work=0A>>=A0 =A0  around=0A>>=A0 =A0 =A0 >=A0 =A0 the=0A>>=A0 =
=A0 =A0 >=A0 =A0 root issue in your case:=0A>>=A0 =A0 =A0 >=0A>>=A0 =A0 =A0=
 >=A0 =A0 diff --git a/include/nucleus/compiler.h=0A>>=A0 =A0  b/include/nu=
cleus/compiler.h=0A>>=A0 =A0 =A0 >=A0 =A0 index 30f32c7..da4ea03 100644=0A>=
>=A0 =A0 =A0 >=A0 =A0 --- a/include/nucleus/compiler.h=0A>>=A0 =A0 =A0 >=A0=
 =A0 +++=0A b/include/nucleus/compiler.h=0A>>=A0 =A0 =A0 >=A0 =A0 @@ -37,9 =
+37,11 @@=0A>>=A0 =A0 =A0 >=0A>>=A0 =A0 =A0 >=A0 =A0 =A0 =A0 #ifdef __IN_XE=
NO__=0A>>=A0 =A0 =A0 >=A0 =A0 =A0 =A0 #if __GNUC__ =3D=3D 4 && __GNUC_MINOR=
__ =3D=3D 6=0A>>=A0 =A0 =A0 >=A0 =A0 -#define __constructor__ __attribute__=
((constructor, noclone))=0A>>=A0 =A0 =A0 >=A0 =A0 +#define __constructor__ =
__attribute__((constructor(200),=0A>>=A0 =A0  noclone))=0A>>=A0 =A0 =A0 >=
=A0 =A0 +#define __late_constructor__ __attribute__((constructor,=0A>>=A0 =
=A0  noclone))=0A>>=A0 =A0 =A0 >=A0 =A0 =A0 =A0 #else /* Gcc not 4.6 */=0A>=
>=A0 =A0 =A0 >=A0 =A0 -#define __constructor__ __attribute__((constructor))=
=0A>>=A0 =A0 =A0 >=A0  +#define __constructor__=0A __attribute__((construct=
or(200)))=0A>>=A0 =A0 =A0 >=A0 =A0 +#define __late_constructor__ __attribut=
e__((constructor))=0A>>=A0 =A0 =A0 >=A0 =A0 =A0 =A0 #endif /* Gcc not 4.6 *=
/=0A>>=A0 =A0 =A0 >=A0 =A0 =A0 =A0 #endif /* In xenomai */=0A>>=A0 =A0 =A0 =
>=0A>>=A0 =A0 =A0 >=A0 =A0 diff --git a/src/skins/common/rt_print.c=0A>>=A0=
 =A0  b/src/skins/common/rt_print.c=0A>>=A0 =A0 =A0 >=A0 =A0 index dfa8b33.=
.e056cd6 100644=0A>>=A0 =A0 =A0 >=A0 =A0 --- a/src/skins/common/rt_print.c=
=0A>>=A0 =A0 =A0 >=A0 =A0 +++ b/src/skins/common/rt_print.c=0A>>=A0 =A0 =A0=
 >=A0 =A0 @@ -738,7 +738,7 @@ static void forked_child_init(void)=0A>>=A0 =
=A0 =A0 >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spawn_printer_thread();=0A>>=A0 =
=A0 =A0=0A >=A0 =A0 }=0A>>=A0 =A0 =A0 >=0A>>=A0 =A0 =A0 >=A0 =A0 -static __=
constructor__ void __rt_print_init(void)=0A>>=A0 =A0 =A0 >=A0 =A0 +static _=
_late_constructor__ void __rt_print_init(void)=0A>>=A0 =A0 =A0 >=A0 =A0 =A0=
 =A0 {=0A>>=A0 =A0 =A0 > const char *value_str;=0A>>=A0 =A0 =A0 >=A0 =A0 =
=A0 =A0 =A0 =A0 unsigned long long period;=0A>>=A0 =A0 =A0 >=0A>>=A0 =A0 =
=A0 >=A0 =A0 --=0A>>=A0 =A0 =A0 >=A0 =A0 Philippe.=0A>>=A0 =A0 =A0 >=0A>>=
=A0 =A0 =A0 >=A0 =A0 I tried the patch. But I think it is not the correct v=
ersion of=0A>>=A0 =A0 =A0 >=A0 =A0 xenomai. In my compiler.h there is no li=
ne "#define=0A>>=A0 =A0  __constructor__=0A>>=A0 =A0 =A0 >=A0 =A0 __attribu=
te__((constructor,=0A noclone))". I use Xenomai 2.6.2.1.=0A>>=A0 =A0 =A0 >=
=0A>>=0A>>=A0 =A0  With 2.6.2.1, you need the patch below applied, before a=
pplying the=0A>>=A0 =A0  suggested work around:=0A>>=A0 =A0  6e89cb2287378a=
7dcbba987949d0168460dabbe7=0A>>=0A>>=A0 =A0  Bottom line is that all librar=
y constructor routines shall be tagged=0A>>=A0 =A0  with the __constructor_=
_ qualifier, except rt_print_init which=0A>>=A0 =A0  should be=0A>>=A0 =A0 =
 __late_constructor__ instead. Otherwise the change makes no sense.=0A>>=0A=
>>=A0 =A0  --=0A>>=A0 =A0  Philippe.=0A>>=0A>>=0A>> O.k. I used the revisio=
n "6e89cb2287378a7dcbba987949d0168460dabbe7" and=0A>> I use the patch (the =
workaround). But the failure is still the same. Any=0A>> other idea?=0A>=0A=
>Do you mention --with-__thread in your configuration line? If so, please =
=0A>retry without.=0A>=0A>-- =0A>Philippe.=0A>=0A>=0A>=0ADo you =0Amean the=
 configuration for xenomai befor I install it? I don't use any =0Aparameter=
. Is there a way to trace such a failure. I get the error from a programm, =
that is not developed be my selfe.=0A

References: <1374143094.1082.YahooMailNeo@web172202.mail.ir2.yahoo.com>
	<51E900B7.9070604@xenomai.org>
	<1374227358.60075.YahooMailNeo@web172203.mail.ir2.yahoo.com>
	<51E9106C.3000909@xenomai.org>
Message-ID: <1374231441.29790.YahooMailNeo@web172205.mail.ir2.yahoo.com>
Date: Fri, 19 Jul 2013 11:57:21 +0100 (BST)
From: Franz Engel <franz_lambert_engel@yahoo.de>
In-Reply-To: <51E9106C.3000909@xenomai.org>
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

=0A=0A=0A=0A=0A>________________________________=0A> Von: Philippe Gerum <r=
pm@xenomai.org>=0A>An: Franz Engel <franz_lambert_engel@yahoo.de> =0A>CC: "=
xenomai@xenomai.org" <xenomai@xenomai.org> =0A>Gesendet: 12:09 Freitag, 19.=
Juli 2013=0A>Betreff: Re: [Xenomai] __xn_sys_current_info failed: Operation=
 not permitted=0A> =0A>=0A>On 07/19/2013 11:49 AM, Franz Engel wrote:=0A>> =
Philippe wrote:=0A>>>> Franz Engel wrote:=0A>>>> Hi,=0A>>> >=0A>>>> I get t=
his error when I run a programm:=0A>>>> __xn_sys_current_info failed: Opera=
tion not permitted=0A>>> >=0A>>>> I know that the error comes from the asse=
rt_nrt_inner(void) function inside the assert_context.c file. But I have no=
 idea what is the reason. The Operation not permitted is the return value f=
rom XENOMAI_SYSCALL1(__xn_sys_current_info, &info);. But I found no documen=
tation about this function.=0A>>=0A>>=0A>>>This is reminiscent of a symptom=
 observed for a bug fixed in the -forge=0A>>>tree, a while ago:=0A>>>http:/=
/git.xenomai.org/?p=3Dxenomai-forge.git;a=3Dcommit;h=3D014898add6a697e1a0d6=
9f9e20b910ade74f1940=0A>>=0A>>>Do you happen to call fork() in your=A0 appl=
ication?=0A>>=0A>> Yes. I do? What I can do to solve the problem. Should I =
try to modify=0A>> the xenomai files as discrept in the git-link?=0A>>=0A>=
=0A>I'm unsure, although this would be possible to backport portions of the=
 =0A>logic, the implementation has now diverged significantly between the 2=
.x =0A>and 3.x code bases.=0A>=0A>Could you try the patch below? It's untes=
ted, but should work around the =0A>root issue in your case:=0A>=0A>diff --=
git a/include/nucleus/compiler.h b/include/nucleus/compiler.h=0A>index 30f3=
2c7..da4ea03 100644=0A>--- a/include/nucleus/compiler.h=0A>+++ b/include/nu=
cleus/compiler.h=0A>@@ -37,9 +37,11 @@=0A>=0A>=A0 #ifdef __IN_XENO__=0A>=A0=
 #if __GNUC__ =3D=3D 4 && __GNUC_MINOR__ =3D=3D 6=0A>-#define __constructor=
__ __attribute__((constructor, noclone))=0A>+#define __constructor__ __attr=
ibute__((constructor(200), noclone))=0A>+#define __late_constructor__ __att=
ribute__((constructor, noclone))=0A>=A0 #else /* Gcc not 4.6 */=0A>-#define=
 __constructor__ __attribute__((constructor))=0A>+#define __constructor__ _=
_attribute__((constructor(200)))=0A>+#define __late_constructor__ __attribu=
te__((constructor))=0A>=A0 #endif /* Gcc not 4.6 */=0A>=A0 #endif /* In xen=
omai */=0A>=0A>diff --git a/src/skins/common/rt_print.c b/src/skins/common/=
rt_print.c=0A>index dfa8b33..e056cd6 100644=0A>--- a/src/skins/common/rt_pr=
int.c=0A>+++ b/src/skins/common/rt_print.c=0A>@@ -738,7 +738,7 @@ static vo=
id forked_child_init(void)=0A>=A0 =A0=A0=A0 =A0=A0=A0 spawn_printer_thread(=
);=0A>=A0 }=0A>=0A>-static __constructor__ void __rt_print_init(void)=0A>+s=
tatic __late_constructor__ void __rt_print_init(void)=0A>=A0 {=0A>=A0 =A0=
=A0=A0 const char *value_str;=0A>=A0 =A0=A0=A0 unsigned long long period;=
=0A>=0A>-- =0A>Philippe.=0A>=0A>I tried the patch. But I think it is not th=
e correct version of xenomai. In my compiler.h there is no line "#define __=
constructor__ __attribute__((constructor, noclone))". I use Xenomai 2.6.2.1=
.=0A>

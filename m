Message-ID: <502E541F.7090801@axesseurope.com>
Date: Fri, 17 Aug 2012 16:24:31 +0200
From: Charles Retailleau <charles.retailleau@axesseurope.com>
MIME-Version: 1.0
References: <502D040F.2010906@axesseurope.com>
	<20120816144617.GD1237@csclub.uwaterloo.ca>
In-Reply-To: <20120816144617.GD1237@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Trying to get Xenomai on P1010RDB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

Thanks Lennart that was very useful, it now works.
Here is the little patch I made, yet I couldn't find a switch to force
it for core e500/e500xx only...


--- ./xenomai-2.6.1.orig/include/asm-powerpc/syscall.h	2011-11-09
13:21:36.000000000 +0100
+++ ./xenomai-2.6.1.mine/./include/asm-powerpc/syscall.h	2012-08-17
15:47:28.387435909 +0200
@@ -167,9 +167,9 @@
 	} u;
 	unsigned long __tbu;

-	__asm__ __volatile__("1: mftbu %0\n"
-			     "mftb %1\n"
-			     "mftbu %2\n"
+	__asm__ __volatile__("1: mfspr %0,269\n"
+			     "mfspr %1,268\n"
+			     "mfspr %2,269\n"
 			     "cmpw %2,%0\n"
 			     "bne- 1b\n":"=3Dr"(u.v[0]),
 			     "=3Dr"(u.v[1]), "=3Dr"(__tbu));
Thanks to all for your help
Charles,

Le 16/08/2012 16:46, Lennart Sorensen a =E9crit :
> On Thu, Aug 16, 2012 at 04:30:39PM +0200, Charles Retailleau
> wrote:
>> Hi all, The patching/compilation/installation steps seem fine.=20
>> But at the end I cannot have any Xenomai software running on the=20
>> P1010RDB (I tried most of the provided test SW).
>>=20
>> I focused on latency and tried to debug it. I get that:
>>=20
>> Program received signal SIGILL, Illegal instruction. 0x0ffde120
>> in __xn_rdtsc () from ....xenomai/lib/libnative.so.3
>>=20
>> It appears that the 'mftb/mftbu' instructions are in cause (cf.
>> the small test in attachment, the 1st part works but not the mftb
>> test). Furthermore when I check the core e500 ref manual=20
>> http://cache.freescale.com/files/32bit/doc/ref_manual/E500CORERM.pdf
>>
>>=20
MFTB appears has NOT being part of the instruction list.
>>=20
>> Yet, Xenomai seems to work on P1020RDB which has the same core,
>> so I'm confused... What did I do wrong ?
>>=20
>> I'm using Xenomai 2.6.1, linux 3.2.21 configured with
>> mpc85xx_defconfig (default options for the rest of it),=20
>> Freescale's SDK 1.1.2 (that's the main difference between me and=20
>> Lukasz Zemla's config on P1020RDB, so I'm trying to get the
>> latest 1.2)
>=20
> mftb is a phased out instruction according to the powerpc 2.06 rev=20
> B documentation.  mfspr is the prefered instruction to use instead
> on everything other than the old 603 and POWER3 CPUs.
>=20
> It is quite possible the e500 hence doesn't support it.  According
> to http://cache.freescale.com/files/32bit/doc/app_note/AN3445.pdf
> it specificly does NOT have mftb.  Neither does the e300 core which
> is what we are using with xenomai (MPC8360e specificly).
>=20


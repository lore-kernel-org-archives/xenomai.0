Message-ID: <502D040F.2010906@axesseurope.com>
Date: Thu, 16 Aug 2012 16:30:39 +0200
From: Charles Retailleau <charles.retailleau@axesseurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Trying to get Xenomai on P1010RDB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,
The patching/compilation/installation steps seem fine.
But at the end I cannot have any Xenomai software running on the
P1010RDB (I tried most of the provided test SW).

I focused on latency and tried to debug it. I get that:

Program received signal SIGILL, Illegal instruction.
0x0ffde120 in __xn_rdtsc () from ....xenomai/lib/libnative.so.3

It appears that the 'mftb/mftbu' instructions
are in cause (cf. the small test in attachment, the 1st part works but
not the mftb test).
Furthermore when I check the core e500 ref manual
http://cache.freescale.com/files/32bit/doc/ref_manual/E500CORERM.pdf
MFTB appears has NOT being part of the instruction list.

Yet, Xenomai seems to work on P1020RDB which has the same core, so I'm
confused...
What did I do wrong ?

I'm using
   Xenomai 2.6.1,
   linux 3.2.21 configured with mpc85xx_defconfig (default options for
the rest of it),
   Freescale's SDK 1.1.2 (that's the main difference between me and
Lukasz Zemla's config on P1020RDB, so I'm trying to get the latest 1.2)

Thanks for your help.
Charles,
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: testMFTB.c
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120816/d22f48c=
2/attachment.c>

From: "Reitinger, Peter" <preitinger@carl-valentin.de>
Date: Mon, 28 Jul 2014 12:33:59 +0000
Message-ID: <b24043adb3d04d7caafb40f3c59e6a85@CVEX13.valentin-carl.de>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Bug fix suggestion
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

sorry I am ne wand not used tot he protocol of this mailing list.
But I think in file include/nucleus/seqlock.h (Xenomai Release 2.6.3), line=
 13, SEQCNT must be replaced by the XNSEQCNT which is defined one line abov=
e. Probably with some configurations it compiles if the an old linux/seqloc=
k.h is included before nucleus/seqlock.h which defines SEQCNT. But this doe=
s not work for linux 3.14.1.

Maybe I could help.

Kind regards
Peter Reitinger, carl-valentin, Germany

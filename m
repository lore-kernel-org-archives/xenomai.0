Message-ID: <50350308.8010405@openwide.fr>
Date: Wed, 22 Aug 2012 18:04:24 +0200
From: Romain Naour <romain.naour@openwide.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] s3c24xx: Priority rotate enable !?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

On s3c24xx processors the interrupt source priority isn't fixed by Adeos =

patch (ARB_SEL bits in PRIORITY register).
Is it intentional ?
It may be possible to give priority to an interrupt simultaneously =

arrived that the interruption IRQ_TIMER4 (before being grabbed by =

Adeos). Therefore, we can have more jitter for real time applications.

Do we need to fix the priority at this level ?

Thanks,
Romain


-------------- next part --------------
A non-text attachment was scrubbed...
Name: s3c24xx_fix_interrupt_priority.patch
Type: text/x-patch
Size: 514 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120822/ab2cabf=
a/attachment.bin>

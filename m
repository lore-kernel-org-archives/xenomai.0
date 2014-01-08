Message-ID: <52CCCE4F.4050304@steinkuehler.net>
Date: Tue, 07 Jan 2014 22:04:31 -0600
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
References: <44lhyrmuw9.fsf@be-well.ilk.org>
 <52CC7D71.4040703@steinkuehler.net> <52CC83F1.40000@xenomai.org>
 <52CC85C5.4060703@steinkuehler.net> <52CC8A18.2020807@xenomai.org>
 <52CCA101.2040604@steinkuehler.net>
In-Reply-To: <52CCA101.2040604@steinkuehler.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Altera Cyclone V
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 1/7/2014 6:51 PM, Charles Steinkuehler wrote:
> =

> Thanks for the details!  My to-do list just got longer...  :)
> =

> I'll do some testing (on the BeagleBone) and post the results, but it
> might take a couple of days.

I did a quick check with the BeagleBone kernels I've already built (no
IPipe debugging) and I'm getting much better results than the last time
I tested.  Typical latency is around 20 uS, and worst case is about 45
uS (although I obviously didn't run overnight!).

I've got about half of the suggested kernel settings "correct" already,
but the others need to be tweaked (including disabling SMP, thanks for
the hint!).  I tried using all the recommended settings, but the kernel
build failed when linking:

  LD      init/built-in.o
arch/arm/kernel/built-in.o: In function `__irq_usr':
:(.kprobes.text+0x3c2): relocation truncated to fit: R_ARM_THM_JUMP19
against symbol `__ipipe_ret_to_user_irqs_disabled' defined in .text
section in arch/arm/kernel/built-in.o
arch/arm/kernel/built-in.o: In function `ret_from_exception':
:(.kprobes.text+0x600): relocation truncated to fit: R_ARM_THM_JUMP19
against symbol `__ipipe_ret_to_user_irqs_disabled' defined in .text
section in arch/arm/kernel/built-in.o
make: *** [vmlinux] Error 1

The link error goes away if I disable CONFIG_THUMB2_KERNEL, which wasn't
set in the original kernel config.

I'll report details when I get some debug kernels tested and capture the
requested data.

-- =

Charles Steinkuehler
charles@steinkuehler.net

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140107/d19016a=
8/attachment.sig>

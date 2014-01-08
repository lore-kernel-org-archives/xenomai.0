Message-ID: <52CD0AA1.8050505@xenomai.org>
Date: Wed, 08 Jan 2014 09:21:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <44lhyrmuw9.fsf@be-well.ilk.org>
 <52CC7D71.4040703@steinkuehler.net> <52CC83F1.40000@xenomai.org>
 <52CC85C5.4060703@steinkuehler.net> <52CC8A18.2020807@xenomai.org>
 <52CCA101.2040604@steinkuehler.net> <52CCCE4F.4050304@steinkuehler.net>
In-Reply-To: <52CCCE4F.4050304@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Altera Cyclone V
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/08/2014 05:04 AM, Charles Steinkuehler wrote:
> On 1/7/2014 6:51 PM, Charles Steinkuehler wrote:
>> 
>> Thanks for the details!  My to-do list just got longer...  :)
>> 
>> I'll do some testing (on the BeagleBone) and post the results,
>> but it might take a couple of days.
> 
> I did a quick check with the BeagleBone kernels I've already built
> (no IPipe debugging) and I'm getting much better results than the
> last time I tested.  Typical latency is around 20 uS, and worst
> case is about 45 uS (although I obviously didn't run overnight!).
> 
> I've got about half of the suggested kernel settings "correct"
> already, but the others need to be tweaked (including disabling
> SMP, thanks for the hint!).  I tried using all the recommended
> settings, but the kernel build failed when linking:
> 
> LD      init/built-in.o arch/arm/kernel/built-in.o: In function
> `__irq_usr': :(.kprobes.text+0x3c2): relocation truncated to fit:
> R_ARM_THM_JUMP19 against symbol `__ipipe_ret_to_user_irqs_disabled'
> defined in .text section in arch/arm/kernel/built-in.o 
> arch/arm/kernel/built-in.o: In function `ret_from_exception': 
> :(.kprobes.text+0x600): relocation truncated to fit:
> R_ARM_THM_JUMP19 against symbol `__ipipe_ret_to_user_irqs_disabled'
> defined in .text section in arch/arm/kernel/built-in.o make: ***
> [vmlinux] Error 1
> 
> The link error goes away if I disable CONFIG_THUMB2_KERNEL, which
> wasn't set in the original kernel config.

Have you tried enabling workaround for broken gas?
CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11?

Also note that you may want to use a toolchain with hard floating
points. I use linaro toolchains for instance.


- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFSzQqhGpcgE6m/fboRAjqcAJ9RZpIOpB/btilqK7VdeXZEsgpJOQCdEBYg
4nGKdWB78EzLvKIDKwqpvs4=
=kE9J
-----END PGP SIGNATURE-----


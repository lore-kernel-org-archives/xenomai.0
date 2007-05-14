Message-ID: <464847B7.5020806@domain.hid>
Date: Mon, 14 May 2007 13:27:51 +0200
From: Benjamin Zores <benjamin.zores@domain.hid>
MIME-Version: 1.0
References: <464814D9.8070700@domain.hid>
	<1179135141.5045.53.camel@domain.hid>
In-Reply-To: <1179135141.5045.53.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Adeos for Linux 2.6.19 PowerPC kernels.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Philippe Gerum wrote:
> FWIW, I've almost finished an I-pipe port over 2.6.21 also using the
> arch/powerpc tree. It relies on the genirq layer which makes things way
> more comfortable, and which does not require to redefine particular ack
> routines but rather keep the original irqchip handlers.
>   
That's pretty cool !
Well, using the genirq layer is definitely the way to go but, as stated,
my patch was a port based adeos-1.5 which was kinda old.
> This should get better when the I-pipe/powerpc development is merged
> into the main git repo here, which should happen in a reasonable future:
> http://www.denx.de/cgi-bin/gitweb.cgi?p=ipipe-2.6.git;a=summary
>   
Well, I'm waiting for that too.
Most of embedded devels still relies on ppc arch instead of powerpc
and I hope this situation will change soon.

> Note: you are mixing my [and Karim's words] from the orginal Abstract
> with your words from the new Disclaimer, making the "we" clauses rather
> confusing. It should be more of a README.alcatel-lucent file than a
> README.adeos one.
>   
I can do so.

> I had a look at this patch, and I see two issues, one of which can't be
> solved easily unless you make your code use the genirq layer (see
> x86-1.7 series and beyond), the other one is simple to fix.
>   
I know.
That's why I said my patch is working but the implementation isn't as
nice as I'd like it to be.

> Calling mask_ack in __ipipe_ack works for edge/level IRQs, but would not
> be applicable to transparent controllers only requiring the software to
> send eoi, or per-cpu IRQ flows involving mask+eoi for instance.
> Basically, this code works because it assumes that all IRQs are somehow
> managed in level mode thus preventing the interrupt flood, but this may
> not be always the case. Working with the vanilla genirq layer solves
> this.
>   
I however won't have more time allowed
to update the patch to use genirq layer.

> The other issue is an old bug of mine for this port, specifically we
> need to call irq_enter()/irq_exit() for virtual interrupts too;
> otherwise, softirqs triggered by virtual ones might be delayed until the
> next hw interrupt comes in. Something like this would do:
> [...]
>   
Is this patch tested ?
It seems not to work, segfaulting kernel.

[...]
I-pipe 1.5-01: pipeline enabled.
Unable to handle kernel paging request for data at address 0x00000084
Faulting instruction address: 0xc001c874
Oops: Kernel access of bad area, sig: 11 [#1]
[...]


I can update the patch but I won't be able to switch to genirq layer.
So it's up to you to decide whether this patch gets commited or just lay
down on mailing lists archives.

Hoping to see your 2.6.21 patch soon ;-)

Ben



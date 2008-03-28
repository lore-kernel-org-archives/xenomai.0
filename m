Message-ID: <2ff1a98a0803280913l6c27f80fjc55634a28a1f3a2@domain.hid>
Date: Fri, 28 Mar 2008 17:13:56 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47ED140B.2040406@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <47ECBCAA.50701@domain.hid>
	<2ff1a98a0803280811n702cf80ble01c121959bbcf21@domain.hid>
	<47ED140B.2040406@domain.hid>
Subject: Re: [Xenomai-core] Porting Ipipe/Adeos patch to new arm9 board
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Neil Armstrong <narmstrong@domain.hid>
Cc: xenomai@xenomai.org

On Fri, Mar 28, 2008 at 4:51 PM, Neil Armstrong <narmstrong@domain.hid> wr=
ote:
> First of all, thanks for your aswer,
>  Gilles Chanteperdrix a =E9crit :
>
> >>  I patched the kernel with the arm1 patch (from the ARM website), the
>  >>  board non-rt patch enabling serial and the macb ethernet controller =
and
>  >>  finnally tried to apply the ipipe arm patch and resolving failures.
>  >
>  > At first sight, you call spin_lock_irqsave in __ipipe_mach_set_dec.
>  > This is illegal, __ipipe_mach_set_dec may (and will) be called from
>  > real-time context, you should be using the _hw variants. I do not know
>  > if it is what causes the oops, but it would cause an oops later.
>  I based my board patch on integrator's and s3c24xx code and they use
>  spin_lock_irqsave in __ipipe_mach_set_dec, but I found local_irq_save_hw
>  used on an AT91 patch.
>  Finally the change did nothing, are the integrator and s3c24xx patchs
>  up-to-date ?

Yes, it is me that is not up to date. spin_lock_irqsave automatically
detects if a vanilla spinlock or an ipipe spinlock is used. So,
provided that you defined the spinlock with IPIPE_DEFINE_SPINLOCK,
everything should be fine.

Anyway, you should look for an error like that ipipe_restore_root is
probably called from non-root domain, and ipipe_restore_root is the
function used by local_irq_restore.

>
>  Should I drop the arm1 patch from ARM ? and start from a fresh vanilla
>  kernel ?

Yes, you could try that. Otherwise, you can look for the wrong
local_irq_restore by bisecting in the kernel startup code with
printks...

--=20
 Gilles


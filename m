Message-ID: <2ff1a98a0806040940p23dec5c9oabac9a1233b601@domain.hid>
Date: Wed, 4 Jun 2008 18:40:51 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28C8@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28C5@domain.hid>
	<2ff1a98a0806040640s544b34d9rb11d833dd616bfae@domain.hid>
	<E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28C6@domain.hid>
	<2ff1a98a0806040754u8c3efd6u3121786c8fea43e@domain.hid>
	<E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28C8@domain.hid>
Subject: Re: [Xenomai-core] system hangs with "ifconfig eth0 down"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Markus Osterried <markus.osterried@domain.hid>
Cc: Xenomai-core@domain.hid

On Wed, Jun 4, 2008 at 5:09 PM, Markus Osterried
<markus.osterried@domain.hid> wrote:
> Hi,
>
> our kernel (along with the device drivers) is specifically adapted to
> our embedded system, it would be a huge bunch of work to change the
> kernel.
> I think to do the ipipe backport is a lot easier.

I do not have time to do a git diff right now, but you can find the
changes yourself by looking into the latest patches for the changes in
include/linux/mm.h and mm/memory.c


-- 
 Gilles


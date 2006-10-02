Message-ID: <45211492.6080109@domain.hid>
Date: Mon, 02 Oct 2006 15:30:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] SH4 port
References: <003e01c6e6ee$d0ba19e0$1501a8c0@domain.hid>
In-Reply-To: <003e01c6e6ee$d0ba19e0$1501a8c0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig95EC4EE321E2E013285050D8"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kiichi Kameda <k-kameda@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig95EC4EE321E2E013285050D8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Kiichi Kameda wrote:
> Thank you for your effort.
>=20
>> Jan Kiszka wrote:
>>> Kiichi Kameda wrote:
>>>> ...
>>>> After tough investigation, I think I found some clues such as:
>>>> While in.ftpd runs hard, a "write" system call was issued and Linux
>>>> kernel was processing its request.
>>>>  But weird __ipipe_dispatch_event and __ipipe_sync_stage was recorde=
d.
>>>>
>>>> I think the problem originates from a Xenomai context switch(which
>>>> overwrites "current"), while Linux is processing  system call.
>>> If I interpret linux/include/asm-sh/current.h correctly, current is
>>> derived from the stack on your platform (like on most archs) and cann=
ot
>> That's nonsense as I realised later by following the code down to
>> include/asm-sh/thread_info.h: current_thread_info seems to get
>> referenced by some register.
>=20
> In original SH-Linux ,"current" is based on r7_bank register in SH CPU
>  which is set only at context switch.  "current" macro which is
> referenced everywhere(including page fault handling and stack pointer
> setting
> at interrupt from userspace), depends on this special register.
> r7_bank register has nothing to do with stack.

Yep, that's what I understood as well meanwhile.

>=20
> So, I created modified version of  SH-Linux code , where "current" macr=
o
> uses
> the stack pointer(SP & ~(THREAD_SIZE) -1).
> After that, although Linux seems to work well, the Xenomai thread still=

> causes system panic, if I once run the Xenomai program that uses POSIX =
skin.

And that's something I do not understand. What was your idea behind this
step?

>=20
> The panic messsage:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Unable to handle kernel paging request. at virtual address 00100104
> pc =3D 8c010658 <--requeue_task
> *pde =3D 00000000
> Oops: 0001 [#1]
>=20
> Pid : 948, Comm:              in.ftpd
> PC  : 8c010658 SP  : 8debfab0 SR  : 40008101 .TEA : c0198044    .Not
> tainted
> R0  : 8c19e958 R1  : 8c19ed10 R2  : 00100100 R3  : 00200200
> R4  : 8c2769a0 R5  : 8c19e958 R6  : 00000050 R7  : 8c2769c0
> R8  : 8c2769a0 R9  : 00000000 R10 : 00000050 R11 : 8c2769a0
> R12 : 8c2769e0 R13 : 8c19e928 R14 : 8debfab0
> MACH: 0000027e MACL: b851edb4 GBR : 29568be0 PR  : 8c0112b6.
> Call trace:
> =3D=3D top
> [<8c0112b6>] scheduler_tick
> [<8c0d4d88>] smc_hard_start_xmit
> [<8c00eb38>] __do_page_fault
> [<8c01f828>] update_process_time
> [<8c009988>] handle_timer_tick
> [<8c00bd72>] tmu_timer_interrupt
> [<8c03303a>] handle_IRQ_event
> [<8c0330fa>] __do_IRQ
> [<8c00d0f6>] __ipipe_do_IRQ
> [<8c0342e4>] __ipipe_sync_stage
> [<8c00d146>] __ipipe_grab_timer
> [<8c010582>] dequeue_task
> [<8c010876>] deactivate_task
> [<8c1505d6>] schedule
> [<8c15134c>] io_schedule
> [<8c036406>] sync_page
> [<8c151736>] __wait_on_bit_lock
> [<8c036d90>] __lock_page
> [<8c038050>] file_map_nopage
> [<8c0444aa>] __handle_mm_fault
> [<8c00e7f0>] do_page_fault
> [<8c0af240>] csum_partial_copy_generic
> [<8c125b64>] tcp_sendmsg
> [<8c141c14>] inet_sendmsg
> [<8c0f97f6>] do_sock_write
> [<8c0f98ec>] sock_aio_write
> [<8c01f74c>] run_timer_softirq
> [<8c04e6ba>] do_sync_write
> [<8c0343f6>] __ipipe_dispatch_event
> [<8c04e78a>] vfs_write
> [<8c04e8f4>] sys_write
> [<8c0062c4>] syscall_call
> =3D=3D bottom
> Kernel panic - not syncing: Aiee, killing interrupt handler!..
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Is it right that, while in.ftpd tries to send TCP packet,
> scheduler_tick is called and requeue_task the "current" task?
>=20
> Or, is threre any lack of code at returning to Linux.
>=20
>> Still the question remains for me why this should be a general Xenomai=

>> problem. Xenomai may overwrite the content on switch_to (but I don't
>> know your patch, how you realised context switches between RT tasks on=

>> SH4), but then it should definitely also restore it again on returning=

>> to Linux.
>>
>> Jan
>>
>=20
> Attached is some SH-related code.
>=20
> xenomai-2.2.0/ksrc/arch/sh/*
> xenomai-2.2.0/include/asm-sh/*
> linux-2.6.17.7/arch/sh/kernel/*
> linux-2.6.17.7/arch/sh/mm/*
> linux-2.6.17.7/include/asm-sh/*

Hmm, not very handy for a review. Also the ipipe patch is missing.
Please post future revisions as real patches (one for ipipe against the
vanilla kernel, one for Xenomai against SVN, preferably trunk).

Anyway, poking into (probably) the heart of the problem I stumbled over
this:

[ksrc/arch/sh/switch.c]

void rthal_switch_to(xnarchtcb_t *prev, xnarchtcb_t *next)
{
=2E..
        /*
         * Restore the kernel mode register
         *      k7 (r7_bank1)
         */
	if(next->user_task) {

            asm volatile("ldc       %0, r5_bank"
                     : /* no output */
                     : "r" (next->user_task->thread_info));
	}

Is there a particular reason why comment and reality diverge regarding
the thread_info register? Could this cause your troubles?

Jan


--------------enig95EC4EE321E2E013285050D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFIRSSniDOoMHTA+kRAhX2AJ9lEktEMv0IrdJlEiHKa10ktot9nACeJU3F
HElhpsajn6NwPs0HffoB0xI=
=E0p1
-----END PGP SIGNATURE-----

--------------enig95EC4EE321E2E013285050D8--


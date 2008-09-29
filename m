Message-ID: <48E13433.5060106@domain.hid>
Date: Mon, 29 Sep 2008 16:01:55 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <48E12C7D.4050802@domain.hid>
In-Reply-To: <48E12C7D.4050802@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Ipipe causes PCI / USB crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

Steven A. Falco wrote:
> I have a Sequoia (PPC440EPx) evaluation board, with an Agere USB interface
> plugged into the PCI bus.  The kernel is DENX 2.6.26.1 with Ipipe 2.2-04
> from the xenomai-2.4.5 release.

I tried turning on more debugging, and captured the following crash.  Line 1290
of buffer.c is in the following routine:

static inline void check_irqs_on(void)
{
#ifdef irqs_disabled
	BUG_ON(irqs_disabled());     <----- line 1290
#endif
}

where irqs_disabled() is defined as __ipipe_test_root()


kernel BUG at /n/maytag/proj/hydra/sw/sfalco/linux-2.6-denx/fs/buffer.c:1290!
Oops: Exception in kernel mode, sig: 5 [#1]
Hydra_temp
Modules linked in:
NIP: c00d7b48 LR: c00d7d7c CTR: c010701c
REGS: ced5da40 TRAP: 0700   Not tainted  (2.6.26.1-00044-g93df51c-dirty)
MSR: 00029000 <EE,ME>  CR: 44028082  XER: 20000000
TASK = cf8c79c0[967] 'snmpd' THREAD: ced5c000
GPR00: 00000001 ced5daf0 cf8c79c0 cf410680 00000001 00000000 00017201 00000400
GPR08: cec87a00 c0380000 0000000b 00017201 44028082 10213ff4 cf5b2b80 1f9eef0f
GPR16: 00000040 bfd60d24 ced5de8c ced5dd88 cf5a73f8 cf5a73f8 00000000 00017201
GPR24: cf410680 ced5dc70 24028084 00000400 cf5a73f8 00000000 c037a898 cf5b2b80
NIP [c00d7b48] __find_get_block+0x28/0x238
LR [c00d7d7c] __getblk+0x24/0x2b0
Call Trace:
[ced5daf0] [ced5dba0] 0xced5dba0 (unreliable)
[ced5db40] [c00d7d7c] __getblk+0x24/0x2b0
[ced5dba0] [c0100ab4] ext3_getblk+0xcc/0x204
[ced5dc00] [c0101d00] ext3_bread+0x18/0xb8
[ced5dc20] [c0104b48] dx_probe+0x58/0x378
[ced5dc50] [c01050e0] ext3_find_entry+0x278/0x634
[ced5dd10] [c0107064] ext3_lookup+0x48/0x128
[ced5dd40] [c00b8868] do_lookup+0x16c/0x1f0
[ced5dd70] [c00ba45c] __link_path_walk+0x57c/0xda8
[ced5dde0] [c00bacd0] path_walk+0x48/0xc8
[ced5de10] [c00baf4c] do_path_lookup+0x68/0x16c
[ced5de40] [c00bbc30] __path_lookup_intent_open+0x58/0xc4
[ced5de70] [c00bbfc8] do_filp_open+0x88/0x7d0
[ced5df20] [c00adac8] do_sys_open+0x5c/0xfc
[ced5df40] [c000ea4c] ret_from_syscall+0x0/0x3c
Instruction dump:
813f000c 4bffffac 9421ffb0 7c0802a6 7d800026 bf210034 90010054 91810030
3d20c038 8009a898 3bc9a898 540007fe <0f000000> 38000008 7c0903a6 3d20c03c
---[ end trace 8408831a88b0a69c ]---



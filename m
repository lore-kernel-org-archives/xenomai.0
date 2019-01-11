Message-ID: <1547214433.2322.7.camel@smigroup.net>
Subject: Re: FPU warn on ipipe 4.9.146-8 i386
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Fri, 11 Jan 2019 14:47:13 +0100
In-Reply-To: <20190111104056.71950ea6@md1za8fc.ad001.siemens.net>
References: <1547197070.2322.4.camel@smigroup.net>
 <20190111104056.71950ea6@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, Mauro Salvini via Xenomai <xenomai@xenomai.org>

On Fri, 2019-01-11 at 10:40 +0100, Henning Schild wrote:
> Am Fri, 11 Jan 2019 09:57:50 +0100
> schrieb Mauro Salvini via Xenomai <xenomai@xenomai.org>:
>=20
> > Hi all,
> >=20
> > I'm testing same hardware of [1], with kernel 4.9.146 from ipipe-
> > 4.9.y
> > with [2] applied, compiled with ARCH=3Di386 and Xenomai 3.0.7.
>=20
> To be honest i386 is not really tested anymore, in fact in 4.14 not
> even supported at the moment. If you can you should go for x86_64.
>=20

Hi Henning,

Thank you. I'm trying i386 version due to legacy 32bit code that uses
rtnet (which cannot be used with mixed ABI).

> > Launching
> >=20
> > xeno-test -l "dohell -s xxx -p yyy -m xxx 90000" -T 90000
> >=20
> > I got this dump in dmesg, sometimes=C2=A0just after latency starts,
> > sometimes after few seconds (side effect is a max latency value
> > increase):
> >=20
> > [=C2=A0=C2=A0167.914184] ------------[ cut here ]------------
> > [=C2=A0=C2=A0167.914208] WARNING: CPU: 0 PID: 606
> > at /home/build-ws/develop/linux-
> > 4.9.146/arch/x86/include/asm/fpu/internal.h:511
> > fpu__restore+0x1eb/0x2b0 [=C2=A0=C2=A0167.914216] Modules linked in:
> > intel_rapl
> > intel_powerclamp iTCO_wdt iTCO_vendor_support coretemp kvm_intel
> > kvm
> > irqbypass crc32_pclmul aesni_intel xts aes_i586 lrw gf128mul
> > ablk_helper cryptd snd_pcm intel_cstate snd_timer evdev snd
> > soundcore
> > i915 pcspkr drm_kms_helper drm fb_sys_fops syscopyarea sysfillrect
> > sysimgblt shpchp video lpc_ich mfd_core button ip_tables x_tables
> > autofs4 ext4 crc16 jbd2 fscrypto mbcache hid_generic usbhid hid
> > mmc_block crc32c_intel i2c_i801 i2c_smbus igb i2c_algo_bit xhci_pci
> > ptp pps_core xhci_hcd sdhci_pci sdhci usbcore mmc_core fjes [last
> > unloaded: rtnet] [=C2=A0=C2=A0167.914768] CPU: 0 PID: 606 Comm: dohel=
l Not
> > tainted 4.9.146+ #1 [=C2=A0=C2=A0167.914772] Hardware name: Default s=
tring
> > Default string/Q7-BW, BIOS V1.20#KW050220A 03/16/2018
> > [=C2=A0=C2=A0167.914775]
> > I-pipe domain: Linux [=C2=A0=C2=A0167.914778]=C2=A0=C2=A0f42e5e44 dae=
ffa2d 00000000
> > db335030 dac1ff3b f42e5e74 dac59dea db34504c
> > [=C2=A0=C2=A0167.914800]=C2=A0=C2=A000000000
> > 0000025e db335030 000001ff dac1ff3b 000001ff f4291bc0 00000246
> > [=C2=A0=C2=A0167.914822]=C2=A0=C2=A0f4291c00 f42e5e88 dac59efb 000000=
09 00000000
> > 00000000
> > f42e5ea4 dac1ff3b [=C2=A0=C2=A0167.914843] Call Trace:
> > [=C2=A0=C2=A0167.914846]=C2=A0=C2=A0[<daeffa2d>] dump_stack+0x9f/0xc2
> > [=C2=A0=C2=A0167.914849]=C2=A0=C2=A0[<dac1ff3b>] ? fpu__restore+0x1eb=
/0x2b0
> > [=C2=A0=C2=A0167.914865]=C2=A0=C2=A0[<dac59dea>] __warn+0xea/0x110
> > [=C2=A0=C2=A0167.914868]=C2=A0=C2=A0[<dac1ff3b>] ? fpu__restore+0x1eb=
/0x2b0
> > [=C2=A0=C2=A0167.914871]=C2=A0=C2=A0[<dac59efb>] warn_slowpath_null+0=
x2b/0x30
> > [=C2=A0=C2=A0167.914874]=C2=A0=C2=A0[<dac1ff3b>] fpu__restore+0x1eb/0=
x2b0
> > [=C2=A0=C2=A0167.914877]=C2=A0=C2=A0[<dac21b0a>] __fpu__restore_sig+0=
x2ba/0x680
> > [=C2=A0=C2=A0167.914879]=C2=A0=C2=A0[<dac22141>] fpu__restore_sig+0x3=
1/0x50
> > [=C2=A0=C2=A0167.914882]=C2=A0=C2=A0[<dac13f52>] restore_sigcontext.i=
sra.9+0xf2/0x110
> > [=C2=A0=C2=A0167.914885]=C2=A0=C2=A0[<dac149b9>] sys_sigreturn+0xa9/0=
xc0
> > [=C2=A0=C2=A0167.914888]=C2=A0=C2=A0[<dac019f5>] do_int80_syscall_32+=
0x85/0x190
> > [=C2=A0=C2=A0167.914891]=C2=A0=C2=A0[<db1a56d5>] entry_INT80_32+0x31/=
0x31
> > [=C2=A0=C2=A0167.914898]
> > ---[ end trace e57344f10f300a76 ]---
>=20
> I am not sure which path leads you there. But it could well be a
> state
> that was caused by the ipipe patch.
>=20
> could you try this:
>=20
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -426,6 +426,10 @@ void fpu__restore(struct fpu *fpu)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Avoid __kernel_fpu_b=
egin() right after fpregs_activate()
> */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kernel_fpu_disable();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace_x86_fpu_before_re=
store(fpu);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (fpregs_activate(fpu)) {

This instruction does not compile due to fpregs_activate() returns
void, perhaps did you mean "if (fpregs_active(fpu))"?
Given that fpregs_active() have no args, I tried with this:

if (fpu->fpregs_active)

and warning does not raise (even warning added with this patch).

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0WARN_ON_FPU(fpu !=3D
> this_cpu_read_stable(fpu_fpregs_owner_ctx));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0fpregs_deactivate(fpu);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fpregs_activate(fpu);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0copy_kernel_to_fpregs(&=
fpu->state);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace_x86_fpu_after_res=
tore(fpu);
>=20
> This would not be a proper fix, especially if you end up seeing that
> warning ...
>=20
> Henning
>=20
> > I found discussion at [3], and applied patch at [4] that comes from
> > it, but result is the same.
> >=20
> > Starting xeno-test without -l argument result is the same.
> > Launching dohell alone (with same arguments as when launched from
> > xeno- test -l), dump does not appear.
> >=20
> > Could be a Xenomai-related problem (though the stack seems not
> > concern
> > Xenomai) or it is better to post it on LKML?
> >=20
> > Thanks in advance, regards
> >=20
> > Mauro
> >=20
> > [1] https://xenomai.org/pipermail/xenomai/2018-December/040142.html
> > [2] https://xenomai.org/pipermail/xenomai/2019-January/040172.html
> > [3]
> > https://lore.kernel.org/lkml/20181120102635.ddv3fvavxajjlfqk@linutr
> > onix.de/ [4]
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/co
> > mmit/?h=3Dlinux-4.9.y&id=3Dd3741e0390287056011950493a641524f49fa05a
> >=20
> >=20
>=20
>=20


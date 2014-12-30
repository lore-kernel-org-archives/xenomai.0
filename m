Message-ID: <C162583A9AFD46C5BE6BF944025F777B@itd206>
From: "Sureshvs" <sureshvs@datapatterns.co.in>
Date: Tue, 30 Dec 2014 16:34:59 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Reg:Linux-3.10.32-xen-2.6.3 kernel panic
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Srikanth <srikanth.ramarao@datapatterns.co.in>

Hi

        Arch: powerpc 32bit
        Target Processor : 8641D
        Linux kernel:     3.10.32 with SMP
        Xenomai : 2.6.3
       Boot parameter    root=3D/dev/nfs rw =
nfsroot=3D10.5.2.26:/opt/fc17fs_sband =
ip=3D10.5.2.20:10.5.2.26:10.5.18.4:255.255.255.0:VPX1234:eth0:off =
console=3DttyS0,115200
   =20
       =20
      While testing 1553B Linux driver with SMP kernel option enabled we =
are getting oops message mentioned below.\
We are not getting any problem in non-smp mode.

        We are using spin_lock_irqsave  for updating the global status =
between ISR and task.
    While debugging we found that  spin_lock_irqsave is giving =
problem.so kindly help us to solve the problem as  soon as possible.



[ 253.985335] Unable to handle kernel paging request for unknown fault
[ 253.991687] Faulting instruction address: 0xa051e718

[ 253.996655] Oops: Kernel access of bad area, sig: 7 [#1]

[ 254.001957] SMP NR_CPUS=3D2 VPX

[ 254.004921] Modules linked in: dp1553bxt(O)

[ 254.009109] CPU: 0 PID: 1864 Comm: dp1553bxt_bcapp Tainted: G O =
3.10.32-dpvpx0689 #155

[ 254.017885] task: cf34d140 ti: cfff6000 task.ti: ce352000

[ 254.023274] NIP: a051e718 LR: a051e6fc CTR: a051e6e4

[ 254.028230] REGS: cfff7c80 TRAP: 0600 Tainted: G O (3.10.32-dpvpx0689)

[ 254.035875] MSR: 00009032 <EE,ME,IR,DR,RI> CR: 24002448 XER: 00000000

[ 254.042515] DAR: cf4fccf6, DSISR: 00010940

[ 254.046601]=20

GPR00: d359c9e4 cfff7d30 cf34d140 00000000 cf65e300 00000001 01146000 =
00000001=20

GPR08: 00000001 00000000 00000001 00000000 a051e6e4 1002d964 10110000 =
10110000=20

GPR16: 100d757c 10110000 cf55ca80 00000000 d359f0b4 00008000 cf65e300 =
00000001=20

GPR24: 00000001 00000000 cf55c000 0000004d 00000000 00000000 cf55c058 =
cf4fccf6=20

[ 254.076379] NIP [a051e718] _raw_spin_lock_irqsave+0x34/0x98

[ 254.081944] LR [a051e6fc] _raw_spin_lock_irqsave+0x18/0x98

[ 254.087419] Call Trace:

[ 254.089859] [cfff7d30] [cf41d000] 0xcf41d000 (unreliable)

[ 254.095267] [cfff7d40] [d359c9e4] DP1553BXT_ISR+0xcdc/0x111c =
[dp1553bxt]

[ 254.101969] [cfff7f90] [a0074c74] handle_irq_event_percpu+0x60/0x174

[ 254.108319] [cfff7fc0] [a0074dcc] handle_irq_event+0x44/0x74

[ 254.113976] [cfff7fe0] [a0078884] handle_edge_irq+0xcc/0x1b4

[ 254.119635] [cfff7ff0] [a000e6b8] call_handle_irq+0x18/0x28

[ 254.125207] [ce353a90] [a00061b0] handle_one_irq+0x94/0xf0

[ 254.130689] [ce353ab0] [a000f5f4] __ipipe_do_IRQ+0x8c/0xc0

[ 254.136175] [ce353ad0] [a007f99c] __ipipe_do_sync_stage+0x214/0x224

[ 254.142438] [ce353b00] [a007fc48] ipipe_unstall_root+0x74/0x90

[ 254.148272] [ce353b10] [a0024a90] vprintk_emit+0x1b0/0x498

[ 254.153756] [ce353b60] [a0521d08] printk+0x128/0x1c0

[ 254.158719] [ce353bb0] [d358cb78] =
DP1553BXT_BC_CreateOpcodes+0x3c8/0x6d8 [dp1553bxt]

[ 254.166461] [ce353de0] [d358de50] =
DP1553BXT_BC_CreateMinorFrame+0x394/0x514 [dp1553bxt]

[ 254.174462] [ce353e30] [d3587154] dp1553bxt_ioctl+0x8ec/0x1ac4 =
[dp1553bxt]

[ 254.181332] [ce353ea0] [a012ccac] do_vfs_ioctl+0x98/0x768

[ 254.186726] [ce353f10] [a012d3bc] SyS_ioctl+0x40/0x74

[ 254.191776] [ce353f40] [a0011788] ret_from_syscall+0x0/0x38

[ 254.197343] --- Exception: c01 at 0xfec3098

[ 254.197343] LR =3D 0xfec3000

[ 254.204556] Instruction dump:

[ 254.207517] 7c0802a6 93e1000c 7c7f1b78 90010014 4baf0ca9 7c630034 =
5463d97e 54637820=20

[ 254.215282] 39400001 7d20f828 2c090000 40820010 <7d40f92d> 40a2fff0 =
4c00012c 2f890000=20

[ 254.246333] ---[ end trace 18a6c7160b20ef21 ]---

[ 254.250940]=20

[ 255.252470] Kernel panic - not syncing: Fatal exception in interrupt

[ 255.258821] drm_kms_helper: panic occurred, switching back to text =
console

[ 255.265786] Rebooting in 180 =
seconds..H=A8H=A8=D5=12=BD=BD=D1=81=C9=C1=C1=E5=B9=C1=D9=81=A19=BD=D9=81=C1=
=DD=81=C9=C1=C5=D1=81=B5=81=C5=C9=E9=C5=D5=E9=CD=E1=A5=81.=D1.=81A.=D1=D1=
.=C9=B9=CD=81AYAa=C1=D9=E1=E5=81M=20

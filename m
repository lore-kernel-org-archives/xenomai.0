From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Thu, 15 Jan 2015 11:09:11 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC9123428FAE5D@SMExchange01.siebmeyer.org>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] arch arm no pci irq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi

I have the kernel 3.14.17 with xenomai 2.6.4 and my own pci-fpga card that =
generates interrupts.

When i registry my pci irq with rt_intr_create() than i get the following w=
arning and no irq was fired.

The same configuration under x86 arch works fine.

Dmesg output:
sm36500001: ioctl(SM36500001_IOCGIRQ) =3D  385 <- this is the irq number th=
at i get after i called pci_enable_msi() in the driver
------------[ cut here ]------------
WARNING: CPU: 0 PID: 766 at arch/arm/kernel/ipipe.c:158 ipipe_set_irq_affin=
ity+0xa0/0xe0()
Modules linked in: g3k_036500001(O) g3k_shm(O) udlfb fb_sys_fops cp210x usb=
serial usb_f_eem g_ether usb_f_rndis u_ether libcomposite configfs evbug
CPU: 0 PID: 766 Comm: g3t_t_TestPci Tainted: G           O 3.14.17 #1
Backtrace:
[<80012f94>] (dump_backtrace) from [<80013130>] (show_stack+0x18/0x1c) r6:0=
000009e r5:00000009 r4:00000000 r3:00000000
[<80013118>] (show_stack) from [<80619cc4>] (dump_stack+0x78/0x94)
[<80619c4c>] (dump_stack) from [<80025764>] (warn_slowpath_common+0x6c/0x90=
) r4:00000000 r3:bf7c1b3c
[<800256f8>] (warn_slowpath_common) from [<800257ac>] (warn_slowpath_null+0=
x24/0x2c) r8:c09c2008 r7:00000000 r6:80888970 r5:c09c2000 r4:808bb4fb
[<80025788>] (warn_slowpath_null) from [<8001ae64>] (ipipe_set_irq_affinity=
+0xa0/0xe0)
[<8001adc4>] (ipipe_set_irq_affinity) from [<8009be70>] (xnintr_attach+0x34=
/0x2f0) r4:8088e500
[<8009be3c>] (xnintr_attach) from [<800e4318>] (rt_intr_create+0x23c/0x408)=
 r10:8088e500 r9:00000000 r8:c09c20d0 r7:00000000 r6:80888970 r5:c09c2000 r=
4:8088e500
[<800e40dc>] (rt_intr_create) from [<800cb51c>] (__rt_intr_create+0xa4/0x12=
c) r10:bf3e7080 r9:00000181 r8:beb4a000 r7:c09c2000 r6:00000000 r5:00000000=
 r4:beb4bfb0
[<800cb478>] (__rt_intr_create) from [<800b4464>] (hisyscall_event+0x194/0x=
384) r10:80982730 r9:00000000 r8:beb4bfb0 r7:80980208 r6:00000000 r5:bf3e70=
80 r4:8094dec0
[<800b42d0>] (hisyscall_event) from [<8008b338>] (ipipe_syscall_hook+0x64/0=
x6c) r10:808847a4 r9:8087699c r8:80888970 r7:8094dec0 r6:8095e900 r5:000000=
00 r4:00001198
[<8008b2d4>] (ipipe_syscall_hook) from [<8008a078>] (__ipipe_notify_syscall=
+0x124/0x23c) r5:0000119c r4:bf7c1b3c
[<80089f54>] (__ipipe_notify_syscall) from [<8000f8e0>] (pipeline_syscall+0=
x8/0x24) r10:00000000 r9:beb4a000 r8:8000f988 r7:000f0042 r6:00000181 r5:00=
000000 r4:00000000
---[ end trace a798983a93a8fa82 ]---

Any idias what is going wrong?

regards
Alexander



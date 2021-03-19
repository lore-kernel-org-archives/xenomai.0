From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: RTDM vs. "dovetail: implement interrupt management, handling"
Date: Fri, 19 Mar 2021 03:15:08 +0000
Message-ID: <MWHPR11MB1710CFF09F7EB52B8F8B9D3AF2689@MWHPR11MB1710.namprd11.prod.outlook.com>
References: <b4d2aefd-a2fe-6d95-2ad8-7ddb881f3f66@siemens.com>
 <87sg4smngm.fsf@xenomai.org>
In-Reply-To: <87sg4smngm.fsf@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

>
>
>-----Original Message-----
>From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Philippe Gerum vi=
a Xenomai
>Sent: Friday, March 19, 2021 12:33 AM
>To: Jan Kiszka <jan.kiszka@siemens.com>
>Cc: Xenomai <xenomai@xenomai.org>
>Subject: Re: RTDM vs. "dovetail: implement interrupt management, handling"
>
>
>Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> Hi Philippe,
>>
>> with that patch, namely
>>
>> void xnintr_enable(struct xnintr *intr)
>> {
>> 	secondary_mode_only();
>> 	enable_irq(intr->irq);
>> }
>>
>> RTDM drivers stumble when using MSI and MSI-X, possibly also other
>> interrupts types:
>>
>> [64630.529207] Unbalanced enable for IRQ 145

I also met this issue . Is following patch OK to fix it?

diff --git a/kernel/cobalt/dovetail/intr.c b/kernel/cobalt/dovetail/intr.c
index 068dfe306..571d89c88 100644
--- a/kernel/cobalt/dovetail/intr.c
+++ b/kernel/cobalt/dovetail/intr.c
@@ -68,7 +68,7 @@ int xnintr_init(struct xnintr *intr, const char *name,
        intr->cookie =3D NULL;
        intr->name =3D name ? : "<unknown>";
        intr->flags =3D flags;
-       intr->status =3D 0;
+       intr->status =3D _XN_IRQSTAT_DISABLED;
        intr->unhandled =3D 0;    /* unused */
        raw_spin_lock_init(&intr->lock); /* unused */

@@ -110,14 +110,19 @@ EXPORT_SYMBOL_GPL(xnintr_detach);
 void xnintr_enable(struct xnintr *intr)
 {
        secondary_mode_only();
-       enable_irq(intr->irq);
+       if (test_and_clear_bit(XN_IRQSTAT_DISABLED, &intr->status)) {
+               trace_cobalt_irq_enable(intr->irq);
+               enable_irq(intr->irq);
+       }
 }
 EXPORT_SYMBOL_GPL(xnintr_enable);

 void xnintr_disable(struct xnintr *intr)
 {
        secondary_mode_only();
-       disable_irq(intr->irq);
+       trace_cobalt_irq_disable(intr->irq);
+       if (!test_and_set_bit(XN_IRQSTAT_DISABLED, &intr->status))
+               disable_irq(intr->irq);
 }
 EXPORT_SYMBOL_GPL(xnintr_disable);

>> [64630.529207] WARNING: CPU: 0 PID: 20057 at kernel/irq/manage.c:676
>> __enable_irq+0x36/0x60
>> [64630.529207] Modules linked in: univ(O+) veth xt_conntrack
>> xt_MASQUERADE xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat
>> nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter bridge
>> stp llc md4 md5 sha512_ssse3 sha512_generic cmac sha256_ssse3
>> sha256_generic libsha256 hmac nls_cp437 cifs libdes libarc4 overlay
>> x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul
>> crc32_pclmul ftdi_sio usbserial iTCO_wdt iTCO_vendor_support mei_me mei
>> ipmi_si ipmi_devintf ipmi_msghandler msr fuse configfs ip_tables
>> x_tables ipv6 autofs4 raid10 raid456 async_raid6_recov async_memcpy
>> async_pq async_xor xor async_tx hid_generic raid6_pq libcrc32c raid1
>> multipath usbhid linear hid raid0 e1000e i2c_i801 xhci_pci i2c_smbus igb
>> ahci i2c_algo_bit xhci_hcd libahci
>> [64630.529218] CPU: 0 PID: 20057 Comm: insmod Tainted: G           O
>>   5.10.19-xenomai-0 #1
>> [64630.529218] Hardware name: Supermicro X11SCZ-F/X11SCZ-F, BIOS
>> s1.2b_C2_01 05/14/2020
>> [64630.529218] IRQ stage: Linux
>> [64630.529219] RIP: 0010:__enable_irq+0x36/0x60
>> [64630.529219] Code: c0 74 18 83 f8 01 74 0a 83 e8 01 89 87 98 00 00 00
>> c3 f6 87 95 00 00 00 08 74 12 8b 77 2c 48 c7 c7 40 a3 d7 9a e8 31 41 68
>> 00 <0f> 0b c3 81 8f 90 00 00 00 00 04 00 00 ba 01 00 00 00 be 01 00 00
>> [64630.529219] RSP: 0018:ffffb85c45c3fa70 EFLAGS: 00010082
>> [64630.529220] RAX: 0000000000000000 RBX: ffff98bd42792200 RCX:
>> 0000000000000000
>> [64630.529220] RDX: 0000000000000023 RSI: ffff98c47bc17968 RDI:
>> ffff98c47bc17970
>> [64630.529220] RBP: 0000000000000091 R08: 0000000000000002 R09:
>> ffff98bd4209f908
>> [64630.529220] R10: 0000000000000000 R11: ffff98c47bc179c6 R12:
>> ffff98bd40cd2000
>> [64630.529221] R13: 0000000000000000 R14: 0000000000000013 R15:
>> ffff98bd4369a948
>> [64630.529221] FS:  00007f51c1f5c540(0000) GS:ffff98c47bc00000(0000)
>> knlGS:0000000000000000
>> [64630.529221] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [64630.529221] CR2: 000055b74066a1b0 CR3: 0000000103334001 CR4:
>> 00000000001706f0
>> [64630.529222] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [64630.529222] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [64630.529222] Call Trace:
>> [64630.529222]  enable_irq+0x46/0x90
>> [64630.529222]  rtdm_irq_request+0x57/0x80
>> [64630.529223]  init_one+0x67c/0x778 [univ]
>> [64630.529223]  local_pci_probe+0x3d/0x70
>> [64630.529223]  ? pci_assign_irq+0x27/0xd0
>> [64630.529223]  pci_device_probe+0xfc/0x1b0
>>
>> That's because it's driver business to call pci_enable_msi/msix which
>> enables everything needed under dovetail apparently. Is there no
>> separate (from Linux) masking bit in the dovetail pipeline?
>
>There is nothing pipeline-specific in this regard with Dovetail anymore.
>
>ipipe_{enable, disable}_irq() bring no additional masking bit per
>se. They merely bypass the common nesting and locking rules by calling
>the corresponding chip handler directly. ipipe_enable() also has the
>side-effect of starting up a channel first if need be, which is pretty
>much a kludge, required at that time precisely because the I-pipe
>pretends not to follow the common rules wrt IRQ management.
>
>Initially, that scheme was supposed to allow enabling/disabling IRQs
>from any execution stage, until we figured out that some chip
>controllers would have to traverse code from complex stacks anyway,
>e.g. PCI, which at any rate, would require the caller to run in-band.
>
>> Because that
>> is what ipipe_enable/disable_irq was targeting. If not,
>> xnintr_enable/disable should likely be nops over dovetail, right?
>>
>
>That would be a quick way to implement backward compatibility with the
>assumption existing drivers make about the I-pipe bypassing the common
>IRQ management rules. In the long run, a RTDM driver should initialize
>like any regular driver in this regard, enabling particular interrupt
>channel(s) on entry only when there is no way anyone else could have
>done it after __setup_irq() has run. This is related to the fact that
>Dovetail does not provide any pipeline-specific call to register IRQs
>either. Common forms of request_irq() is enough, mentioning IRQF_OOB if
>need be for out-of-band handling.
>
>The basic idea is that Dovetail strictly follows by the common kernel
>logic when enabling/disabling IRQs, ipipe_{enable, disable}_irq() are
>mere bypasses of such logic, which makes them unsafe since they don't
>even abide by the proper locking rules (hence the requirement for
>Xenomai 2/3 to provide their own lock for serializing device interrupts,
>which does not solve other issues though, like IRQ migration or
>un-registration).
>
>> That would also make rtdm_irq_enable/disable nops which may cause other
>> issues, though we stated that those services are "for exceptional use on=
ly".
>>
>
>Indeed.
>
>--=20
>Philippe.
>


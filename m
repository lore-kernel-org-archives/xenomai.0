From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: RTDM vs. "dovetail: implement interrupt management, handling"
Message-ID: <b4d2aefd-a2fe-6d95-2ad8-7ddb881f3f66@siemens.com>
Date: Thu, 18 Mar 2021 16:33:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

with that patch, namely

void xnintr_enable(struct xnintr *intr)
{
	secondary_mode_only();
	enable_irq(intr->irq);
}

RTDM drivers stumble when using MSI and MSI-X, possibly also other
interrupts types:

[64630.529207] Unbalanced enable for IRQ 145
[64630.529207] WARNING: CPU: 0 PID: 20057 at kernel/irq/manage.c:676
__enable_irq+0x36/0x60
[64630.529207] Modules linked in: univ(O+) veth xt_conntrack
xt_MASQUERADE xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter bridge
stp llc md4 md5 sha512_ssse3 sha512_generic cmac sha256_ssse3
sha256_generic libsha256 hmac nls_cp437 cifs libdes libarc4 overlay
x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul
crc32_pclmul ftdi_sio usbserial iTCO_wdt iTCO_vendor_support mei_me mei
ipmi_si ipmi_devintf ipmi_msghandler msr fuse configfs ip_tables
x_tables ipv6 autofs4 raid10 raid456 async_raid6_recov async_memcpy
async_pq async_xor xor async_tx hid_generic raid6_pq libcrc32c raid1
multipath usbhid linear hid raid0 e1000e i2c_i801 xhci_pci i2c_smbus igb
ahci i2c_algo_bit xhci_hcd libahci
[64630.529218] CPU: 0 PID: 20057 Comm: insmod Tainted: G           O
  5.10.19-xenomai-0 #1
[64630.529218] Hardware name: Supermicro X11SCZ-F/X11SCZ-F, BIOS
s1.2b_C2_01 05/14/2020
[64630.529218] IRQ stage: Linux
[64630.529219] RIP: 0010:__enable_irq+0x36/0x60
[64630.529219] Code: c0 74 18 83 f8 01 74 0a 83 e8 01 89 87 98 00 00 00
c3 f6 87 95 00 00 00 08 74 12 8b 77 2c 48 c7 c7 40 a3 d7 9a e8 31 41 68
00 <0f> 0b c3 81 8f 90 00 00 00 00 04 00 00 ba 01 00 00 00 be 01 00 00
[64630.529219] RSP: 0018:ffffb85c45c3fa70 EFLAGS: 00010082
[64630.529220] RAX: 0000000000000000 RBX: ffff98bd42792200 RCX:
0000000000000000
[64630.529220] RDX: 0000000000000023 RSI: ffff98c47bc17968 RDI:
ffff98c47bc17970
[64630.529220] RBP: 0000000000000091 R08: 0000000000000002 R09:
ffff98bd4209f908
[64630.529220] R10: 0000000000000000 R11: ffff98c47bc179c6 R12:
ffff98bd40cd2000
[64630.529221] R13: 0000000000000000 R14: 0000000000000013 R15:
ffff98bd4369a948
[64630.529221] FS:  00007f51c1f5c540(0000) GS:ffff98c47bc00000(0000)
knlGS:0000000000000000
[64630.529221] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[64630.529221] CR2: 000055b74066a1b0 CR3: 0000000103334001 CR4:
00000000001706f0
[64630.529222] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[64630.529222] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[64630.529222] Call Trace:
[64630.529222]  enable_irq+0x46/0x90
[64630.529222]  rtdm_irq_request+0x57/0x80
[64630.529223]  init_one+0x67c/0x778 [univ]
[64630.529223]  local_pci_probe+0x3d/0x70
[64630.529223]  ? pci_assign_irq+0x27/0xd0
[64630.529223]  pci_device_probe+0xfc/0x1b0

That's because it's driver business to call pci_enable_msi/msix which
enables everything needed under dovetail apparently. Is there no
separate (from Linux) masking bit in the dovetail pipeline? Because that
is what ipipe_enable/disable_irq was targeting. If not,
xnintr_enable/disable should likely be nops over dovetail, right?

That would also make rtdm_irq_enable/disable nops which may cause other
issues, though we stated that those services are "for exceptional use only".

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


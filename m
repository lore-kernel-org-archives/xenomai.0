From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 1 Apr 2015 09:59:10 -0400
Message-ID: <20150401135910.GO29558@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] Hit BUG() in arch/arm/mm/pgd.c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

We are seeing occational hits on a BUG() statement in pgd.c:

static inline void pgd_holder_free(pgd_t *pgd)
{
        struct rb_node *node = pgd_table.rb_node;
        struct pgd_holder *p;
        unsigned long flags;

        pgd_table_lock(flags);

        while (node) {
                p = rb_entry(node, struct pgd_holder, rb);
                if ((unsigned long)pgd < (unsigned long)p->pgd)
                        node = node->rb_left;
                else if ((unsigned long)pgd > (unsigned long)p->pgd)
                        node = node->rb_right;
                else {
                        rb_erase(node, &pgd_table);
                        pgd_table_unlock(flags);
                        kfree(p);
                        return;
                }
        }

        pgd_table_unlock(flags);

        BUG(); <- this one
}

Any idea how that could be happening?

[  449.516096] kernel BUG at /build/linux-UzsXAQ/linux-3.12.33/arch/arm/mm/pgd.c:120!
[  449.531229] Internal error: Oops - BUG: 0 [#1] SMP ARM
[  449.541495] Modules linked in: qmi_wwan usbnet mii qcserial usb_wwan usbserial 8021q garp stp mrp llc l2tp_eth l2tp_netlink l2tp_core xfrm_user ip_gre ip_tunnel gre macvlan ti_pru_eth iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack dummy xeno_posix xeno_rtdm xeno_native xeno_nucleus iptable_filter ip_tables x_tables xhci_hcd dwc3 ahci_platform phy_omap_pipe3 phy_omap_usb2 at24 lm75 phy_omap_control dwc3_omap max6369_wdt [last unloaded: rcksapi_layer2]
[  449.627071] CPU: 1 PID: 6186 Comm: tput Tainted: G        W  O 3.12-1-am5726 #1 Debian 3.12.33-0.1RR14
[  449.645675] task: da037a80 ti: dd8ec000 task.ti: dd8ec000
[  449.656463] PC is at pgd_free+0x54/0x108
[  449.664300] LR is at __ipipe_spin_unlock_irqrestore+0x38/0xac
[  449.675784] pc : [<c001e424>]    lr : [<c00af924>] psr: 60000013
[  449.675784] sp : dd8edf20  ip : c0c481d4  fp : dd8ec000
[  449.698733] r10: 00000000  r9 : dd8ec000  r8 : c000faa8
[  449.709173] r7 : df7c90b4  r6 : 60000013  r5 : dd8e0000  r4 : 00000000
[  449.722218] r3 : c0c40bac  r2 : 00000000  r1 : c07b2b40  r0 : 00000000
[  449.735265] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM Segment user
[  449.749528] Control: 10c5387d  Table: 9dd2806a  DAC: 00000015
[  449.761010] Process tput (pid: 6186, stack limit = 0xdd8ec248)
[  449.772664] Stack: (0xdd8edf20 to 0xdd8ee000)
[  449.781372] df20: 00000000 df7c9080 da037a80 c0040a60 0000033c df7c9080 00000000 c0045488
[  449.797722] df40: 00000000 df530cc0 dd8ec000 00000001 00000000 c0120068 00040004 00000000
[  449.814071] df60: 00000000 da06d180 00000000 dd8ec000 000000f8 c000faa8 dd8ec000 00000000
[  449.830421] df80: 00000000 c0045c74 00000000 0007001e b6fa1774 b6fa1774 000000f8 c0045d0c
[  449.846770] dfa0: 00000000 c000f8c0 0007001e b6fa1774 00000000 0007000a b6fe54c0 00000000
[  449.863119] dfc0: 0007001e b6fa1774 b6fa1774 000000f8 bea68f67 00000001 b6feb000 00000000
[  449.879470] dfe0: 000000f8 bea66c44 b6f33083 b6ed8f96 60000030 00000000 00000000 00000000
[  449.895823] [<c001e424>] (pgd_free+0x54/0x108) from [<c0040a60>] (__mmdrop+0x20/0x74)
[  449.911482] [<c0040a60>] (__mmdrop+0x20/0x74) from [<c0045488>] (do_exit+0x25c/0x944)
[  449.927140] [<c0045488>] (do_exit+0x25c/0x944) from [<c0045c74>] (do_group_exit+0x3c/0xc4)
[  449.943667] [<c0045c74>] (do_group_exit+0x3c/0xc4) from [<c0045d0c>] (__wake_up_parent+0x0/0x18)
[  449.961233] Code: 1afffff9 e59f00a4 e1a01006 eb024531 (e7f001f2)
[  449.973514] ---[ end trace cf10233d41bbdcf6 ]---
[  449.982800] Fixing recursive fault but reboot is needed!

It seems to only happen as we are shutting down the system (so terminating
xenomai process and other things).

-- 
Len Sorensen


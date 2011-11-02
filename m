Message-ID: <4EB1B691.9020801@domain.hid>
Date: Wed, 02 Nov 2011 22:30:57 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20111102201210.GY30117@domain.hid>
In-Reply-To: <20111102201210.GY30117@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] irq related kernel crash with adeos 3.0.4 powerpc.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Lennart Sorensen <lsorense@domain.hid>
Cc: adeos-main@gna.org

On 11/02/2011 09:12 PM, Lennart Sorensen wrote:
> I am trying to get xenomai/adeos going with a 3.0 kernel, and am hitting
> some issues with the interrupts it seems.
> 
> 2.6.38 seems to be working OK, although it has some other issues that
> I was trying to see were solved by 3.0.
> 
> Does anyone have a suggestion on where to look in the code to debug this?
> 

Does this help? If not, then your .config would be welcome.

diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 707d297..c1e0b7e 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -257,6 +257,9 @@ static struct irq_chip qe_ic_irq_chip = {
 	.irq_unmask = qe_ic_unmask_irq,
 	.irq_mask = qe_ic_mask_irq,
 	.irq_mask_ack = qe_ic_mask_irq,
+#ifdef CONFIG_IPIPE
+	.irq_eoi = qe_ic_mask_irq,
+#endif
 };
 
 static int qe_ic_host_match(struct irq_host *h, struct device_node *node)

> Unable to handle kernel paging request for instruction fetch
> Faulting instruction address: 0x00000000
> Oops: Kernel access of bad area, sig: 11 [#1]
> RC8360 CM
> Modules linked in: fsl_mcc_driver(O) nciTMSkmod(P) spi_ds26514 rx1k5_spimux hdlc_raw hdlc_raw_eth hdlc_fr hdlc_ppp hdlc dummy xeno_native max6369_wdt iptable_filter ip_tables x_tables ucc_geth_driver firmware_class ltc4215 lm75 talitos
> NIP: 00000000 LR: c001e980 CTR: 00000000
> REGS: dfff7980 TRAP: 0400   Tainted: P           O  (3.0.0-2-8360e)
> MSR: 20001032<ME,IR,DR>   CR: 44002224  XER: 00000000
> TASK = dfb2cbd0[2525] 'ifconfig' THREAD: dfa68000
> GPR00: c001e968 dfff7a30 dfb2cbd0 c03bcc48 00000021 c03c90a4 c03c90a0 c03c90a4
> GPR08: 00000002 00000000 00000021 df804000 00000000 10018b20 00044b83 3b9aca00
> GPR16: dfff7bb0 10624dd3 c033ec80 00000000 c03ba000 00008000 dfff7bb8 c03ba000
> GPR24: c000eac4 000004a0 c03d8344 c03f0900 c03f5084 df805100 0000001d c03bcc48
> NIP [00000000]   (null)
> LR [c001e980] qe_ic_cascade_low_ipic+0x38/0x74
> Call Trace:
> [dfff7a30] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
> [dfff7a50] [c000eadc] __ipipe_ack_irq+0x18/0x28
> [dfff7a60] [c000eebc] __ipipe_handle_irq+0x130/0x15c
> [dfff7a90] [c000eff0] __ipipe_grab_irq+0x3c/0x70
> [dfff7aa0] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
> --- Exception: 501 at __ipipe_sync_stage+0x1a4/0x1f8
>      LR = __ipipe_unstall_root+0x58/0x5c
> [dfff7b60] [c00268e0] console_unlock+0x1a8/0x210 (unreliable)
> [dfff7b90] [c0070230] __ipipe_unstall_root+0x58/0x5c
> [dfff7ba0] [c0026e88] vprintk+0x198/0x394
> [dfff7c50] [c02eebb0] printk+0x134/0x1b0
> [dfff7ca0] [c00153f8] bad_page_fault+0xd4/0xfc
> [dfff7cb0] [c0010aa8] handle_page_fault+0x7c/0x80
> --- Exception: 400 at   (null)
>      LR = qe_ic_cascade_low_ipic+0x38/0x74
> [dfff7d70] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
> [dfff7d90] [c000eadc] __ipipe_ack_irq+0x18/0x28
> [dfff7da0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
> [dfff7dd0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
> [dfff7de0] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
> --- Exception: 501 at mld_sendpack+0x34c/0x458
>      LR = mld_sendpack+0x41c/0x458
> [dfff7f10] [c02d7f8c] mld_ifc_timer_expire+0x264/0x324
> [dfff7f40] [c0032fa4] run_timer_softirq+0x11c/0x214
> [dfff7fa0] [c002c7a4] __do_softirq+0xb4/0x16c
> [dfff7ff0] [c000e57c] call_do_softirq+0x14/0x24
> [dfa69cc0] [c0006090] do_softirq+0xb4/0xc8
> [dfa69ce0] [c002c4cc] irq_exit+0x48/0x58
> [dfa69cf0] [c006f9a8] __ipipe_sync_stage+0x1d8/0x1f8
> [dfa69d20] [c000ef88] __ipipe_grab_timer+0xa0/0xcc
> [dfa69d30] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
> --- Exception: 901 at unix_sock_destructor+0x4/0xe4
>      LR = __sk_free+0x28/0x174
> [dfa69df0] [c0020368] __wake_up+0x54/0x68 (unreliable)
> [dfa69e00] [c0223414] skb_dequeue+0x84/0xa4
> [dfa69e10] [c02b4134] unix_release_sock+0x244/0x254
> [dfa69e40] [c021cf74] sock_release+0x30/0xa4
> [dfa69e60] [c021d004] sock_close+0x1c/0x40
> <snip a bunch more just like it>
> 


-- 
Philippe.


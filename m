Message-ID: <51A43FAE.109@xenomai.org>
Date: Tue, 28 May 2013 07:25:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E9605457112439448B6B3ED284E06533317AFE96@mbx256-1.adm.swri.edu>
In-Reply-To: <E9605457112439448B6B3ED284E06533317AFE96@mbx256-1.adm.swri.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Spinlock Bad Magic Error ipipe-3.8.0 Branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Poole Jr, Donald R." <donald.poole@swri.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/28/2013 02:04 AM, Poole Jr, Donald R. wrote:

> I just pulled down the git://git.xenomai.org/ipipe.git => ipipe-3.8.0 branch and compiled for my BeagleBone, but on boot I receive the following error with backtrace:
> 
> omap-dma-engine omap-dma-engine: allocating channel for 25
> [    1.954937] BUG: spinlock bad magic on CPU#0, swapper/0/1
> [    1.960658]  lock: dma_chan_lock+0x0/0x20, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> [    1.969683] [<c001b2d0>] (unwind_backtrace+0x0/0xf0) from [<c02d2500>] (do_raw_spin_lock+0x14c/0x18c)
> [    1.979427] [<c02d2500>] (do_raw_spin_lock+0x14c/0x18c) from [<c04eeaa0>] (_raw_spin_lock_irqsave+0x4c/0x58)
> [    1.989814] [<c04eeaa0>] (_raw_spin_lock_irqsave+0x4c/0x58) from [<c003ebfc>] (omap_request_dma+0x24/0x1b8)
> [    2.000109] [<c003ebfc>] (omap_request_dma+0x24/0x1b8) from [<c02fb710>] (omap_dma_alloc_chan_resources+0x3c/0x50)
> [    2.011033] [<c02fb710>] (omap_dma_alloc_chan_resources+0x3c/0x50) from [<c02f9f3c>] (dma_chan_get+0x50/0xec)
> [    2.021501] [<c02f9f3c>] (dma_chan_get+0x50/0xec) from [<c02fa6a0>] (__dma_request_channel+0x114/0x1b8)
> [    2.031432] [<c02fa6a0>] (__dma_request_channel+0x114/0x1b8) from [<c0407df4>] (omap_hsmmc_probe+0x518/0xc54)
> [    2.041899] [<c0407df4>] (omap_hsmmc_probe+0x518/0xc54) from [<c032f508>] (platform_drv_probe+0x18/0x1c)
> [    2.051905] [<c032f508>] (platform_drv_probe+0x18/0x1c) from [<c032e2c4>] (driver_probe_device+0x78/0x210)
> [    2.062091] [<c032e2c4>] (driver_probe_device+0x78/0x210) from [<c032e4f0>] (__driver_attach+0x94/0x98)
> [    2.072017] [<c032e4f0>] (__driver_attach+0x94/0x98) from [<c032cbc4>] (bus_for_each_dev+0x50/0x7c)
> [    2.081570] [<c032cbc4>] (bus_for_each_dev+0x50/0x7c) from [<c032daf0>] (bus_add_driver+0x178/0x240)
> [    2.091211] [<c032daf0>] (bus_add_driver+0x178/0x240) from [<c032e9c0>] (driver_register+0x78/0x144)
> [    2.100851] [<c032e9c0>] (driver_register+0x78/0x144) from [<c0008834>] (do_one_initcall+0x34/0x178)
> [    2.110507] [<c0008834>] (do_one_initcall+0x34/0x178) from [<c0709900>] (kernel_init_freeable+0x100/0x1d0)
> [    2.120708] [<c0709900>] (kernel_init_freeable+0x100/0x1d0) from [<c04e19f0>] (kernel_init+0x8/0xe4)
> [    2.130356] [<c04e19f0>] (kernel_init+0x8/0xe4) from [<c0013480>] (ret_from_fork+0x18/0x38)
> [    2.139299] omap_hsmmc mmc.4: unable to obtain RX DMA engine channel 25
> [    2.146514] of_get_named_gpio_flags: can't parse gpios property
> [    2.152815] of_get_named_gpio_flags: can't parse gpios property
> [    2.159268] omap-dma-engine omap-dma-engine: allocating channel for 3
> [    2.166124] omap_hsmmc mmc.5: unable to obtain RX DMA engine channel 3
> 
> Would anyone know what might be wrong?  Is there a commit that I should avoid for the moment?


Don't you still have the error if you disable CONFIG_XENOMAI and
CONFIG_IPIPE?


-- 
                                                                Gilles.


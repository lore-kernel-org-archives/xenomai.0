Message-ID: <5074339F.8050601@xenomai.org>
Date: Tue, 09 Oct 2012 16:24:31 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <50729DAB.2080909@gmail.com> <50730FB7.3060604@xenomai.org>
	<5073C8C8.7000606@gmail.com>
In-Reply-To: <5073C8C8.7000606@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Oops while running "cat /proc/xenomai/stat"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stefan Roese <stefan.roese@gmail.com>
Cc: xenomai@xenomai.org

On 10/09/2012 08:48 AM, Stefan Roese wrote:

> [   65.601569] [c716bba0] [c009adf0] rtdm_event_signal+0x50/0xe4
> [   65.607440] [c716bbc0] [cb132588] fpga_dma_done_callback+0x18/0x28 [rt_fpga]
> [   65.614641] [c716bbd0] [cb101114] mpc52xx_lpbfifo_bcom_irq+0x114/0x1c4 [rt_mpc52xx_lpbfifo]

Is any list corruption detected when CONFIG_XENO_OPT_DEBUG_QUEUES is
enabled?

-- 
Philippe.


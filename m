Message-ID: <50744677.2090103@gmail.com>
Date: Tue, 09 Oct 2012 17:44:55 +0200
From: Stefan Roese <stefan.roese@gmail.com>
MIME-Version: 1.0
References: <50729DAB.2080909@gmail.com> <50730FB7.3060604@xenomai.org>
	<5073C8C8.7000606@gmail.com> <5074339F.8050601@xenomai.org>
In-Reply-To: <5074339F.8050601@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 10/09/2012 04:24 PM, Philippe Gerum wrote:
> On 10/09/2012 08:48 AM, Stefan Roese wrote:
> 
>> [   65.601569] [c716bba0] [c009adf0] rtdm_event_signal+0x50/0xe4
>> [   65.607440] [c716bbc0] [cb132588] fpga_dma_done_callback+0x18/0x28 [rt_fpga]
>> [   65.614641] [c716bbd0] [cb101114] mpc52xx_lpbfifo_bcom_irq+0x114/0x1c4 [rt_mpc52xx_lpbfifo]
> 
> Is any list corruption detected when CONFIG_XENO_OPT_DEBUG_QUEUES is
> enabled?

No, I don't see any list corruptions with CONFIG_XENO_OPT_DEBUG_QUEUES
enabled. But the crash log is different now. At least part of the
"stat" is printed. And the crash happens now in xnintr_irq_handler().
This different crash seems to result from a change of the kernel
config (I enabled/disabled some other drivers as well in the meantime).
I'm debugging now, how different kernel configurations result in different
crash scenarios.

Thanks for your help so far.

Cheers,
Stefan




MIME-Version: 1.0
Date: Thu, 26 May 2016 18:57:49 +0300
Message-ID: <CAJ2oMhL-7pF+3ZCHy_yA1OiFo-O327PGwL=Sy8g9-h8JZ0YNDw@mail.gmail.com>
From: Ran Shalit <ranshalit@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] "watchdog triggered" error & irq interrupt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

On testing interrupt within kernel it seems to work ok.
I then moved to userspace rt thread waiting on events coming from the
rtfm kernel driver (witch signals with rtd_event_signal)

But then I get the following errors:

dma0chan1-copy0: #15195: got completion callback, but status is 'in progress'
dma0chan3-copy0: #14335: test timed out
dma0chan3-copy0: #14336: got completion callback, but status is 'in progress'
Xenomai: watchdog triggered -- signaling runaway thread 'rtdm'
[sched_delayed] sched: RT throttling activated
Xenomai: RTDM: closing file descriptor 0.
CPU time limit exceeded

I understand that it mean that cpu is probably in busy wait.
The interrupt is done on raising edge, and I configure it as following:
rtdm driver:
========
ret = rtdm_irq_request(&ctx->irq_handle,
 91, PFI_IRQHandler, RTDM_IRQTYPE_EDGE,
 DRVNAM, ctx);

userspace real-time thread
===============

while (1) {
    rt_printf("11\n");
    if (ioctl(file_desc, RTTST_RTIOC_GPIOIRQ_WAIT_IRQ))
    {
           rt_printf("failed!");
     };
     rt_printf("22\n");
      mymmap[0xe4] = 1;  //mymmap is memory mapped io to 0x80010000
      writel(1, rtdm_fpga_base_addr + 0xe4);
      g_value[g_index] = readl( rtdm_fpga_base_addr+ 0x8010);
     pCnt = &(ledRegister[0x8010]);
      mymmap[0xe4] = 0;

   }

I've been debugging it for some hours in vain. I have no idea, any
suggestion will help.

complete sources (driver & app)
https://drive.google.com/folderview?id=0B22GsWueReZTS3RaV3gzRk9aZzQ&usp=sharing

Regards,
Ran


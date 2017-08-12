MIME-Version: 1.0
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Sat, 12 Aug 2017 15:34:40 +0100
Message-ID: <CAKJ14NdVkRWbRGg-HKXA3TyFqhLjgHssxRjApkJ_HjU2peGC+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Pagefault during RTnet tx on i.MX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

>
> HW/SW:
> - phyflex i.MX6 dual core SOM
> - Linux version 3.0.43-tpcom_run2-PD13.2.4
> - Xenomai/Ipipe: 2.6.4/1.18-3
> - RTnet: 0.9.13
> - custom RTnet driver
>
> Problem:
> Recently, we came across a case where the rx/tx through RTnet works
> for several hours and then stops with the following errors:
> [ 5198.831630] Xenomai: suspending kernel thread 7f022808
> ('rtnet-stack') at 0x7f01d36c after exception #0x0
> [ 5263.234100] INFO: rcu_preempt_state detected stalls on CPUs/tasks:
> { 1} (detected by 0, t=6002 jiffies)
> [ 5443.554099] INFO: rcu_preempt_state detected stalls on CPUs/tasks:
> { 1} (detected by 0, t=24034 jiffies)
>
> Further investigation produced the ipipe trace shown at the bottom of
> this Email.
>

In the end it turned out that VirtualBox (v5 i believe) was the
culprit. We compiled the kernel both natively and inside VirtualBox in
exactly the same environment and found that only the kernel compiled
in VirtualBox caused the page faults.... Now we're using VMWare
instead.

A.


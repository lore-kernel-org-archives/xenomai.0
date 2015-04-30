MIME-Version: 1.0
Date: Thu, 30 Apr 2015 08:53:10 -0700
Message-ID: <CAKC9m6fXKqNhwy3sZ9zqzoAu=Xb7TUSxceogpE7xxB9-J=11wQ@mail.gmail.com>
From: Hongfei Cheng <hongfei@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Ipipe-core patched kernel fails to start when certain
 platform drivers are enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

We've been working on porting the I-pipe core to an ARMv8/AArch64
platform (Qualcomm msm8994).

Taking the advice we received from this forum, our approach has been
to add and enable the I-pipe core patches on this new architecture one
(small) step at a time.

The development platform is currently configured and patched as follows:
1). Only 1 CPU core is enabled (via kernel command line).
2). Interrupt controller, GPIO controller, and platform drivers are
patched following the porting guide and the existing ipipe-core code,
along with the relevant discussions on this list.
3). I-pipe spinlocks are applied to the instances where we think
require "ipipe protection", although we are still uncertain if this
work is complete in our code.
4). High resolution counter is not yet supported as we're exploring
different way(s) to implement TSC.
5). CPU_FREQ and CPU_IDLE are *not yet* disabled, mainly due to the
dependency of big.LITTLE architecture vendor-specific code.

Below is what we've observed so far:
1). Hardware timer appears to be running properly with
arch_timer_ack() being called regularly and reliably.
2). I-pipe is indeed grabbing the interrupt (through examining the call stack).
3). The kernel startup process comes to a screeching halt when probing
certain platform drivers, such as ipa or pcie. No kernel oops is
shown. In this kernel state, the *only* task being scheduled is the
watchdog process.

I believe there are "holes", to borrow the term from Gilles, in the
platform drivers. However the few platform drivers which call
generic_handle_irq have all been replaced with
ipipe_handle_demuxed_irq.

My questions are:
1). Has anyone encountered similar experience while porting I-pipe core?
2). Could such behavior be the result of missing or incorrectly
applied I-pipe spinlocks?

I'll put the kernel config, patched code, and startup logs in the
cloud and post the link here.

Thanks!
Hongfei

P.S. Apologies for my top-postings in the past few weeks which I just
noticed (in Gmail client).


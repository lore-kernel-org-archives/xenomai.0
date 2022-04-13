From: Scott Reed <scott.reed@arcor.de>
Subject: Does Xenomai 3.2.x work with 4.14.x kernels?
Message-ID: <3e06adcf-fa06-b69c-d91e-972f283d9b08@arcor.de>
Date: Wed, 13 Apr 2022 11:25:10 +0200
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
To: xenomai@xenomai.org

Hello,

I am trying to build a 4.14.110 kernel+ipipe+xenomai_3.2.7 and running into
issues when trying to compile. Namely, the 4.14.x kernel does not seem
to understand the "__kernel_timespec" struct.

Is it known if Xenomai 3.2.x works with 4.14.x kernels?

Some background information
---------------------------
Our platform is based on an ARM iMx6q.

I have tried to move to a 5.4.x kernel, but ran into another issue
in that we have an RTDM driver which uses PCI MSI interrupts and
when I try to register the interrupt with rtdm_irq_request the
function returns EINVAL(-22).

When working with a vanilla 5.4.x kernel and non-RTDM version of
the driver, there are no issues when registering the interrupt.

I started to dive into this problem, but saw that as of kernel
4.16, the PCI MSI interrupts for our platform have been changed
to be handled as chained interrupts.

In this forum, I have seen multiple discussions and patches regarding
chained interrupts for X86, but not for ARM and began to think that
maybe chained interrupt support in xenomai is not complete for ARM.

Could this be the case?

For this reason, I backed down to the 4.14.x kernel, but now have run
into the compiling issue as mentioned at the start of this email.

One last piece of background information, my initial motivation to move
to a new xenomai was that we moved to GCC 10.2 (in the meantime GCC 11.1)
and I was concerned regarding the ARM r7 register clobbering issues/patches
posted to the forum as I am fighting against a bug in our system where 
registers get corrupted albeit not r7 (typically r0 with a value of 
0xFFFFFFFA (-38)). This problem seems to have come in after we upgraded
to GCC 10.2

Thanks for any help,

Scott


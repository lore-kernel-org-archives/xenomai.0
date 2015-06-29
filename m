From: "Giorgio Buffa" <giorgiobuffa.work@gmail.com>
Date: Mon, 29 Jun 2015 15:35:03 +0200
Message-ID: <000a01d0b270$6c0e6b70$442b4250$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: it
Subject: [Xenomai] Device drivers and networking stack (RTnet) on Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello list!
I'm new to the Xenomai architecture, so I would like to receive a feedback
regarding my (little) understanding on device drivers and the RTnet stack.

In dual-kernel configurations (both Xenomai 2.x and Xenomai 3.x Cobalt
core), device drivers need to be ported to the RTDM model: it allows a
Xenomai thread not to leave the primary mode when accessing these device
drivers. This is good because a Xenomai thread in secondary mode is
scheduled by the Linux scheduler, hence it can run only when there are no
other runnable Xenomay thread in primary mode (even with a lower priority),
nor other runnable Linux threads / Xenomai threads in secondary mode with
higher priority.

Porting a Linux driver to the RTDM model basically means to replace any
call to Linux services within the driver itself (e.g. to register the
driver, the IRQ handlers, the open/close/ioctl handlers, ...) to the
equivalent services provided by the RTDM API.

In single-kernel configurations (Xenomai 3.x Mercury core) there is only
the Linux scheduler, hence there is no such distinction of
primary/secondary mode. A device driver can be used as is (i.e. as it is
provided by the stock Linux kernel), even without porting it to the RTDM
model. By the way, it is also possible to use a RTDM-based device driver
(in that case, RTDM API calls are translated into Linux service calls at
compile time).

Are there some good "rules of thumb" when looking at a stock Linux driver
to be used in a Xenomai application with the Mercury core underneath?

My last point is related to RTnet. I've seen that RTnet has been integrated
into Xenomai 3 because some sort of API changes. Is RTnet needed in both
dual-kernel and single-kernel configurations?

Thank you for any help and kind regards,
Giorgio Buffa



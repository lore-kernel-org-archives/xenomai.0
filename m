References: <3d2f5bbd-598c-19f2-6451-a72d5da47b8a@abaxor.de>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: EVL Interrupt
Date: Mon, 16 May 2022 17:09:32 +0200
In-reply-to: <3d2f5bbd-598c-19f2-6451-a72d5da47b8a@abaxor.de>
Message-ID: <87tu9ph5cp.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Blaesing <sebastian.blaesing@abaxor.de>
Cc: xenomai@xenomai.org


Sebastian Blaesing via Xenomai <xenomai@xenomai.org> writes:

> Hi all,
>
> what is the best and fastest way to pass critical hardware Irq signal
> to control a semaphore in user space application?
>
> Is it possible that kernel and user space share a semaphore?
>

You do this indirectly: in the kernel driver which implements the IRQ
handler, you create an EVL sema4, and an oob_ioctl() or oob_read()
handler which waits on it. The IRQ handler posts the sema4 which the
user-space application pends on via a call to oob_{ioctl|read}().

The driver which talks to the 'latmus' application implements the same
pattern, using an EVL flag instead of a sema4, but the logic is
otherwise the same. Some handler triggered by some event (here a timer,
yours would be triggered by an IRQ) raises a flag [1], which is awaited
by a function [2] which is called by the application via the oob_ioctl()
syscall [3].

HTH,

[1] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/blob/v5.15.y-evl-rebase/drivers/evl/latmus.c#L561
[2] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/blob/v5.15.y-evl-rebase/drivers/evl/latmus.c#L627
[3]
https://source.denx.de/Xenomai/xenomai4/linux-evl/-/blob/v5.15.y-evl-rebase/drivers/evl/latmus.c#L1130

--
Philippe.


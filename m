References: <PH1P110MB1050EB01901ACB993D94FF8EE2AF9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Interrupts
Date: Sat, 18 Jun 2022 10:44:57 +0200
In-reply-to: <PH1P110MB1050EB01901ACB993D94FF8EE2AF9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87pmj673g0.fsf@xenomai.org>
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
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: xenomai@xenomai.org


Russell Johnson via Xenomai <xenomai@xenomai.org> writes:

> The app that I am currently working with has an interrupt scheme as follows:
> device on the PCIe bus sends an interrupt to the CPU, our linux driver then
> has an MSI interrupt handler (will be replaced by the EVL oob interrupt
> handler), the handler then calls eventfd_signal() to alert the userspace app
> that an interrupt happened. On the userspace side, there is a thread that
> implements an epoll that is monitoring the eventfd for an event. The issue
> is that eventfd and epoll are both Linux OS items, so I am not sure if
> sticking with this kind of method is the best option. Is there a more
> generally excepted method when developing with EVL to have an EVL kernel
> driver notify a userspace EVL thread that there was an interrupt?
>

The recommended way with EVL is to follow the common patterns used for
developing regular linux drivers, except that the EVL kernel API must be
used instead of the regular/in-band kernel API for anything which wants
to synchronize threads over the oob stage.

Typically, you could share an EVL semaphore [1] or an event flag group
[2] between the interrupt handler and the oob_ioctl() or oob_read()
call, which would block the user-space task until the matching event
happens. To monitor complex events, you could use an EVL wait queue
instead of a semaphore or a flag.

If you need to monitor multiple event sources in userland, you can use
the EVL poll API [4] with the file descriptors you would otherwise pass
to the oob_{ioctl, read, write}() calls.

[1] https://evlproject.org/core/user-api/semaphore/
[2] https://evlproject.org/core/user-api/flags/
[3] https://evlproject.org/core/kernel-api/wait/
[4] https://evlproject.org/core/user-api/poll/

-- 
Philippe.


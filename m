References: <MN2PR12MB37578739EBA7AF56D003253FF22D0@MN2PR12MB3757.namprd12.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Assigning Interrupt Handlers
In-reply-to: <MN2PR12MB37578739EBA7AF56D003253FF22D0@MN2PR12MB3757.namprd12.prod.outlook.com>
Date: Sun, 06 Sep 2020 12:36:51 +0200
Message-ID: <87o8mjb398.fsf@xenomai.org>
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
To: "Frey, Fred (ext ???)" <f.frey@qvii.com>
Cc: xenomai@xenomai.org


Frey, Fred (ext ???) via Xenomai <xenomai@xenomai.org> writes:

> Hello all,
>
> I'd like some guidance on the topic of setting up interrupt handlers to work with Xenomai.
>
> Platform: Debian Buster on AM335x Arm (Beaglebone Black)
> Xenomai version: 3.0.10
> `uname -r` : 4.14.108-ti-xenomai-r135
>
> Specifically, I'd like to set up a function to run every time the PRU generates an interrupt that I've defined.
> I'm a little confused on what functionality is actually provided
> here. Reading the docs I easily can find the 'rtdm_irq_request()'
> function which looks like exactly what I need.

This is indeed what you need to register an in-kernel handler for the
IRQ, called from a (mini-)driver.

> However, when looking through the header files I have, I can't find any mention of this function. Looking through some old mailing list posts, I gathered that this function was
> actually only callable from the kernel context. So I guess my question is three-fold:
>
>
>   1.  Is it possible for me to register an interrupt handler from
>   userspace?

No, there is no direct support for this, on purpose.

>   2.  If not, is the prescribed method of doing this to write a device
>   driver?

Yes.

>   3.  If I have to write a device driver for the PRU, would my  interrupt handler have to live inside of my device driver, or would I be able to register
>
> a function inside of my client program to be an interrupt handler?
>

The interrupt handler would definitely have to live in your device
driver. That driver could be very simple implementation-wise: it would
register a handler for the interrupt, sending wake up events upon IRQ
receipt to any task blocked on a synchronization event shared between
the handler and those tasks, e.g. a semaphore or an event flag depending
on the semantics you need.

So, in kernel space you could have a so-called "named" device driver
implementing the IRQ handler, which would also define some IOCIRQWAIT
ioctl request which the app in user-space could invoke to wait for the
next event (from primary mode):

driver_init_routine():
        rtdm_event_init(&event, 0);
        rtdm_irq_request(..., irq, irq_handler, ...);

driver_irq_handler():
        rtdm_event_signal(&event);

driver_ioctl_rt(..., cmd=IOCIRQWAIT, ...):
        rtdm_event_wait(&event);

A driver for a named device in Xenomai's lingo exports a character-based
interface to certain device(s), with the device nodes appearing in the
/dev/rtdm hierarchy. In user-space, the app would have to open() the
device node in /dev/rtdm exposed by the mini-driver, then issue
ioctl(fd, IOCIRQWAIT) requests in order to synchronize on IRQ receipt:

in_application_handler()
{
        int fd, ret;

        fd = open("/dev/rtdm/some_device", O_RDONLY);
       
        for (;;) {
            ret = ioctl(fd, IOCIRQWAIT);
            if (ret)
                    error(1, errno, "oops");
            ... process next IRQ event ...
        }
}

(the libcobalt implementation of open() and ioctl() would have to be
called by the application, not glibc's).

The illustration above is obviously very sketchy, but the basics are
presented.

There is also the option of using the UDD driver, which is Xenomai's
version of UIO, offering a generic interface for mapping device memory
and synchronizing on IRQ events to applications. UDD hosts mini-drivers
users provide on top, hiding the nitty-gritty details of device
creation, memory mapping and more. It provides a unified interface to
applications for accessing the features.

The UDD documentation is terse, but you may want to refer to this post
to get started with UDD:
https://xenomai.org/pipermail/xenomai/2017-February/037121.html

-- 
Philippe.


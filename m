MIME-Version: 1.0
Date: Mon, 1 Oct 2012 17:51:46 +0200
Message-ID: <CAOiXNkBzov-hrEOECeqPNgMw-peUmMcx55N8CcL3Ue66H-xwMA@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Qeustion about rtdm_event_timedwait
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am writing rtdm driver where I have irq handler which should unblock
driver's read() function when certain condition is met. Roughly, it is
a wheel encoder driver where irq handler decrements the counter and
should wake up the reader when the counter is 0.

To implement this type of synchronization between irq handler and
reader, I am using events. In particular, the driver's read function
gets blocked with rtdm_event_wait (_timedwait has the same behavior)
and irq handler calls rtdm_event_signal when necessary. At the
"client" side, there is just a normal C program calling
rt_dev_open/rt_dev_write/rt_dev_read from the main function to test
the driver.

The following fragment illustrates the base idea.

Driver:

rtdm_read(..)
{
  while(! condition_is_met)
    rtdm_event_wait(...);

  rtdm_safe_copy_to_user(...)
}

IRQ handler:

handler(...)
{
  if(some_condition)
    rtdm_event_signal(...)

  return handled;
}

What I am observing is that rtdm_event_wait() does *not* actually
waits but instead returns immediately. To make sure that this is the
case, I've changed the dirver function as following:

rtdm_read(..)
{
  while(! condition_is_met)
  {
    rtdm_printk("waiting\n");
    rtdm_event_wait(...);
    rtdm_task_sleep(100ms); // to keep the system responsive
  }

  rtdm_safe_copy_to_user(...)
}

This outputs a bunch of "waiting" strings until the condition is met
and while loop exits. It happens even if wheels are not rotating at
all, i.e. for sure no event_signal() is called.

So this is definitely not what I was expecting but I do not see any
mistakes in the logic presented above. I would highly appreciate if
someone experienced in this area can provide some suggestions.

Also I have to mention, that driver's read() function is registered as
*read_nrt* and .device_class = RTDM_CLASS_EXPERIMENTAL. While studying
the rt_serial driver which uses similar way to communicate between isr
and read/write functions, I realize that over there read/write
functions are registered as *read/write_rt*. My naive attempt just to
register my functions as _rt lead to the situation where they are not
invoked at all. As I understand, because my test "client" is not a
real-time process. So does it imply that to make
event_wait/event_signal to work, the "client" must also run Xenomai RT
task?

In fact, in the documentation for rtdm_event_wait(), the following is mentioned:
This service can be called from:
 * Kernel-based task
 * User-space task (RT)

I thought, that since I am in driver's read() function, the first
statement "Kernel-based task" is what I am doing and it should be OK.
Did I misunderstand this statement and actually need to run RT task in
the client too?

So it would be very helpful for me if someone please can comment on it.


Regards,
Andrey.


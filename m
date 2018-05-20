MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Sun, 20 May 2018 00:43:05 -0700
Message-ID: <CA+K1mPH6SPht4gtnO4iU9NT814H8GUKUi7OVerF=jcaL-imMJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Only 2 serial ports at a time with xeno_16550A driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

An update:
In the modprobe, I tried putting first the two ports which share IRQ 5:
modprobe xeno_16550A io=0x02f8,0x2e8,0x3f8 irq=5,5,4
results:
"successfully initialized serial device rtser1 (fd=12)
Problem setting up serial port 0 on rtser0, got: -16
successfully initialized serial device rtser2 (fd=13)"

So rt_dev_open() returns -EBUSY on the first port which shared IRQ 5

Then I tried initializing only the two ports which share IRQ 5:
modprobe xeno_16550A io=0x02f8,0x2e8 irq=5,5
results:
"successfully initialized serial device rtser1 (fd=12)
Problem setting up serial port 0 on rtser0, got: -16"

So rt_dev_open() returns -EBUSY on the first port which shared IRQ 5

I reversed the order of the two ports which share IRQ 5:
 modprobe xeno_16550A io=0x02e8,0x2f8 irq=5,5
results:
"successfully initialized serial device rtser1 (fd=12)
Problem setting up serial port 0 on rtser0, got: -16"

So again rt_dev_open() returns -EBUSY on the first port which shared IRQ 5,
even though it is a different port address now.

I recompiled the xeno_16550A driver with some printk()s in function
rt_16550_init_io() of 16550A_io.h. That function has the potential to
return -EBUSY if request_region() or mapped_io[] indicate failure, but
nothing printed to dmesg when rt_dev_open() failed.

How else can I analyze why rt_dev_open() thinks a port is unavailable?

thanks,
-C Smith

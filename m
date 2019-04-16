Subject: Re: rt_dev_send() stalls periodic task
References: <CA+K1mPFgaiP3fGFnd169MXhdRWo+a1TGz5fnEoj7MOCr11UbLQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c6a9ba79-c7c5-195d-be1e-030fb44f5abc@siemens.com>
Date: Tue, 16 Apr 2019 10:03:50 +0200
MIME-Version: 1.0
In-Reply-To: <CA+K1mPFgaiP3fGFnd169MXhdRWo+a1TGz5fnEoj7MOCr11UbLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: C Smith <csmithquestions@gmail.com>, Sumitabh Ghosh via Xenomai <xenomai@xenomai.org>

On 15.04.19 19:28, C Smith via Xenomai wrote:
> My Xenomai periodic routine normally runs for days at a time on most
> motherboards, but it is spontaneously getting stuck forever in
> rt_dev_write(). This is a write to a xeno_16550A driver serial port.
> 
> I must use this brand of motherboard, where the first serial port (rtser0
> 0x3f8 irq 4) does not have a problem, but the other two serial ports have
> the stalling problem (rtser1 0x2f8 irq 5, rtser2 0x2e8 irq 3). Three
> motherboards of this brand have been tried with the same results. There are
> no shared interrupts in this scenario.
> 
> The serial device is set up this way:
> 
> struct rtser_config serial_config = {
>          .config_mask       = 0xFFFF,
>          .baud_rate         = 115200,
>          .parity            = RTSER_NO_PARITY,
>          .data_bits         = RTSER_8_BITS,
>          .stop_bits         = RTSER_1_STOPB,
>          .handshake         = RTSER_NO_HAND,
>          .fifo_depth        = RTSER_DEF_FIFO_DEPTH, //RTSER_FIFO_DEPTH_8,
>      .reserved          = 0,
>          .rx_timeout        = 500000,
>          .tx_timeout        = RTSER_DEF_TIMEOUT,
>          .event_timeout     = 5000000,
>          .timestamp_history = RTSER_RX_TIMESTAMP_HISTORY,
>          .event_mask        = RTSER_EVENT_RXPEND,
> };
> fd_tty[0] = rt_dev_open("rtser1", O_RDWR | O_NONBLOCK);
> sret = rt_dev_ioctl(fd_tty[0], RTSER_RTIOC_SET_CONFIG, &serial_config);
> 
> The application transmits a packet of about 75 bytes repeatedly from a
> xenomai periodic task that wakes up at 125Hz repeatedly. Note that there is
> also a small RX serial packet arriving so there is some full-duplex
> overlap.  On rtser0 this works fine, on the other serial ports the stall
> happens after a few hours and my periodic xenomai task stops. There is no
> xenomai watchdog message in dmesg. The code is repeatedly checking the
> serial port status ioctl and there are no errors like framing errors etc.
> 
> The periodic task is just a typical xenomai while() loop:
>    next += period_ns + adjust_ns;
>      rt_task_sleep_until(next);
> 
> When my periodic task stops the kernel says the stack trace is:
> [root@oyx ~]# cd /proc/1066/task/1075/
> [root@oyx 1075]# cat stack
> [<c112d058>] xnpod_suspend_thread+0x3d8/0x650
> [<c1132f09>] xnsynch_sleep_on+0x139/0x320
> [<c11a7f14>] rtdm_event_timedwait+0x2e4/0x390
> [<e858ed3b>] rt_16550_write+0x35b/0x540 [xeno_16550A]

This means the driver is stuck while writing because there are no more free 
entries in the hardware TX FIFO. Do you have hardware flow control enabled? Are 
you sure the that the receiving side is playing nicely?

Jan

> [<c11a1e23>] __rt_dev_write+0x63/0x110
> [<c11a9374>] sys_rtdm_write+0x24/0x30
> [<c113c2dc>] hisyscall_event+0x1ec/0x380
> [<c10eb31a>] ipipe_syscall_hook+0x3a/0x50
> [<c10ea220>] __ipipe_notify_syscall+0xb0/0x160
> [<c16a73bb>] pipeline_syscall+0x7/0x18
> [<ffffffff>] 0xffffffff
> 
> I can attach with a debugger, and when I do I think the debugger gets us
> out of the stall, so can actually single step the code for a little while.
> I can't see any suspicious variable values, only that the serial port
> transmitted 40 of my 75 bytes, which is unusual. But I can only single step
> until my task sleeps one more time. At the next wakeup if I step into the
> rt_dev_write() the task stalls forever and I can no longer debug.
> 
> (gdb) thread 2
> [Switching to thread 2 (Thread 0xb7797b40 (LWP 1336))]
> #0  0xb77caa92 in _dl_sysinfo_int80 () from /lib/ld-linux.so.2
> (gdb) where
> #0  0xb77caa92 in _dl_sysinfo_int80 () from /lib/ld-linux.so.2
> #1  0xb775d872 in rt_dev_write (fd=12, buf=0xa8eda001, nbyte=72) at
> core.c:72
> #2  0x08056515 in Process_serial (comm_p=0x810e644 <comm_object+4>,
> portnum=1 '\001') at periodic_app.cpp:5404
> #3  0x0804e0e4 in Periodic_routine (cookie=0x0) at periodic_app.cpp:1654
> #4  0xb7764acd in rt_task_trampoline (cookie=0x0) at task.c:113
> #5  0xb777a313 in start_thread () from /lib/libpthread.so.0
> #6  0xb7528f2e in clone () from /lib/libc.so.6
> 
> I'm using an Intel I5 CPU, 32 bit kernel 3.18.20, Xenomai 2.6.5. I must be
> on this Xenomai/kernel version to support tens of thousands of lines of
> legacy code. I diffed the driver sources and the rtl_16550 driver did not
> functionally change between Xenomai 2.6.5 and Xenomai 3.0.8.
> 
> I looked at the rt_dev_write() source code, but I don't see an obvious
> infinite loop (though the assembly code is a bit beyond my understanding).
> I'd like to detect the problem early and continue without stalling.
> It seems the physical serial ports are misbehaving, sure. But what would
> make rt_dev_write() stall forever?
> 
> thanks,
> C Smith
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


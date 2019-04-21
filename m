Subject: Re: rt_dev_send() stalls periodic task
References: <CA+K1mPFgaiP3fGFnd169MXhdRWo+a1TGz5fnEoj7MOCr11UbLQ@mail.gmail.com>
 <c6a9ba79-c7c5-195d-be1e-030fb44f5abc@siemens.com>
 <CA+K1mPEvKLN+gyDPwLE0OovtSn-iQ_BBZ86zQf12Fv65Ht5KbQ@mail.gmail.com>
 <2ade719a-84c7-c53d-9895-a5e6eea354a3@siemens.com>
 <CA+K1mPHhMrw-2t0k1_AgKE4iZ+2+Vvx7TV_ScHnOFis_sBxt=Q@mail.gmail.com>
From: Steve Freyder <steve@freyder.net>
Message-ID: <5CBCCE3F.5090000@freyder.net>
Date: Sun, 21 Apr 2019 15:10:39 -0500
MIME-Version: 1.0
In-Reply-To: <CA+K1mPHhMrw-2t0k1_AgKE4iZ+2+Vvx7TV_ScHnOFis_sBxt=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, C Smith <csmithquestions@gmail.com>

On 4/20/2019 11:33 PM, C Smith via Xenomai wrote:
> Per your suggestion, I added code to call this ioctl, right after the
> rt_dev_write() :
>     rt_dev_ioctl(fd_tty[1], RTSER_RTIOC_GET_STATUS, &serial_status);
> I let the transmit stall again, then attached with a gdb, which allows me
> to step forward to the ioctl:
>     serial_status.line_status was 96 decimal, or  0110 0000 binary
> which means both transmit holding and transmit shift registers were empty,
> thus nothing was queued up in the UART for transmission.
> The return value of rt_dev_write() was only 8, after a 72 byte packet was
> submitted to rt_dev_write().
> So your theory that the TX interrupt got lost seems correct.
>
> First, why does rt_dev_write() wait until all bytes are transmitted ?
> Shouldn't it be effectively "non blocking" ?
>
> Second, how might l generate another UART TX interrupt to keep the
> transmission going?
> Can we modify the serial driver at a low level to check the LSR vs the
> bytes in the buffer, and force transmission until the buffer is empty?
>
> thanks,
> -C Smith
>
[ pls excuse the intrusion on your thread, I experienced this same
   problem years ago, 16550A hardware, bare metal,, perhaps I could
   add a couple of thoughts ]

I would point out that Phillipe made some changes to the 3.0.x iMX
UART driver circa 2019/04/01, in what sounds like the same functional
area.  Granted that's different hardware, but it appears to be a
descendant of this driver, so if those changes were good for the iMX
driver, maybe they're good for this one too.

I got curious about "tx_timeout", and why it doesn't help in this
situation, so I looked at the code.  The driver rightly assumes that
the hardware is going to produce a TX interrupt when the FIFO trigger
level is reached.  The TX interrupt handler will pull more bytes from
the (4K) software transmit buffer to fill the TX FIFO, set the
IER.THRE interrupt enable, and return.    If the TX interrupt doesn't
fire, that process of emptying the software FIFO into the hardware TX
FIFO stops, and there's no timeout-based provision for restoring the
flow of output, so it's only a matter of time before the software FIFO
overflows, and at that point your writes start to stall.

I might argue that since you are in nonblocking mode, the driver
write routine should be doing this check before attempting to put
anything in the software buffer:

     if (userwritelen > freebytesinsoftwarebuffer)  {
         return(-EWOULDBLOCK) ;
     }

With obvious issues for user buffers larger than 4K in NB mode.

That'd keep your task from hanging, but the output is still going to
stop shortly after losing a THRE interrupt.

BTW, if you truly *are* losing an interrupt, the IER.THRE bit should
be equal to 1 when you look at it in the debugger.  If the IER.THRE
bit is 0, then it means that the driver made the mistake, OR perhaps
that there's a timing problem where the CPU *tried* to set IER.THRE
but the chip wasn't ready and never heard the request.        As I
remember it there's a software copy of the last requested output
state of the IER kept in the per-port context structure, so you could
look there to see what the driver last attempted to write to the IER.

I remember you mentioned that you have three such UARTs in your
system, and that one (COM1?) is not having this problem, but the
other two *are*.  I think I would be interested in how the hardware
related to COM1 differs from that of the others.  Are they all on the
motherboard?  Maybe the IRQ assignments are what make the
difference.

Finally, you could run a test where you let the port be handled by
Linux, and exercise it with:

     strace dd if=/dev/zero bs=75 of=/dev/ttyXX

to see if you have the same problem with output stopping (eg, dropping
a THRE interrupt).  Keep an eye on your dmesg output while you're
running the test, Linux might have code to detect a dropped transmit
interrupt based on a timer, and if that happens, it should be logged
via printk() and show up in dmesg.

HTH

Regards,
Steve


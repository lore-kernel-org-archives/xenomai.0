MIME-Version: 1.0
References: <CA+K1mPFgaiP3fGFnd169MXhdRWo+a1TGz5fnEoj7MOCr11UbLQ@mail.gmail.com>
 <c6a9ba79-c7c5-195d-be1e-030fb44f5abc@siemens.com>
 <CA+K1mPEvKLN+gyDPwLE0OovtSn-iQ_BBZ86zQf12Fv65Ht5KbQ@mail.gmail.com>
 <2ade719a-84c7-c53d-9895-a5e6eea354a3@siemens.com>
In-Reply-To: <2ade719a-84c7-c53d-9895-a5e6eea354a3@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Sat, 20 Apr 2019 21:33:47 -0700
Message-ID: <CA+K1mPHhMrw-2t0k1_AgKE4iZ+2+Vvx7TV_ScHnOFis_sBxt=Q@mail.gmail.com>
Subject: Re: rt_dev_send() stalls periodic task
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Sumitabh Ghosh via Xenomai <xenomai@xenomai.org>

Per your suggestion, I added code to call this ioctl, right after the
rt_dev_write() :
   rt_dev_ioctl(fd_tty[1], RTSER_RTIOC_GET_STATUS, &serial_status);
I let the transmit stall again, then attached with a gdb, which allows me
to step forward to the ioctl:
   serial_status.line_status was 96 decimal, or  0110 0000 binary
which means both transmit holding and transmit shift registers were empty,
thus nothing was queued up in the UART for transmission.
The return value of rt_dev_write() was only 8, after a 72 byte packet was
submitted to rt_dev_write().
So your theory that the TX interrupt got lost seems correct.

First, why does rt_dev_write() wait until all bytes are transmitted ?
Shouldn't it be effectively "non blocking" ?

Second, how might l generate another UART TX interrupt to keep the
transmission going?
Can we modify the serial driver at a low level to check the LSR vs the
bytes in the buffer, and force transmission until the buffer is empty?

thanks,
-C Smith

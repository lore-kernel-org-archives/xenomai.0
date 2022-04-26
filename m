From: Ryan Wilkins <ryan@elevated-networks.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: SDMA read/write pointer location issue
Message-Id: <367CB8E2-7109-4ECA-A864-298568E87AE6@elevated-networks.com>
Date: Tue, 26 Apr 2022 11:52:31 -0400
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

We are running Linux 4.9 under Xenomai 3.0.10 on an i.MX7D rev.5 v71 =
processor.
The SDMA engine is used to transfer data from main memory to and from =
the SAI interface.
The main memory buffer is around 40 kByte in size and the DMA uses it as =
a ring buffer for the data transfer.
In order to know where the DMA is currently reading or writing data =
inside this buffer, an interrupt is generated whenever 576 bytes of data =
have been transferred. The interrupt routine then updates a suitable =
buffer pointer which is used by our software.
The interrupt occurs on average every 250 =C2=B5sec and is handled by a =
regular non-realtime Linux interrupt routine.

This works but there is a problem: The DMA interrupt and consequently =
the buffer pointer update is sometimes delayed for quite some time.  =
Occasionally, there is no interrupt for more than 2 msec, followed by =
nine interrupts in quick succession to make up for the delay.

We have no evidence that interrupts are ever lost. However, the delayed =
update of the buffer pointer causes problems in our software.

One idea we had was to read the current DMA read/write address directly =
from the SDMA hardware, rather than relying on the interrupt. We were =
unsuccessfully looking at the file imx-sdma.c in order to find this =
information.

In summary, we need to know the DMA's read/write address when the =
interrupt is triggered, with no or very little delay.

Any pointers would be greatly appreciated.  Thank you!

Ryan Wilkins



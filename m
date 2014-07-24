From: "Botev, Roumen" <roumen.botev@brooks.com>
Date: Thu, 24 Jul 2014 15:45:06 -0400
Message-ID: <19C66D276CD97349B3ED15358BC387930904DECD38@Mailprodapp3.brooks.com>
References: <19C66D276CD97349B3ED15358BC387930904DECABF@Mailprodapp3.brooks.com>
 <53D0CEE7.6010208@xenomai.org>
In-Reply-To: <53D0CEE7.6010208@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Latency Test Results (xeno-test) on Xilinx Zynq XC702
 Board with Xenomai 2.6.3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Thank you very much for the feedback and the insights!

Indeed, for lower sampling periods I am seeing lower latency and jitter num=
bers -- this ties in with the cache eviction explanation. For what it's wor=
th, here is the summary of the latency test with 100 usec sampling period (=
-p 100) for user / kernel mode tasks and IRQ, with default loading from xen=
o-test (dohell):

User mode task (-t 0):
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|...
---|-----------|-----------|-----------|--------|------|-------------------=
------
RTS|      3.384|      9.699|     30.918|       0|     0|    00:15:04/00:15:=
04
   =20
Kernel mode task (-t 1):
---|-----------|-----------|-----------|--------|------|-------------------=
------
RTS|      3.430|      6.721|     26.238|       0|     0|    00:15:04/00:15:=
04

Timer IRQ (-t 2):
---|-----------|-----------|-----------|--------|------|-------------------=
------
RTS|      1.560|      3.668|     14.137|       0|     0|    00:15:04/00:15:=
04




Best regards,
Roumen

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]=20
Sent: Thursday, July 24, 2014 5:16 AM
To: Botev, Roumen; xenomai@xenomai.org
Subject: Re: [Xenomai] Latency Test Results (xeno-test) on Xilinx Zynq XC70=
2 Board with Xenomai 2.6.3

On 07/21/2014 08:50 PM, Botev, Roumen wrote:
> Hello, All,
>=20
> I am running Xenomai's out of the box battery of tests (xeno-test) on a X=
ilinx Zynq XC702 evaluation board.
>=20
> I am new to Xenomai and I am wondering if these results look good to peop=
le having more experience in running Xenomai on a Cortex-A9 hardware. In pa=
rticular, I had higher expectations of the average and worst case latency n=
umbers - I was expecting < 10 usec worst latency for the highest priority u=
ser mode task. Here is the summary of the latency test (the full output of =
the test is attached to this message):
>=20
> RTT|  00:15:04  (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat=
 worst
> . . . . . . . . . .
> ---|-----------|-----------|-----------|--------|------|-----------------=
--------
> RTS|      3.675|     14.049|     35.913|       0|     0|    00:15:04/00:1=
5:04
>=20

Figures look ok particularly in dual core mode, regarding the scheduling
latency of a userland thread over a 1Khz period. A large part of such
latency is induced by cache effects, including those entailed by
switching memory contexts.

- scheduling latency for kernel threads (latency -t1) should show lower
figures, although these threads should be reserved to running
driver/RTDM tasks (i.e. not application level stuff)

- the lower the sampling frequency, the higher the latency, as the
regular linux system has more time to tread on a larger address space,
which in turn makes the real-time code a more frequent victim of cache
eviction. Running with -p 100 should get you different results (although
this may not apply to your use case anyway, just for kicks).

--=20
Philippe.



_____________________________________________________________________
This email message, including any attachments, may contain confidential and
proprietary information for the sole use of the intended recipient.  If you=
 are
not the intended recipient, you are hereby notified that any use, copying or
dissemination of this message is strictly prohibited.  If you received this
message in error, please notify Brooks Automation, Inc. immediately by reply
email or by calling Brooks US Headquarters at +1 978-262-2400. Then delete =
this
message from your system, without making any copy or distribution.  Thank y=
ou.


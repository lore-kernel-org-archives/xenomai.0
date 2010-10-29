MIME-Version: 1.0
Date: Fri, 29 Oct 2010 13:34:11 -0500
Message-ID: <AANLkTinQotwe=EwATsmdKnanN-ZwT8c+CobzBRDqptEj@domain.hid>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=00163645735e6351ca0493c5b432
Subject: [Xenomai-help] High resolution timers disabled on AT91SAM9G20 board
	after patching
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--00163645735e6351ca0493c5b432
Content-Type: text/plain; charset=ISO-8859-1

Hi!

I installed the latest xenomai patch on a AT91SAM9G20 board and everything
looked good at a first glance: no compilation problems, low latencies.

However, when I typed cat /proc/timer_list , the resolutions in  cpu0 and
cpu1 items showed 100000 (ns).
(I compiled the Xenomai patched kernel with High Resolution Timers enabled.)

I don't have this problem when I boot a real time kernel (RT_PREEMPT).

One more thing. I also have a Beagleboard that runs a Xenomai patched kernel
and in this case the resolution for HRT shows 1 ns, as it should.

Thanks,
Razvan

--00163645735e6351ca0493c5b432
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi!<br><br>I installed the latest xenomai patch on a AT91SAM9G20 board
and everything looked good at a first glance: no compilation problems,
low latencies.<br><br>However, when I typed cat /proc/timer_list , the reso=
lutions in=A0 cpu0 and cpu1 items showed 100000 (ns). <br>
(I compiled the Xenomai patched kernel with High Resolution Timers enabled.=
)<br><br>I don&#39;t have this problem when I boot a real time kernel (RT_P=
REEMPT).<br><br>One
more thing. I also have a Beagleboard that runs a Xenomai patched
kernel and in this case the resolution for HRT shows 1 ns, as it should.<br=
>
<br>Thanks,<br>Razvan

--00163645735e6351ca0493c5b432--


MIME-Version: 1.0
Date: Fri, 17 Apr 2009 10:56:47 +0200
Message-ID: <37f89760904170156l79103ccsbae12062a839ceeb@domain.hid>
From: Marcel Soulot <msoulot@domain.hid>
Content-Type: multipart/alternative; boundary=001485ecf70a58b50b0467bc5ca5
Subject: [Xenomai-help] RTDM_EXCLUSIVE
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--001485ecf70a58b50b0467bc5ca5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I tested my driver with and without the device_flags RTDM_EXCLUSIVE.
My test application wrote in C++ and compiled with gcc 4.3.2, crashs the
kernel at the first called function "rt_dev_open" without RTDM_EXCLUSIVE and
works fine if RTDM_EXCLUSIVE is set.
Nothing use the driver except this test application.

does anyone have an idea of the reason of this problem ?

Thank,
Marcel

--001485ecf70a58b50b0467bc5ca5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I tested my driver with and without the device_flags RTDM_EXCLUS=
IVE.<br>My test application wrote in C++ and compiled with gcc 4.3.2, crash=
s the kernel at the first called function &quot;rt_dev_open&quot; without R=
TDM_EXCLUSIVE and works fine if RTDM_EXCLUSIVE is set.<br>
Nothing use the driver except this test application.<br><br>does anyone hav=
e an idea of the reason of this problem ?<br><br>Thank,<br>Marcel<br>

--001485ecf70a58b50b0467bc5ca5--


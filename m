From: Lin Zhang <Lin.Zhang@domain.hid>
Date: Thu, 10 Mar 2011 22:48:20 +0100
Message-ID: <FA526D37A62FA141B5D2D8700F5167C83D79AE3E13@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] Xenomai Posix skin init, device or resource busy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Deal all,=20

I am using Xenomai 2.5.6 (with debug info) + linux 2.6.33 on PowerPC. When =
I run my program, I receive the following error:

Xenomai: Switching MainThread to secondary mode after exception #1025 from =
user-space at 0xf477000)
Xenomai: Switching MainThread to secondary mode after exception #1025 from =
user-space at 0xf541324)
Xenomai: Switching MainThread to secondary mode after exception #1025 from =
user-space at 0xf53ac4c)
...
Xenomai: Switching MainThread to secondary mode after exception #1025 from =
user-space at 0xf53b084)
..
Xenomai: native: cleaning up cond "" (ret=3D0).
Xenomai: native: cleaning up cond "" (ret=3D0).
Xenomai: native: cleaning up mutex "" (ret=3D0).
Xenomai: native: cleaning up mutex "" (ret=3D0).

Xenomai Posix skin init: pthread_setschedparam: Device or resource busy
~#

I tried=20
~ # latency=20
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
latency: failed to set periodic, code -110
warming up...

I am a beginner on using Xenomai, I think there is something wrong with my =
configuration, could someone please help me?

Thanks in advance.=20

Best regards,=20
Lin=


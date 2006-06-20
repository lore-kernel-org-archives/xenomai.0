content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-core] User-space DMA transfer and I/O access from
	XenomaiAPI
Date: Tue, 20 Jun 2006 13:44:11 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D042A304E@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, "Merilainen, Jussi (GE Healthcare)" <jussi.merilainen@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
[..]
>> Another thing is the Device I/O handling from user-space. Simple
question: how do I perform read/write operations? In VxWorks, I have for
example following function for reading an I/O register of the board:
> ...

>On x86, iopl() or ioperm() opens in/out to a user space process. Memory
>mapped I/O should be accessible via /dev/mem on any arch.

Here is a code snippet [4], and also with a shorter URL[5].

[4]
http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acce
ssingPeripheralsFromUserSpace
[5] http://tinyurl.com/6c7th

--=20
Stephane



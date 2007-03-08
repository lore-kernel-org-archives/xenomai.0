Message-ID: <45EFD796.7050002@domain.hid>
Date: Thu, 08 Mar 2007 10:29:58 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] xenomai preempting interrupt handler ?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

Hi all,

using an oscilloscope I found that the AT91RM9200 spends up to 300=B5s in=
 the
interrupt handler for ethernet controller.

Now I wonder if this interrupt handler will be preempted by Xenomai if th=
ere
is a high priority, periodic real time task? Thus will the duration of th=
e
ethernet interrupt handler add the the worst case latency?

Thanks.

--=20
Steven


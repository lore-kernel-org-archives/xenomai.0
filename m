Message-ID: <46444534.1010003@domain.hid>
Date: Fri, 11 May 2007 13:28:04 +0300
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
References: <0pu1igVN.1178881055.0249710.dchabal@domain.hid>
In-Reply-To: <0pu1igVN.1178881055.0249710.dchabal@domain.hid>
Content-Type: text/plain; charset=KOI8-U; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] 16550A driver and Moxa card / solved
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: CHABAL David <david.chabal@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

CHABAL David =D0=C9=DB=C5=D4:

> Maksym, what is the kind of yours connections ? (PC <-> PC with the sam=
e
> moxa cards inside the 2 boxes, or PC <-> other device ) ? (In the 1st
> the case the both clocks are configured with the same value.)
in first case (8 ports board):
- 2 ports (at 38400) to linux host, 2.6.19.2, mxser
- 1 port (at 115200) to winxp host
- 1 port (at 19200) to switcher/mixer (wxworks perhaps inside)

in second case
- 1 port (moxa port at 38400) to videoserver
- 1 port (onboard at 19200) to to switcher/mixer

I had some difficults first time when no specifying base - 2 ports has=20
connectivity but no connectivity (or broken data) from another non RT=20
host :-))


--=20
________________________________________
Maksym Veremeyenko


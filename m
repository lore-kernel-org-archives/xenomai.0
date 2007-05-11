Message-ID: <46446FD3.2030202@domain.hid>
Date: Fri, 11 May 2007 16:29:55 +0300
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
References: <RYexwPRg.1178892718.6286610.dchabal@domain.hid>
In-Reply-To: <RYexwPRg.1178892718.6286610.dchabal@domain.hid>
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

> moxa:  921600/115200 =3D 8 (not 7, I apologize for this mistake but we
> guess here that the baud base is always 921600 and according to the
> mxser file it can be 230400 for some cards)
Then for 'some cards' it's possible to specify 'baud_base' parameter.

What can i suggest/recommend is add to Xenomai wiki some information=20
about using xeno_16550A with some boards (also may be reasonable to add=20
information for proper 'ioaddr' findings for multiports board).


--=20
________________________________________
Maksym Veremeyenko



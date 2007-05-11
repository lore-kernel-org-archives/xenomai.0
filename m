Message-ID: <46447106.2080800@domain.hid>
Date: Fri, 11 May 2007 16:35:02 +0300
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
References: <RYexwPRg.1178892718.6286610.dchabal@domain.hid>
	<46446EC2.3080005@domain.hid>
In-Reply-To: <46446EC2.3080005@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka =D0=C9=DB=C5=D4:

 > (230400+57600)/115200=3D2,5 =3D> 2
 >
 > 230400/115200=3D2

IMHO - even if result was '3' - i would suggest to use formula that=20
gives '3' because it's more correct.

 > So we have the same results for both formulas and I don't see the need
 > for a patch anymore. Do you? Otherwise I would just commit the
 > div-by-zero fix to trunk now and keep the rest as is.
i think 'div-by-zero fix' is enough.

--=20
________________________________________
Maksym Veremeyenko



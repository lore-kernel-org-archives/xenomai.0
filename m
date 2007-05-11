Date: Fri, 11 May 2007 14:11:58 +0000
Message-ID: <RYexwPRg.1178892718.6286610.dchabal@domain.hid>
In-Reply-To: <46445D81.9010008@domain.hid>
From: "CHABAL David" <david.chabal@domain.hid>
Errors-To: "CHABAL David" <david.chabal@domain.hid>
MIME-Version: 1.0 
Content-Type: text/plain; charset=ISO-8859-1
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
To: Jan Kiszka <jan.kiszka@domain.hid>, Maksym Veremeyenko <verem@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>>=20
>> In additional:
>> 1. You should use 921600 value instead of 912.600.
>

The "." was here for reading facility only, I consider it as an integer
in my computations.

>(921600 + (115200 div 2)) div 115200 =3D 8
>
>So back to square #1: misconfiguration? David, please check with the
>correct baud base again if you still see relevant divider variations.
>

moxa:  921600/115200 =3D 8 (not 7, I apologize for this mistake but we
guess here that the baud base is always 921600 and according to the
mxser file it can be 230400 for some cards)

xeno: (921600+57600)/115200 =3D 8.5 rounded to 8

David


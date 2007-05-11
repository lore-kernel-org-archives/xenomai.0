Date: Fri, 11 May 2007 14:33:12 +0000
Message-ID: <8bdn5x94.1178893992.8746080.dchabal@domain.hid>
In-Reply-To: <46446EC2.3080005@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Le 11/5/2007, "Jan Kiszka" <jan.kiszka@domain.hid> a =E9crit:

>CHABAL David wrote:
>>>> In additional:
>>>> 1. You should use 921600 value instead of 912.600.
>>=20
>> The "." was here for reading facility only, I consider it as an integer
>> in my computations.
>
>The point was not the point, but the flipped digits.
>
>>=20
>>> (921600 + (115200 div 2)) div 115200 =3D 8
>>>
>>> So back to square #1: misconfiguration? David, please check with the
>>> correct baud base again if you still see relevant divider variations.
>>>
>>=20
>> moxa:  921600/115200 =3D 8 (not 7, I apologize for this mistake but we
>> guess here that the baud base is always 921600 and according to the
>> mxser file it can be 230400 for some cards)
>
>(230400+57600)/115200=3D2,5 =3D> 2
>
>230400/115200=3D2
>
>???

Oupsss, I'm beaten :-(

The only case  with a different value that I found is for 1200:
(230400+1200)/1200 =3D 193
230400/1200 =3D 192

I think it's not relevant for this speed.

David


>
>>=20
>> xeno: (921600+57600)/115200 =3D 8.5 rounded to 8
>
>So we have the same results for both formulas and I don't see the need
>for a patch anymore. Do you? Otherwise I would just commit the
>div-by-zero fix to trunk now and keep the rest as is.
>
>Jan
>


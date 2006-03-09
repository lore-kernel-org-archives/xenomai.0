Message-ID: <44104044.20606@domain.hid>
Date: Thu, 09 Mar 2006 11:48:36 -0300
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai vs. RTLinux
References: <006f01c64312$a28ab730$a10a10ac@domain.hid>
In-Reply-To: <006f01c64312$a28ab730$a10a10ac@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Christopher Stone <chris@domain.hid>
Cc: xenomai@xenomai.org

Christopher Stone escreveu:
> ...
> Vendor specific API's are like drugs, once you get hooked on them, it is
> difficult to incur the cost of kicking the habit. With Xenomai you can use
> any of a number of skins, but, would be wise to consider the POSIX skin. =
By
> using the industry standard POSIX API your code remains portable and more
> future proof.=20
>  =20
Actually it depends. At the moment, as far as I know, RTDM drivers are=20
not able to communicate to POSIX written programs in every way, like it=20
does with programs written using the native API. So, if there is any=20
plan to write real-time driver (and RTDM really makes this process much=20
easier), so I would recommend using the native API instead. Unless=20
Xenomai is going to support better intercommunication between different=20
skins, if it is possible, or if someone will take the effort to maintain=20
a POSIX version of RTDM...

Rodrigo.


	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com



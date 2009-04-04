Message-ID: <49D73824.9000106@domain.hid>
Date: Sat, 04 Apr 2009 12:36:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1238490688.6422.3.camel@domain.hid>	
	<49D1E294.4070201@domain.hid>
	<8b216e9e0904031415o2cd0ab6bja24b7e30a7543444@domain.hid>
In-Reply-To: <8b216e9e0904031415o2cd0ab6bja24b7e30a7543444@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai on PXA320
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Cc: xenomai@xenomai.org

Felipe Brand=E3o Cavalcanti wrote:
> I did get it working very well in a PXA270 (Gumstix Verdex). I am worki=
ng on
> a little tutorial, but there should be no changes on the xenomai side o=
f
> things, except that you need to run both xeno-test and latency with a -=
p
> 1000 flag.

Normally, you can run latency or xeno-test with the default period if
you enable FCSE (in guaranteed mode).

--=20
					    Gilles.



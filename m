From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] RTDM mmap alternative
Date: Wed, 8 Feb 2006 19:28:16 -0200
References: <20060203192739.87567.qmail@domain.hid>
	<200602061900.35411.lbocseg@domain.hid>
	<43E8DB10.5000901@domain.hid>
In-Reply-To: <43E8DB10.5000901@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200602081928.17224.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

One more doubt: how would I munmap that memory? do_munmap and passing=20
current->mm as the first parameter and the physical address as start? I'm n=
ot=20
sure... Maybe the user can call munmap directly since it doesn't need the=20
file descriptor. But which address should (s)he pass to start parameter, th=
e=20
virtual or the physical one?

Thank you again,

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com



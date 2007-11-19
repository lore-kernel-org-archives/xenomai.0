Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Nov 2007 09:23:33 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB026DBDC5@domain.hid>
In-Reply-To: <18239.3938.28607.266649@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB026DBC4E@is-hdq-exchange.marel.net>
	<18239.3938.28607.266649@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-help] Houston,
	we have a problem ... In timed POSIX space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
>=20
> You misread the POSIX spec. It says:
> "The timeout shall expire when the absolute time specified by
> abs_timeout passes, as measured by the clock on which timeouts are
> based (that is, when the value of that clock equals or exceeds
> abs_timeout), or if the absolute time specified by abs_timeout has
> already been passed at the time of the call."   =20
>=20
> But it also says:
> "Under no circumstance shall the operation fail with a timeout if
> there is sufficient room in the queue to add the message immediately.
> The validity of the abs_timeout parameter need not be checked when
> there is sufficient room in the queue."  =20


Ok. I missed that part. Thanks for clarifying.


But this doen't change the fact that the delivered message is sent
incorrectly.


Best reagrds,

Daniel Schnell.



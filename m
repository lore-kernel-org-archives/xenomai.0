Message-ID: <4A9648A4.3070204@domain.hid>
Date: Thu, 27 Aug 2009 10:49:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2f7260f50908260246jed2b885q9c67375b19343920@domain.hid>	<4A9566C9.7000805@domain.hid>
	<2f7260f50908270146h4e80b012q22d00219e62233be@domain.hid>
In-Reply-To: <2f7260f50908270146h4e80b012q22d00219e62233be@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem with PXA320 and xenomai 2.4.9
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Imanol_Mart=EDnez?= <imanolmc@domain.hid>
Cc: xenomai@xenomai.org

Imanol Mart=EDnez wrote:
>>Please check that when starting from the configuration where you have
>>the bug, if you disable Xenomai (CONFIG_XENOMAI) and the interrupt
>>pipeline (CONFIG_IPIPE), the system works.
>=20
> This way it works, but when applying the patch it still does not work, I
> get the same error...

Ok. When it works, could you show me the contents of /proc/interrupts ?

--=20
                                          Gilles



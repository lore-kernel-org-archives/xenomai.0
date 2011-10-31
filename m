Message-ID: <4EAEA88E.3030500@domain.hid>
Date: Mon, 31 Oct 2011 14:54:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAAeYjM=7aZPLifemq7v2QUzr9HxkU=GxDNFbxH6G+R6z2kQMUA@mail.gmail.com>	<CAAeYjMkmDOLgEdGYPBmyWSPOCaOqWhnC+exeAg6ERzhp8uWkdg@domain.hid>	<CAAeYjMn83FgbqTZRB7E_S4FHP11V-tzdP1eNcY6+n2DJ2SmrGw@domain.hid>	<4EAE9EDE.5030501@domain.hid>
	<4EAEA0AB.4010102@domain.hid>	<CAAeYjMkAwLgMMw9EG7b7CuywNe3OjFPiBkPQQvDOhyhf-coMnw@domain.hid>	<CAAeYjMkjq2yEqd+QeeU5R9N9m3HYWtsib+x7te0hPcd7Kw9SaA@mail.gmail.com>
	<CAAeYjMmsda-t14LQ47HBu0Pv6rLKpp=1m3c2+3unKJfQdF9HMg@domain.hid>
In-Reply-To: <CAAeYjMmsda-t14LQ47HBu0Pv6rLKpp=1m3c2+3unKJfQdF9HMg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] configuring user-space xenomai 2.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?xYF1a2FzeiBTYWNoYQ==?= <dragilla@domain.hid>
Cc: xenomai@xenomai.org

On 10/31/2011 02:48 PM, =C5=81ukasz Sacha wrote:
> quote from README.INSTALL: "Finally, Xenomai build system also allows
> building a Xenomai patchedkernel as part of the user space support
> compilation process. Section1.4 documents this possibility."
>=20
> There is no section 1.4 :(

That is because this option was removed in xenomai 2.6, it was not very
useful anyway, as compiling a kernel is not complicated anyway. Will
remove the sentence, thanks.

To start using xenomai, you simply have to run make install, then copy
the installed file to the embedded root filesystem.

I already gave you URLs for documents giving a bit more details on how
to use the native and posix skins.

Also, could you avoid top-posting?

--=20
                                                                Gilles.



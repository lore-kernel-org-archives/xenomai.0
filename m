Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <517195B6.8020209@xenomai.org>
Date: Sat, 20 Apr 2013 08:04:37 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <12ABCC03-FADF-4C5A-9CAE-CD9E5CA63A19@mah.priv.at>
References: <201304191346.38739.leo@alaxarxa.net>
	<517195B6.8020209@xenomai.org>
Subject: Re: [Xenomai] Default options in the debian package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


Am 19.04.2013 um 21:06 schrieb Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org>:

> On 04/19/2013 01:46 PM, Leopold Palomo-Avellaneda wrote:
>=20
>> [1]=20
>> =
http://lists.mech.kuleuven.be/pipermail/orocos-users/2013-April/006986.htm=
l
>=20
>=20
> Hi,
>=20
> that link does not tell us why you need this option. And that would be
> the most important information.

with the linuxcnc package build I need to turn on --enable-dlopen-skins =
as well to get Python modules to work properly

- Michael

>=20
> If what you need to disable is TLS, then configuring xenomai with
> --without-__thread is sufficient
>=20
> If what you need is to avoid the main thread shadowing, we are not =
going
> to configure xenomai with --enable-dlopen-skins as it breaks otherwise
> conformant applications, but we can add an environment variable like
> XENO_PTHREAD_NO_AUTO_SHADOW to allow supporting both situations.
>=20
> --=20
>                                                                Gilles.
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai



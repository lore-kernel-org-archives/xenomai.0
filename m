Message-ID: <4E305E73.5020903@domain.hid>
Date: Wed, 27 Jul 2011 20:52:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E2E6E73.8090401@domain.hid>
In-Reply-To: <4E2E6E73.8090401@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Exception #14
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: zenati <omar.zenati@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 07/26/2011 09:36 AM, zenati wrote:
> Dear,
>=20
> I'm developping the skin Arinc 653 for Xenomai. I'm trying to run=20
> process with my skin but I have an exception :
>=20
> Xenomai: suspending kernel thread d8824c40 ('=EF=BF=BD') at 0xb76dbdfc =
after=20
> exception #14
>=20
> What is the exception 14 ? Have you an idea how can I solve them?
>=20
> Thank you for your attention and for your help.
> Sincerely,

The meaning of the fault number depends on the platform you are using,
see /proc/xenomai/faults for human readable messages for your platform.
--=20
                                                                Gilles.



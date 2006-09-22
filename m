Subject: Re: [Xenomai-core] 	[PATCH, RFC] Make ioremap'ed memory available
	through	rtdm_mmap_to_user()
From: Stelian Pop <stelian.pop@domain.hid>
In-Reply-To: <4513F625.9010709@domain.hid>
References: <1158337583.13530.20.camel@domain.hid>
	<450AD766.3000307@domain.hid>
	<1158613987.31164.9.camel@domain.hid>
	<45100DF6.8030209@domain.hid>
	<1158914149.14421.10.camel@domain.hid>
	<4513A5D0.3040507@domain.hid>
	<1158924874.19558.6.camel@domain.hid>
	<4513F625.9010709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 22 Sep 2006 16:53:10 +0200
Message-Id: <1158936791.10518.3.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Cc: xenomai@xenomai.org

Le vendredi 22 septembre 2006 =E0 16:41 +0200, Jan Kiszka a =E9crit :=20
> Stelian Pop wrote:
> > Le vendredi 22 septembre 2006 =E0 10:58 +0200, Jan Kiszka a =E9crit :
> >=20
> >>> 	d) make a special rtdm_mmap_iomem_to_user() function...
> >> Also an option. Specifically, it wouldn't break the existing API... =
What
> >> about rtdm_iomap_to_user? Would you like to work out a patch in this
> >> direction?
> >=20
> > Here it comes.
>=20
> Your patch looks very good. Assuming that you have tested it
> successfully,

I did.

>  I'm going to merge it soon.

Thanks.

--=20
Stelian Pop <stelian.pop@domain.hid>



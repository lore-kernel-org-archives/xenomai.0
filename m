From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4E305E73.5020903@domain.hid>
References: <4E2E6E73.8090401@domain.hid>  <4E305E73.5020903@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Jul 2011 09:41:37 +0200
Message-ID: <1311838897.1635.36.camel@domain.hid>
Mime-Version: 1.0
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Wed, 2011-07-27 at 20:52 +0200, Gilles Chanteperdrix wrote:
> On 07/26/2011 09:36 AM, zenati wrote:
> > Dear,
> >=20
> > I'm developping the skin Arinc 653 for Xenomai. I'm trying to run=20
> > process with my skin but I have an exception :
> >=20
> > Xenomai: suspending kernel thread d8824c40 ('=EF=BF=BD') at 0xb76dbdfc =
after=20
> > exception #14
> >=20
> > What is the exception 14 ? Have you an idea how can I solve them?
> >=20
> > Thank you for your attention and for your help.
> > Sincerely,
>=20
> The meaning of the fault number depends on the platform you are using,
> see /proc/xenomai/faults for human readable messages for your platform.

I guess this is PF on x86, and this thread's TCB in kernel space looks
badly trashed. You should probably check the behavior of your Xenomai
kernel threads wrt memory writes, and possibly for stack overflows as
well.

--=20
Philippe.




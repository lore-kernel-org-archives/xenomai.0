Message-ID: <1547536997.2413.1.camel@smigroup.net>
Subject: Re: FPU warn on ipipe 4.9.146-8 i386
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Tue, 15 Jan 2019 08:23:17 +0100
In-Reply-To: <20190114103926.357e0bff@md1za8fc.ad001.siemens.net>
References: <1547197070.2322.4.camel@smigroup.net>
 <20190111104056.71950ea6@md1za8fc.ad001.siemens.net>
 <1547214433.2322.7.camel@smigroup.net>
 <20190114103926.357e0bff@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: Mauro Salvini via Xenomai <xenomai@xenomai.org>

On Mon, 2019-01-14 at 10:39 +0100, Henning Schild wrote:
> Am Fri, 11 Jan 2019 14:47:13 +0100
> schrieb Mauro Salvini <mauro.salvini@smigroup.net>:
>=20
> > On Fri, 2019-01-11 at 10:40 +0100, Henning Schild wrote:
> > > Am Fri, 11 Jan 2019 09:57:50 +0100
> > > schrieb Mauro Salvini via Xenomai <xenomai@xenomai.org>:
> > > =C2=A0=C2=A0
> > > > Hi all,
> > > >=20
> > > > I'm testing same hardware of [1], with kernel 4.9.146 from
> > > > ipipe-
> > > > 4.9.y
> > > > with [2] applied, compiled with ARCH=3Di386 and Xenomai 3.0.7.=C2=
=A0=C2=A0
> > >=20
> > > To be honest i386 is not really tested anymore, in fact in 4.14
> > > not
> > > even supported at the moment. If you can you should go for
> > > x86_64.
> > > =C2=A0=C2=A0
> >=20
> > Hi Henning,
> >=20
> > Thank you. I'm trying i386 version due to legacy 32bit code that
> > uses
> > rtnet (which cannot be used with mixed ABI).
>=20
> Ok, maybe something you might want to fix for the future.
>=20
..snip..
> > > >=20
> > > could you try this:
> > >=20
> > > --- a/arch/x86/kernel/fpu/core.c
> > > +++ b/arch/x86/kernel/fpu/core.c
> > > @@ -426,6 +426,10 @@ void fpu__restore(struct fpu *fpu)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Avoid __kernel_f=
pu_begin() right after
> > > fpregs_activate()
> > > */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kernel_fpu_disable(=
);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace_x86_fpu_befor=
e_restore(fpu);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (fpregs_activate(fpu)=
) {=C2=A0=C2=A0
> >=20
> > This instruction does not compile due to fpregs_activate() returns
> > void, perhaps did you mean "if (fpregs_active(fpu))"?
> > Given that fpregs_active() have no args, I tried with this:
> >=20
> > if (fpu->fpregs_active)
>=20
> I did not test what i wrote there, and your fix is what i meant.
>=20
> > and warning does not raise (even warning added with this patch).
>=20
> In that case a similar patch should probably be included upstream. I
> will prepare a patch for that.
>=20
> Henning

Hi Henning,

I don't know if it concerns about FPU and this discussion, but I did
some tests and also with last fixes the system freezes after a variable
time (from few seconds to few hours) since latency test start.
No logs/warns in /var/log/messages, and hard reset is needed.

I'm investigating if it freezes also with latency running alone.

Tell me if it's worth to continue testing or not (considering that i386
is going to be not supported anymore).

Thanks
Mauro

>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0WARN_ON_FPU(fpu !=3D
> > > this_cpu_read_stable(fpu_fpregs_owner_ctx));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0fpregs_deactivate(fpu);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fpregs_activate(fpu=
);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0copy_kernel_to_fpre=
gs(&fpu->state);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace_x86_fpu_after=
_restore(fpu);
> > >=20
> > > This would not be a proper fix, especially if you end up seeing
> > > that
> > > warning ...
> > >=20
> > > Henning
> > > =C2=A0=C2=A0
> > > >=20
> > > >=20
> > > > =C2=A0=C2=A0
> > >=20
> > > =C2=A0=C2=A0
>=20
>=20


Message-ID: <1546854654.2940.2.camel@smigroup.net>
Subject: Re: [PATCH] cobalt/x86: fix condition in eager fpu code for kernels
 < 4.14
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Mon, 07 Jan 2019 10:50:54 +0100
In-Reply-To: <10f8a2e7-d8b0-74da-d61e-3a1a1ac9b21b@web.de>
References: <20181221134452.15743-1-henning.schild@siemens.com>
 <10f8a2e7-d8b0-74da-d61e-3a1a1ac9b21b@web.de>
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
To: Jan Kiszka <jan.kiszka@web.de>, Henning Schild <henning.schild@siemens.com>, xenomai <xenomai@xenomai.org>

On Sat, 2018-12-22 at 12:42 +0100, Jan Kiszka via Xenomai wrote:
> On 21.12.18 14:44, Henning Schild via Xenomai wrote:
> > From: Henning Schild <henning.schild@siemens.com>
> >=20
> > We should mark the current task as not owning the fpu anymore if it
> > does
> > actually own the fpu, not if the fpu itself is active.
> >=20
> > Fixes cb52e6c7438fa
> >=20
> > Reported-by: Mauro Salvini <mauro.salvini@smigroup.net>
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> > =C2=A0 kernel/cobalt/arch/x86/thread.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/cobalt/arch/x86/thread.c
> > b/kernel/cobalt/arch/x86/thread.c
> > index a09560075..0c6054338 100644
> > --- a/kernel/cobalt/arch/x86/thread.c
> > +++ b/kernel/cobalt/arch/x86/thread.c
> > @@ -475,7 +475,7 @@ void xnarch_leave_root(struct xnthread *root)
> > =C2=A0=C2=A0	switch_fpu_finish(&current->thread.fpu,
> > smp_processor_id());
> > =C2=A0 #else
> > =C2=A0=C2=A0	/* mark current thread as not owning the FPU anymore */
> > -	if (&current->thread.fpu.fpstate_active)
> > +	if (&current->thread.fpu.fpregs_active)
>=20
> Well, if you had used fpregs_active() here, you would have resolved
> also the=C2=A0
> second bug of that line (which I only spotted now):
> "if (&something)" is always true...

Hi,

I'm trying this fix, I'll report results.

Regards
Mauro

>=20
> Jan
>=20
> > =C2=A0=C2=A0		fpregs_deactivate(&current->thread.fpu);
> > =C2=A0 #endif
> > =C2=A0 }
> >=20
>=20
>=20


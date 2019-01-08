Date: Tue, 8 Jan 2019 18:51:39 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCHv2] cobalt/x86: fix condition in eager fpu code for
 kernels < 4.14
Message-ID: <20190108185139.33b25164@md1za8fc.ad001.siemens.net>
In-Reply-To: <1546957031.2392.10.camel@smigroup.net>
References: <20181221134452.15743-1-henning.schild@siemens.com>
 <20190107130416.25271-1-henning.schild@siemens.com>
 <1546957031.2392.10.camel@smigroup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mauro Salvini <mauro.salvini@smigroup.net>
Cc: xenomai <xenomai@xenomai.org>

Am Tue, 8 Jan 2019 15:17:11 +0100
schrieb Mauro Salvini <mauro.salvini@smigroup.net>:

> On Mon, 2019-01-07 at 14:04 +0100, Henning Schild wrote:
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
> > =C2=A0kernel/cobalt/arch/x86/thread.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/cobalt/arch/x86/thread.c
> > b/kernel/cobalt/arch/x86/thread.c
> > index a09560075..ba807ac1e 100644
> > --- a/kernel/cobalt/arch/x86/thread.c
> > +++ b/kernel/cobalt/arch/x86/thread.c
> > @@ -475,7 +475,7 @@ void xnarch_leave_root(struct xnthread *root)
> > =C2=A0	switch_fpu_finish(&current->thread.fpu,
> > smp_processor_id()); #else
> > =C2=A0	/* mark current thread as not owning the FPU anymore */
> > -	if (&current->thread.fpu.fpstate_active)
> > +	if (fpregs_active())
> > =C2=A0		fpregs_deactivate(&current->thread.fpu);
> > =C2=A0#endif
> > =C2=A0} =20
>=20
> Hi all,
>=20
> I tried to launch xeno-test several times under same previous
> conditions and I confirm that this patch fixes the bug.

Good to hear, thanks!

> A side note: would not #include in
> kernel/cobalt/arch/x86/thread.c=C2=A0lines 47,48 and 54 be redundant with
> same includes in kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> (that is indirectly included in thread.c)?

The latter does not have those includes. It is still very possible
that there are a few too many but that is what you have inclusion guards
for. And the code you are looking at 47,48 and 54 is all to support
legacy/old kernels. You are in the IPIPE_X86_FPU_EAGER case.

Henning

> Thanks, regards
> Mauro



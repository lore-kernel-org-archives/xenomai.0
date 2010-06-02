Date: Wed, 2 Jun 2010 12:19:24 +0200
From: Tschaeche IT-Services <services@domain.hid>
Message-ID: <20100602101924.GA27248@domain.hid>
References: <20100601135005.GA5483@domain.hid>
	<1275402757.27918.151.camel@domain.hid>
	<20100601155403.GA8240@domain.hid>
	<4C053C51.4090903@domain.hid> <4C061823.70005@domain.hid>
	<1275470136.18250.16.camel@domain.hid>
	<4C06229F.3030403@domain.hid> <4C062327.5000101@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <4C062327.5000101@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Handling Linux Signals in primary domain context
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Jun 02, 2010 at 11:23:51AM +0200, Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> >> On Wed, 2010-06-02 at 10:36 +0200, Gilles Chanteperdrix wrote:
> >>> Jan Kiszka wrote:
> >>>> Tschaeche IT-Services wrote:
> >>>>> On Tue, Jun 01, 2010 at 04:32:37PM +0200, Philippe Gerum wrote:
> >>>>>> Not in the absence of syscall. We thought about this once alread=
y, when
> >>>>>> considering how a watchdog preempting a runaway task in primary =
mode
> >>>>>> could force a secondary mode switch: there is no sane and easy s=
olution
> >>>>>> to this unfortunately.
> >>>>> This is exactly Sigmatek's problem: Our customers develop code
> >>>>> within our debugging/development environment. We want to catch
> >>>>> this situation (the developer implements a while(1)) with a
> >>>>> watchdog throwing SIGTRAP so that our debugger gets active
> >>>>> and can locate the problem according to the stack frame...
> >>>> CONFIG_XENO_OPT_WATCHDOG is probably what you are looking for. It =
tries
> >>>> to catch "well-behaving" broken threads via SIGDEBUG and kills the
> >>>> hopelessly broken rest - system alive again.
> >>>>
> >>>> You can then debug the former and need to do code review on the la=
tter.
> >>>> Or you could also try to add some loop-breaking Xenomai syscalls (=
or
> >>>> even more clever checks) to library services the code under suspec=
t
> >>>> usually invokes.
> >>> I am afraid "well-behaving" means emitting syscalls. We have a radi=
cal
> >>> way to cause a SIGSEGV to be sent to a thread having run amok: set =
its
> >>> PC to an invalid address (after having printed the real PC). gdb wi=
ll
> >>> not be able to print where the program stopped, but should be able =
to
> >>> print the backtrace.
> >>>
> >> Actually, we could extend this logic and forge a stack frame to retu=
rn
> >> to the preempted application code via some userland trampoline code,
> >> doing the switch:
> >>
> >> [watchdog trigger]
> >> 	forge_return_frame(on =3Dregs->sp, to =3Dregs->pc);
> >> 	regs->pc =3D __oops_I_did_it_again;
> >>
> >> __oops_I_did_it_again:
> >> 	__xn_migrate(LINUX_DOMAIN);
> >> 	ret (via forged frame)
> >>
> >> The thing is, that this brings in some arch-dep code to forge a stac=
k
> >> frame (like the kernel uses for signals), that should rather live in=
 the
> >> pipeline core.
> >=20
> > There seems to be a simple approach:
> > when the thread runs amok, set the pc to invalid address, save the re=
al
> > pc somewhere
> > when relaxing for handling the exception (xnpod_trap_fault), if the a=
mok
> > bit is set, restore the pc in the saved registers from the saved loca=
tion.
>=20
> Sounds feasible, will give it a try.

Looking at your discussion, handling asynchronous Linux signals in a prim=
ary domain task
is not a "must" (but would be nice) for Xenomai according to initiate the=
 signal handling
in secondary domain *immediately*.

Another solution might be, checking the state of the AMOK-task when Xenom=
ai
schedules the task for execution. If Linux-Signals are pending, force sec=
ondary
domain switch. Thus, asynchronous Linux signals are handled at latest on
primary domain scheduler activities - which would be sufficient for us...

Regards,

	Olli

--=20
Tschaeche IT-Services       Tel.:  +49/9134/9089850
Dr.-Ing. Oliver Tsch=E4che    Mobil: +49/176/20435601
Welluckenweg 4              Email: services@domain.hid
91077 Neunkirchen


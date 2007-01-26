Subject: Antwort: Re: [Xenomai-core] Questions about pSOS task mode and task
	priority
MIME-Version: 1.0
Message-ID: <OF5910DE28.1586BCD6-ONC125726F.005E4D75@domain.hid>
From: "Thomas Necker" <Thomas.Necker@domain.hid>
Date: Fri, 26 Jan 2007 18:16:36 +0100
Content-Type: text/plain; charset="iso-8859-1"
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
To: xenomai@xenomai.org

Hi Philippe

> > non-preemptive mode.
> > With original pSOS this was allowed and "non-preemptive" meant that a
> > runnable task cannot be preempted by other tasks but can block itself.
> > Why is this different in Xenomai and is it possible to implement the=20
same
> > behaviour in Xenomai core?
> >=20
>=20
> Xenomai implements the non-preemptible mode as most RTOSes implement
> scheduling locks. From this POV, allowing a non-preemptible task to
> block makes no sense, and doing so usually either locks up the board, or
> causes an API error.
>=20
> It could be possible to switch the preemption bit on before entering a
> blocking state only for pSOS tasks, then reinstate it when the task
> wakes up, though. However, before going down that path, is there any
> pSOS documentation that clearly states that such behaviour is to be
> expected (i.e. that blocking calls =5Fmay=5F be called in non-preemptible
> mode)?
>=20
> Or did you benefit from an undocumented and fortunate side-effect of the
> pSOS implementation when relying on such behaviour?

Since Markus has already left, I had a quick look in the pSOS System=20
Concepts Manual:

    Each task has a mode word, with two settable bits that can affect=20
scheduling.
    One bit controls the task's preemptibility. If disabled, then once the =

task
    enters the running state, it will stay running even if other tasks
    of higher priority enter the ready state. A task switch will occur=20
only if
    the running task blocks, or if it re-enables preemption.

So it clearly states that a non-preemtible task may block (and=20
rescheduling occurs in
this case).

Regards,
Thomas





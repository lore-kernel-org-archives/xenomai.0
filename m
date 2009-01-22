Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jan 2009 13:22:49 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A01776CCD@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <497724DB.9030706@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: Re: [Xenomai-help] How to use Xenomai libraries with "normal" (non
	Xenomai) linux processes ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

Jan Kiszka wrote:

> > The point is that if you force it to secondary mode, and=20
> the next system
> > call is in fact a xenomai syscall, xenomai will switch the thread to
> > primary mode again. So, you have two useless mode switches which you
> > could have avoided if you had not forcibly switched to=20
> secondary mode.
> > Note that even if a xenomai thread is running in secondary=20
> mode and has
> > a priority higher than another xenomai thread running in=20
> primary mode,
> > the one running in secondary mode will run. So, you should not use
> > primary mode and secondary mode to decide which thread=20
> should run, you
> > should use the priorities.
>=20
> The only imaginable scenario for having to force some thread back to
> secondary mode is when that thread is running significant CPU load
> _without_ issuing a single regular syscall. If such a thread enters
> primary mode and is then left there, Linux will not be able to run
> anymore. In that case one may insert a tiny nanosleep etc. to enforce
> the switch. But that's still a fairly theoretic scenario.
>=20

But nanosleep is a Xenomai function. So, after that nanosleep the
process would return to pimary mode and run in front of all other
Xenomai tasks (a high priority provided) although it has been just an
oridnary Linux task (which has been linked with a Xenomai library) and
therefore should only run when all Xenomai processes yield CPU. Am I
right? Do you understand my dilemma ?

Best regards
Roderik

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933


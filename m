From: "George Pontis" <GPontis@z9.com>
References: <mailman.293.1366744201.1444.xenomai@xenomai.org>
	<006201ce45e4$5dc8e4f0$195aaed0$@com>
	<5183FDA4.2090003@xenomai.org>
	<037901ce482a$1f10bce0$5d3236a0$@com>
	<5183FFDD.7080707@xenomai.org>
In-Reply-To: <5183FFDD.7080707@xenomai.org>
Date: Fri, 3 May 2013 11:30:20 -0700
Message-ID: <037c01ce482c$44b7cc20$ce276460$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
Subject: Re: [Xenomai] Qt - Xenomai compatibility problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org



> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Friday, May 03, 2013 11:20 AM
> To: George Pontis
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] Qt - Xenomai compatibility problem
>=20
> On 05/03/2013 08:14 PM, George Pontis wrote:
>=20
> >> -----Original Message-----
> >> From: Gilles Chanteperdrix =
[mailto:gilles.chanteperdrix@xenomai.org]
> >> Sent: Friday, May 03, 2013 11:11 AM
> >> To: George Pontis
> >> Cc: xenomai@xenomai.org
> >> Subject: Re: [Xenomai] Qt - Xenomai compatibility problem
> >>
> >> On 04/30/2013 10:50 PM, George Pontis wrote:
> >>
> >>> I took a snapshot from git of the current Xenomai code and put it =
in the hands of the
> >> software
> >>> developers. They reported that Qt would not build after patching =
with Xenomai. The problem
> >> was that
> >>> Qt uses "signals" as a keyword, and that conflicts with the =
function prototype for
> >> rt_task_notify
> >>> under xenomai/native:
> >>>
> >>>
> >>> int rt_task_notify(RT_TASK *task, rt_sigset_t signals);
> >>>
> >>>
> >>> Although this is not a Xenomai problem, it might save some users =
the annoyance if the name
> >> "signals"
> >>> could change.
> >>
> >>
> >> Have you tried the obvious fix?
> >>
> >> --
> >>                                                                 =
Gilles.
> >
> >
> > Yes, to us the obvious fix was to edit the function prototype in the =
include file
> > and change "signals" to "_signals".
>=20
>=20
> And there are no other changes to make to get Xenomai headers included
> with qt headers?
>=20
> --
>                                                                 =
Gilles.


That was the only change that we needed for our environment. We only use =
the Posix and native skins. I grep'ed
the include files and found psos+/psos.h and nucleus/thread.h also use =
"signals".=20

Geo. =20




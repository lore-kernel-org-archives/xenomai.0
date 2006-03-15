Message-ID: <20060315003134.11232.qmail@domain.hid>
Date: Wed, 15 Mar 2006 00:31:34 +0000 (GMT)
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] RTDM and Timer functions
In-Reply-To: <441748D5.9050305@domain.hid>
MIME-Version: 1.0
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

--- Jan Kiszka <jan.kiszka@domain.hid> escreveu:

> ...
> >> Moreover, when considering the TSC as high-resolution timestamp source,
> >> this is not applicable on SMP / multicore systems. Those tend to have
> >> unsynchronised and drifting TSCs. So if the first picture was taken on
> >> one CPU and the second on some other...
> >=20
> > Unfortunately I can not arguee on that for now since I know almost noth=
ing=20
> > about SMP systems. I'll take a look on the topic and hopely soon I'll r=
eturn=20
> > you what I think about it.
>=20
> Then let me continue my sentence:
>=20
> ... the timestamps can not be used to calculate the delay between both
> of them. The reason is that you are lacking the offset between both TSC
> sources at the respective timestamp acquisition dates.

I understood that. What I've said is that I do not have enough knowledge ab=
out SMP systems for
suggesting you a way of dealing with this kind of problem.

> > ...
> > I don't understand why adding a new function like this would change a l=
ot the=20
> > documentation. I really can not see your worries... If you could give m=
e a=20
> > practical example, maybe it would be easier for me...
>=20
> A driver that reports TSC timestamps instead of system clock timestamps
> to the user has to state this fact and its potential effects in periodic
> mode - as long as both clocks are out of sync.

That I understand. But I couldn't figure out which changes should be made t=
o documentation for
adding this function. Of course, as usual, the programmer will need to know=
 what (s)he is doing. A
single note explaining the situation in the rtdm_clock_read_tsc() function =
would suffice in my
opinion. I do not think that adding this function would imply in any confus=
ion for developers.

> My idea is now to
> synchronise them and report corrected TSC-based timestamps via
> rtdm_clock_read() when in periodic mode. No need for new functions, use
> the old one, and all your problems would be solved automatically.

What do you mean by "corrected TSC-based timestamps"? How would be this mec=
hanism? Which
resolution would it give?

I think you are meaning that:

On RTDM load, there is an automatic calculation of the offsets between the =
TSC of each CPU and the
Xenomai timer. Then, rtdm_clock_read() would change it behaviour to returni=
ng a higher precision
time read, based on TSC and correcting them with the stored offsets. Is tha=
t right?

Rodrigo.



	=09
_______________________________________________________=20
Novo Yahoo! Messenger com voz: Instale agora e fa=E7a liga=E7=F5es de gra=
=E7a.=20
http://br.messenger.yahoo.com/


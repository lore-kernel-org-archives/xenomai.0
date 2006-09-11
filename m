From: "Serge Noiraud" <serge.noiraud@domain.hid>
Subject: Re: [Xenomai-help] Linux + PREEMPT_RT + LTTng + Xenomai
Date: Mon, 11 Sep 2006 14:18:25 +0200
References: <200609071445.53611.Serge.Noiraud@domain.hid>
	<4500182A.6000009@domain.hid>
In-Reply-To: <4500182A.6000009@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609111418.25324.Serge.Noiraud@domain.hid>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi evrybody,

   I send this message last week and I had no response. I don't see it in t=
he archives, so I repost it.

jeudi 7 Septembre 2006 15:01, Jan Kiszka wrote/a =E9crit=A0:
> Serge Noiraud wrote:
> > Hi, everybody
> >=20
> > 	I'm new to this list and I have several questions :
> >=20
> > I currently use linux 2.6.16 + rt from Ingo Molnar + LTTng on IA32 arch=
itecture.
> >=20
> > I would like to know how difficult will be the job to add Xenomai over =
this.
> > Perhaps this is already in your roadmap ?
>=20
> It is, see yesterday's thread on this:
> https://mail.gna.org/public/xenomai-help/2006-09/msg00029.html
>=20
> LTTng will likely be supported far earlier. The nucleus is prepared for
> it for quite a while, we are currently just lacking a recent LTT+Ipipe
> combo patch. But this task is scheduled to start soon. See also this
> list's archive or xenomai-core on related discussions.
>=20
> > Do we need to wait for a main line inclusion of the RT patch ?
> >=20
>=20
> Not necessarily, though this would simplify things.
>=20
> However, any helping hand or mind can accelerate the process. So,
> contributions are welcome. What application scenario do you have in mind?
I take my machines on the shelves for economic strategy ! So they are certa=
inly *NOT* realtime aware !
I think my RT knowledges aren't sufficient to help you in development, but =
I can be a tester if you want. Plus if I can.

I would like Xenomai manage IRQs for some specific cards.
The others could be managed by linux-rt.
If I understand correctly how it works, I must rewrite my drivers. is it co=
rrect ?

I currently get 50-60us latencies. This is not sufficient for me. I would l=
ike to down to 10-15us for these cards.
and I have one latency every three days about 9000us ( BIOS or hardware pro=
blem ? ).
So I hope Xenomai could be the solution.

Am I in the good way ?

>=20
> Jan
>=20
>=20

=2D-=20
Serge Noiraud



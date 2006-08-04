Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 04 Aug 2006 09:08:41 +0200
From: GSM909@domain.hid
Message-ID: <20060804070841.313620@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Time between ISR and RT Task
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
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

GSM909@domain.hid wrote:
 > Hello
 >
 > I have run a few programs with Xenomai tasks and have no problems. But I=
 notice that the time between ISR and RT task ( RT task is suspended and re=
sumed by the ISR) is shorter when Linux have a lot of work ( average load a=
round 10 ) as when Linux has nothing to do( al : 0.05 ).=20

Do you observe this for worst case, or for average case latencies? Do you o=
bserve this when you boot with the idle=3Dpoll parameter ?

When idle, Linux uses the 'hlt' instruction, that stops the CPU until an in=
terrupt happen, maybe waking up from this state take a little bit more time=
 than when an interrupt is received directly?

How can I set idel =3D poll ?
and what are other options for idel ?=20

Regards=20
Ted
--=20


					    Gilles Chanteperdrix.



--=20


Echte DSL-Flatrate dauerhaft f=FCr 0,- Euro*. Nur noch kurze Zeit!
"Feel free" mit GMX DSL: http://www.gmx.net/de/go/dsl


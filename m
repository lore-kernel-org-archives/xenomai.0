Message-ID: <fd6a47a90601181426t582fc028k@domain.hid>
Date: Wed, 18 Jan 2006 23:26:45 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] Scheduling while atomic
In-Reply-To: <43CEBD90.7080603@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6315_13686525.1137623205567"
References: <fd6a47a90601181204g4c86f778x@domain.hid>
	<43CEA323.7000701@domain.hid> <43CEAF25.6010705@domain.hid>
	<43CEB291.4020609@domain.hid>
	<fd6a47a90601181334y14b06d6an@domain.hid>
	<43CEBD90.7080603@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_6315_13686525.1137623205567
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>
> # ./sem 1.0e5
> Running for 2.15 seconds.
> L119: Operation not permitted.


Could be a dirty cleanup. Sorry for that.


> ...ipipe_supend_domain
> ...default_idle
> ...cpu_idle
> ...start_kernel
> ...unknown_bootoption
> Kernel panic


start_kernel ? Unknown_bootoption ? The plot is thickening.



> # ./mutex 1.0e5
> ALERT: No lock! (lockcnt=3D0) Offending task: task0
> ALERT: No lock! (lockcnt=3D0) Offending task: task0
> ALERT: No lock! (lockcnt=3D0) Offending task: task0
> [...]
> [freeze]


The problem is: freezing could be due to Linux getting no CPU time anymore.
I think the best test now is to run the semaphore test (it should give no
ALERTS) at a reasonable (1.0e6 - 1.0e7, which is on average 2kHz - 200Hz)
speed for a longer duration. Maybe better 1.0e7, which will yield
about 1.5Mb per hour.

Many thanks already for testing and helping us out.

Jeroen.

------=_Part_6315_13686525.1137623205567
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"># ./sem 1.0e5<br>Running for 2.1=
5 seconds.<br>L119: Operation not permitted.</blockquote>
<div>&nbsp;</div>
<div>Could be a dirty cleanup. Sorry for that.<br>&nbsp;</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">...ipipe_supend_domain<br>...def=
ault_idle<br>...cpu_idle<br>...start_kernel<br>...unknown_bootoption<br>Ker=
nel panic
</blockquote>
<div>&nbsp;</div>
<div>start_kernel ? Unknown_bootoption ? The plot is thickening.</div>
<div><br>&nbsp;</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"># ./mutex 1.0e5<br>ALERT: No loc=
k! (lockcnt=3D0) Offending task: task0<br>ALERT: No lock! (lockcnt=3D0) Off=
ending task: task0
<br>ALERT: No lock! (lockcnt=3D0) Offending task: task0<br>[...]<br>[freeze=
]</blockquote>
<div>&nbsp;</div>
<div>The problem is: freezing could be due to Linux getting no CPU time any=
more. I think the best test now is to run the semaphore test (it&nbsp;shoul=
d give&nbsp;no ALERTS) at a reasonable (1.0e6 - 1.0e7, which is on average =
2kHz - 200Hz) speed for a longer duration. Maybe better=20
1.0e7, which will yield about 1.5 Mb per hour.</div>
<p>Many thanks already for testing and helping us out.</p>
<div>&nbsp;</div>
<div>Jeroen.</div>

------=_Part_6315_13686525.1137623205567--


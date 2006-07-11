Subject: Re: [Xenomai-core] Xenomai on PXA
From: Stelian Pop <stelian.pop@domain.hid>
In-Reply-To: <44B34343.9F56F13@domain.hid>
References: <200607071703.10700.vagninu@domain.hid>
	<17582.50372.830923.414981@domain.hid>
	<44B34343.9F56F13@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 11 Jul 2006 17:01:51 +0200
Message-Id: <1152630145.21591.1.camel@domain.hid>
Mime-Version: 1.0
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
To: Detlef Vollmann <dv@domain.hid>
Cc: xenomai@xenomai.org

Le mardi 11 juillet 2006 =E0 08:20 +0200, Detlef Vollmann a =E9crit :

> What is missing is a look at entry-macro.S.
> Stelian Pop has done something for the Integrator that I don't
> really understand and therefore I can't say whether the PXA needs
> something similar.

Well, you should have asked if you didn't undestand. :)

The change in entry-macro.S does optimize the fast path for a timer
interrupt. Instead of looking at each interrupt controller status and
compute the irq number the code tests the timer interrupt status and
returns immediately if true.=20

Stelian.
--=20
Stelian Pop <stelian.pop@domain.hid>



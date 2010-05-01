From: Andreas Glatz <AndreasGlatz@domain.hid>
Date: Sat, 1 May 2010 11:59:16 -0400
Message-ID: <245373446233674495BCA5CA2FC1EB17378D015935@domain.hid>
References: <20100430233410.GA8991@domain.hid>,
	<4BDBF265.7080501@domain.hid>
In-Reply-To: <4BDBF265.7080501@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Page fault and secondary mode switch on PowerPC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


> > We are running our tests now where Linux is bombarded with interrupts. =
Under certain conditions
> > we found that we get page faults in IRQ Tasks which cause a secondary m=
ode switch. To my understanding
> > and what makes things worse is that, ISR tasks always run with the sche=
duler lock bit set (T_LOCK).
> > In our case this means that when we switch to the secondary mode from t=
he ISR Task, all other Xenomai
> > tasks don't get scheduled until the ISR task returns to primary mode. S=
ince Linux is under heavy
> > interrupt load, it takes about 1-2sec for any Xenomai task to start run=
ning again.
> >
> > I attached a LTTng trace where you can see whats going on. Here the sho=
rt version:
>=20
> Could you tell us what version of Xenomai you are using?

Linux 2.6.32-5, Xenomai 2.4.10.1, Ipipe 2.8


> And if your program uses fork() (or anything which uses fork such as
> system(), or popen())?

Yes but all the real-time threads are created in the parent.=20
The children are just helper processes which don't make use of Xenomai APIs=
 at all.

Andreas



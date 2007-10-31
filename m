Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 Oct 2007 09:39:15 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB025E454B@is-hdq-exchange.marel.net>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0E30519@domain.hid>
References: <200710301203.l9UC3esT009573@domain.hid><2ff1a98a0710300629v5df42d78sf6c4795f1c4e782b@domain.hid>
	<FDBBB5CC70676540B3EF7CFE83FD94E0E30519@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-help] RT, nonRT communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

ROSSIER Daniel wrote:

> .....
>=20
> I guess there is a misunderstanding of "main thread" here. The main
> thread should actually not be a xenomai thread since it belongs to a
> non-RT application. Patrick is actually using the Qt framework on a
> PXA device which of course is not a RT-domain application. The thing
> is that the Qt application should somehow retrieve some data issued
> from RT-application. Currently the Qt application is starting a
> Xenomai thread - by doing an extern "c" invokation from Qt - and the
> data list is shared between the main (qt-)thread (non-RT) and the
> Xenomai thread; that's why Patrick wanted to use a mutex. But indeed,
> as far as I know, it will be not possible to do that since the
> waiting queues on sync objects as mutex are managed differently
> (dealing with linux threads on the one hand, with Xenomai threads on
> the other hand) between the RT and non-RT domains. So the question
> would be: how can data be exchanged in a safe way between a non-RT
> domain and a RT-domain?             =20

We are using Posix message queues and/or shared memory.

Works for either way.


Best regards,

Daniel.


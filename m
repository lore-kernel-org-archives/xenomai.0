MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <18216.16434.853914.993008@domain.hid>
Date: Wed, 31 Oct 2007 09:43:30 +0100
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0E30519@domain.hid>
References: <200710301203.l9UC3esT009573@domain.hid>
	<2ff1a98a0710300629v5df42d78sf6c4795f1c4e782b@domain.hid>
	<FDBBB5CC70676540B3EF7CFE83FD94E0E30519@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
 > >-----Original Message-----
 > >From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@doma=
in.hid]
 > >On Behalf Of Gilles Chanteperdrix
 > >Sent: mardi 30 octobre 2007 14:30
 > >To: Patrick
 > >Cc: xenomai@xenomai.org
 > >Subject: Re: [Xenomai-help] RT, nonRT communication
 > >
 > >On 10/30/07, Patrick <kpa_info@domain.hid> wrote:
 > >> > -----Message d'origine-----
 > >> > De: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
 > >> > Envoy=E9: mardi, 30. octobre 2007 10:52
 > >> > =C0: Patrick
 > >> > Cc: xenomai@xenomai.org
 > >> > Objet: Re: [Xenomai-help] TR: RT, nonRT communication
 > >> >
 > >> > On 10/30/07, Patrick <kpa_info@domain.hid> wrote:
 > >> > >
 > >> > >
 > >> > >
 > >> > >
 > >> > > Hi,
 > >> > >
 > >> > >
 > >> > >
 > >> > > Is it possible to share a pthread_mutex between a rt task and a
 > >linux
 > >> > > pthread ?
 > >> >
 > >> > No, it is not possible
 > >> >
 > >> > >
 > >> > > My two tasks must share resources and I must protect them against
 > >> > concurrent
 > >> > > access.
 > >> > >
 > >> > > If pthread_mutex is not the correct way to do it can you tell me
 > >how to
 > >> > > achieve this ?
 > >> >
 > >> > The way to handle these border line cases is to make your linux
 > >> > pthread a xenomai thread running with the SCHED_OTHER scheduling
 > >> > policy. Note that the main thread already has this property.
 > >> >
 > >> Ok, so if I understand I can't use a pthread_mutex between the main
 > >thread
 > >> and a rt_task ?
 > >
 > >You CAN use a xenomai pthread_mutex between the main thread and a
 > >rt_task, the main thread is a xenomai thread running with the
 > >SCHED_OTHER scheduling policy.
 > >
 >=20
 > I guess there is a misunderstanding of "main thread" here. The main thre=
ad should actually not be a xenomai thread since it belongs to a non-RT app=
lication. Patrick is actually using the Qt framework on a PXA device which =
of course is not a RT-domain application. The thing is that the Qt applicat=
ion should somehow retrieve some data issued from RT-application. Currently=
 the Qt application is starting a Xenomai thread - by doing an extern "c" i=
nvokation from Qt - and the data list is shared between the main (qt-)threa=
d (non-RT) and the Xenomai thread; that's why Patrick wanted to use a mutex=
. But indeed, as far as I know, it will be not possible to do that since th=
e waiting queues on sync objects as mutex are managed differently (dealing =
with linux threads on the one hand, with Xenomai threads on the other hand)=
 between the RT and non-RT domains. So the question would be: how can data =
be exchanged in a safe way between a non-RT domain and a RT-domain?

As soon as you compile your application with the flags returned by
xeno-config --posix-cflags and xeno-config --posix-ldflags, it really
becomes an RT application where all threads are real-time threads. The
only way to create a non real-time thread in such an application is by
calling __real_pthread_create.

--=20


					    Gilles Chanteperdrix.


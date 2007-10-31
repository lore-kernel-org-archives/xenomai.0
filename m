Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 Oct 2007 08:37:57 +0100
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0E30519@domain.hid>
In-Reply-To: <2ff1a98a0710300629v5df42d78sf6c4795f1c4e782b@domain.hid>
References: <200710301203.l9UC3esT009573@domain.hid>
	<2ff1a98a0710300629v5df42d78sf6c4795f1c4e782b@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org

>-----Original Message-----
>From: xenomai-help-bounces@domain.hid =
[mailto:xenomai-help-bounces@domain.hid]
>On Behalf Of Gilles Chanteperdrix
>Sent: mardi 30 octobre 2007 14:30
>To: Patrick
>Cc: xenomai@xenomai.org
>Subject: Re: [Xenomai-help] RT, nonRT communication
>
>On 10/30/07, Patrick <kpa_info@domain.hid> wrote:
>> > -----Message d'origine-----
>> > De: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>> > Envoy=E9: mardi, 30. octobre 2007 10:52
>> > =C0: Patrick
>> > Cc: xenomai@xenomai.org
>> > Objet: Re: [Xenomai-help] TR: RT, nonRT communication
>> >
>> > On 10/30/07, Patrick <kpa_info@domain.hid> wrote:
>> > >
>> > >
>> > >
>> > >
>> > > Hi,
>> > >
>> > >
>> > >
>> > > Is it possible to share a pthread_mutex between a rt task and a
>linux
>> > > pthread ?
>> >
>> > No, it is not possible
>> >
>> > >
>> > > My two tasks must share resources and I must protect them against
>> > concurrent
>> > > access.
>> > >
>> > > If pthread_mutex is not the correct way to do it can you tell me
>how to
>> > > achieve this ?
>> >
>> > The way to handle these border line cases is to make your linux
>> > pthread a xenomai thread running with the SCHED_OTHER scheduling
>> > policy. Note that the main thread already has this property.
>> >
>> Ok, so if I understand I can't use a pthread_mutex between the main
>thread
>> and a rt_task ?
>
>You CAN use a xenomai pthread_mutex between the main thread and a
>rt_task, the main thread is a xenomai thread running with the
>SCHED_OTHER scheduling policy.
>

I guess there is a misunderstanding of "main thread" here. The main =
thread should actually not be a xenomai thread since it belongs to a =
non-RT application. Patrick is actually using the Qt framework on a PXA =
device which of course is not a RT-domain application. The thing is that =
the Qt application should somehow retrieve some data issued from =
RT-application. Currently the Qt application is starting a Xenomai =
thread - by doing an extern "c" invokation from Qt - and the data list =
is shared between the main (qt-)thread (non-RT) and the Xenomai thread; =
that's why Patrick wanted to use a mutex. But indeed, as far as I know, =
it will be not possible to do that since the waiting queues on sync =
objects as mutex are managed differently (dealing with linux threads on =
the one hand, with Xenomai threads on the other hand) between the RT and =
non-RT domains. So the question would be: how can data be exchanged in a =
safe way between a non-RT domain and a RT-domain?

>> If I want use pthread_mutex between another pthread and a rt_task,
>must the
>> pthred be running with SCHED_OTHER ? This value is the default value
>for
>> pthread !
>
>The pthread must be a xenomai posix skin thread running with the
>SCHED_OTHER policy. You can achieve this by creating this pthread with
>xenomai wrapped pthread_create, or by setting its policy (assuming the
>thread was created with the non wrapped pthread_create, i.e.
>__real_pthread_create) with xenomai wrapped pthread_setschedparam.
>
>In other words, if you use Xenomai wrapped functions, everything
>should be fine. Things become tricky when you decide to use __real_*
>functions.
>
>--
>                                               Gilles Chanteperdrix
>
>_______________________________________________
>Xenomai-help mailing list
>Xenomai-help@domain.hid
>https://mail.gna.org/listinfo/xenomai-help

Daniel



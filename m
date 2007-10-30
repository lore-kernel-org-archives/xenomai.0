Message-Id: <200710301203.l9UC3esT009573@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Tue, 30 Oct 2007 13:03:42 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] RT, nonRT communication
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

Ok, so if I understand I can't use a pthread_mutex between the main =
thread
and a rt_task ?
If I want use pthread_mutex between another pthread and a rt_task, must =
the
pthred be running with SCHED_OTHER ? This value is the default value for
pthread !

Thank's

-----Message d'origine-----
De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=E9=A0: mardi, 30. octobre 2007 10:52
=C0=A0: Patrick
Cc=A0: xenomai@xenomai.org
Objet=A0: Re: [Xenomai-help] TR: RT, nonRT communication

On 10/30/07, Patrick <kpa_info@domain.hid> wrote:
>
>
>
>
> Hi,
>
>
>
> Is it possible to share a pthread_mutex between a rt task and a linux
> pthread ?

No, it is not possible

>
> My two tasks must share resources and I must protect them against
concurrent
> access.
>
> If pthread_mutex is not the correct way to do it can you tell me how =
to
> achieve this ?

The way to handle these border line cases is to make your linux
pthread a xenomai thread running with the SCHED_OTHER scheduling
policy. Note that the main thread already has this property.

--=20
                                               Gilles Chanteperdrix



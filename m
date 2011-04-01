MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: davide doninelli <Davide.Doninelli@domain.hid>
In-Reply-To: <4D959B95.4060006@domain.hid>
Date: Fri, 1 Apr 2011 11:52:44 +0200
Content-Transfer-Encoding: quoted-printable
Message-ID: <1048D583-68E6-4D7C-9A56-FBE68FCFA751@domain.hid>
References: <A537C502-9185-43A0-999B-A2DB8583008E@edu.hefr.ch>
	<4D959B95.4060006@domain.hid>
Subject: Re: [Xenomai-help] process on linux
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

ok, two more questions...
What's main thread and manager thread roles?
I looked on the web site for technical docs about schedulers =
interaction, have you some advice for any docs?

best regards
davide

Il giorno 1-apr-2011, alle ore 11.32, Gilles Chanteperdrix ha scritto:

> davide doninelli wrote:
>> Hi=20
>> i see in linux proces 3 xenomai processes per xenomai RT task .
>> I don't understand what are the first 2 process.
>> Is that right? What are used for? Tasks are like in envelope?
>> i don't find information about that.
>>=20
>> #ps
>> ....
>> 483 root     ./interrupt_xeno_userspacen=20
>>  484 root     ./interrupt_xeno_userspacen=20
>>  485 root     ./interrupt_xeno_userspacen=20
>=20
> With the quantity of information you give us, we can only guess, but =
you
> probably use a linuxthreads based libc, so:
> - each thread appears as an entry in ps output
> - there is a "manager" thread called when creating the first thread.
>=20
> So, 483 is probably the main thread, 484 the manager thread, 485 is =
the
> "mytask" thread.
>=20
> Still guessing, I think you are confusing 2 + N with 3 * N, because =
you
> only tested with N =3D=3D 1.
>=20
> --=20
> 					    Gilles.



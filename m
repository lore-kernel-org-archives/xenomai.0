Message-ID: <475E7F84.1040600@domain.hid>
Date: Tue, 11 Dec 2007 13:16:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <475E76A0.4010007@domain.hid> <475E7CBA.7060300@domain.hid>
In-Reply-To: <475E7CBA.7060300@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Application broken 2.3.4 ---> 2.4.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez wrote:
> Ignacio Garc=EDa P=E9rez escribi=F3:
>=20
> Ok, replying myself with further findings:
>=20
> It turns out that the following code miserably fails to set the thread=20
> periodic:
>=20
> rt_task_set_periodic(&_blink_thread, rt_timer_read(), mili2count(250));
>=20
> Where this actually works:
>=20
> rt_task_set_periodic(&_blink_thread, TM_NOW, mili2count(250));
>=20
> Which makes me think that rt_task_set_periodic() fails when the passed=20
> idate is in the past.
>=20
> And you may say: why the hell do you use rt_timer_read() when you can=20
> use TM_NOW ???
>=20
> Well, I think that rt_task_set_periodic should word (AND DID) both ways=
,=20
> but actually I have a very good reason to (sometimes) use an idate in=20
> the past: I want the blinking synchronized to the "event" as closely as=
=20
> possible. If there is a delay D from my recorded time for the event to=20
> the actual call to rt_task_set_periodic, I can:
>=20
> a) Use rt_task_set_periodic(TM_NOD)
>=20
> b) Use rt_task_set_periodic(recorded_time)
>=20
> In the first case there will be a delay of D from every period to the=20
> "event", while in the second case that delay will be only in the FIRST=20
> execution of the periodic task.
>=20
> Anyway, something is truly screwed up when=20
> rt_task_set_periodic(&_blink_thread, rt_timer_read(), mili2count(250))=20
> fails to make the task periodic...

That's due to the reworked timer subsystem: Starting timers (like the
periodic task timer) in the past is reported as error - up to the
application in this case. One may discuss if this case can be considered
as an undocumented API change (I haven't re-read the docs in this regard
yet).

However, what about this to resolve your issue:

while start_date < now()
	start_date +=3D period

Of course you can write this more smartly than using a loop (e.g. if you
know that already start_date + period > now()).

Jan


--=20
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux


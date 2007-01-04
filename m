Message-ID: <20232333.1167920377625.JavaMail.ngmail@domain.hid>
Date: Thu, 4 Jan 2007 15:19:37 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Xenomai native skin: Opposite of rt_task_shadow?
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

Hello everybody,

is there an opposite function of rt_task_shadow() that turns a real time en=
abled
task back in a normal linux task?
My idea is:

void main()
{
    ... Init stuff
    rt_task_shadow();
    ...Do some realtime stuff
    rt_task_unshadow();
    ...Continue with normal stuff
}

When I do a rt_task_delete() for rt_task_unshadow() in my example, the appl=
ication
stops there.
I do not want to have a separate task for the realtime stuff as I do not wa=
nt to synchronize
them with the standard linux task... (Perhaps, I have to do that...)

Thanks for all feedback on that.

Regards

Mathias

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2


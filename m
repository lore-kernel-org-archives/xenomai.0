Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Nov 2011 09:51:45 +0100
Message-ID: <A55C63E538AA1E458EE4D75BD99595630694E939@domain.hid>
From: "Enric Bel Prim" <e.bel@domain.hid>
Subject: [Xenomai-help] pthread creation with native api
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,
I have some questions regarding pthread and NATIVE API...

I use xenomai 2.4.8 with native API and RTDM services in a linux 2.6.28
lite5200 embedded platform.
My application creates several realtime tasks (rt_task) using native
api, inside a linux environment with other applications.  All worked
fine, till I need to create, from any of this rt_task, some nonrealtime
tasks to do a long and not priority jobs (parse huge xml files, compress
/ uncompress them...).
To do that, I use pthread_create(), to create a non realtime task with
the "default attributes".
I expected that this pthread would share the remaining CPU time with the
other linux applications.  =20
But it seems that this new pthread created has higher priority than any
of the other non-RT linux apps.  The feeling is that the CPU is shared
only between the realtime tasks and this pthread: for instance, one of
the other non-RT apps controls the watchdog, and it resets the system
some seconds after the pthread is created.
If I call pthread_getschedparam inside the pthread I get thread prio =3D
0, and SCHED_OTHER.
I tried using __real_pthread_create as well, and had the same result.

Is correct to use pthread_create to create a new non-RT task from a
rt_task?
Which are the attributes/priority of that pthread? Does it inherit some
of the RT parent "privileges"?

Thanks,
Enric.=20
=20
----------------------------------------- PLEASE NOTE =
-------------------------------------------
This message, along with any attachments, may be confidential or legally =
privileged.=20
It is intended only for the named person(s), who is/are the only =
authorized recipients.
If this message has reached you in error, kindly destroy it without =
review and notify the sender immediately.
Thank you for your help.
ZIV uses virus scanning software but excludes any liability for viruses =
contained in any attachment.
=20
------------------------------------ ROGAMOS LEA ESTE TEXTO =
-------------------------------
Este mensaje y sus anexos pueden contener informaci=F3n confidencial y/o =
con derecho legal.=20
Est=E1 dirigido =FAnicamente a la/s persona/s o entidad/es rese=F1adas =
como =FAnico destinatario autorizado.
Si este mensaje le hubiera llegado por error, por favor elim=EDnelo sin =
revisarlo ni reenviarlo y notif=EDquelo inmediatamente al remitente. =
Gracias por su colaboraci=F3n. =20
ZIV utiliza software antivirus, pero no se hace responsable de los virus =
contenidos en los ficheros anexos.


Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 4 Jul 2007 12:44:50 +0200
Message-ID: <C0662F7F2A8A974FAA140822A2336BF0F17553@domain.hid>
From: "Stolz, Stefan, PGR2" <Stefan.Stolz@domain.hid>
Subject: [Xenomai-help] is rt_task_shadow ok?
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

Hello,

i have a little question about rt_task_shadow(). I'm not sure if it is
ok to use ist like i do in my application.
The basic conditions of my app are:
 - it is a embedded linux (Sysgo ELinOS) with Xenomai 2.0.4=20
   (old but unfortunatly no newer version is available for ELinOS)
 - the app listens on a tcp-port for commands from a client app.
 - one command ist for starting a simulation of some signals on the
parallel-port;=20
   this simulation have to be hard-real-time

at first the tcp-server-part was in a non-rt-app which startet the
simulation-task with the normal xenomai-functions.
While the simulation is running i have to exchange data between the
tcp-server and the rt-task.=20
The Problem is, that things like semaphores and mutexes doesn't work
with nrt-tasks.
now i found the rt_task_shadow-function. So after starting my app i call
this funktion and switch the process into a xenomai task (with the lowes
priority). At the moment everything seems ok; but are there any known
problems with this approach?

Kind regards,

Stefan Stolz


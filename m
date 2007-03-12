Date: Mon, 12 Mar 2007 17:02:06 +0100
Message-Id: <447063209@domain.hid>
MIME-Version: 1.0
From: Jochen Behnke <JK.Behnke@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] App with pthreads using rt_task_shadow locks up
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

I am currently porting software form a windows based control system to Xen=
omai. The application creates 3 realtime tasks which build the core of the=
 control unit. Up to this point everything worked fine. The next milestone=
 of this project is to integrate network communication using sockets and p=
threads with the control system. The implementation of my - let's call it =
"SimpleRPC" -  library uses sockets and pthreads. At runtime this library =
creates at least 3 pthreads (1 that listens for incoming connections, 1 th=
at performs socket I/O per connected client, 1 that executes the requested=
 functions). As the functions, that are called by the workerthread, use xe=
nomai mutexes to synchronize critical sections of code, the workerthread n=
eeds to be a realtime task scheduled by xenomai. So I use rt=5Ftask=5Fshadow, =
to "convert" the pthread into a xenomai realtime task. When this code is e=
xecuted, my application locks up and I have to restart the whole system. W=
hen I remove the rt=5Ftask=5Fshadow call everything is fine, except for the ca=
lls to rt=5Fmutex=5Flock that return an error code because the calling context=
 is not a realtime task.

I am using
Xenomai 2.2.3
Linux Kernel 2.6.17

What's wrong =3F
How can I debug this problem =3F

Any hint is appreciated.


Jochen


P.S.:
Is there an easy way to search the xenomai mail archives =3F At the moment I=
 walk through them more or less manually.




=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Mit der Gruppen-SMS von WEB.DE FreeMail k=F6nnen Sie eine SMS an alle=20
Freunde gleichzeitig schicken: http://freemail.web.de/features/=3Fmc=3D021179





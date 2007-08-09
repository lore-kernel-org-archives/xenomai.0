MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <18106.60807.692746.230882@domain.hid>
Date: Thu, 9 Aug 2007 12:33:43 +0200
In-Reply-To: <000501c7da69$767922e0$c124a986@domain.hid>
References: <mailman.2979.1186650741.22887.xenomai@xenomai.org>
	<000501c7da69$767922e0$c124a986@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] POSIX Skin: Changing scheduling parameters
	of	threads in other processes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?iso-8859-1?Q?Torsten_Kr=F6ger?= <t.kroeger@domain.hid>
Cc: xenomai@xenomai.org

Torsten Kr=F6ger wrote:
 > Hello everybody,
 >=20
 > this is my first email to this list, and I would like to start with a
 > question. I use the posix skin of Xenomai 2.3.1, and I have several
 > processes running, each consisting of several threads. Is there a
 > possibility for a thread A1 running in process A to change the
 > scheduling parameters, in particular the priority, of a thread B1
 > running in process B?
 >=20
 > Regarding the posix specification I cannot find this functionality there
 > and so I guess there is no way doing it with "pthread_setschedparam()".
 > But is there another possibility? =20

No, the only way you could do that is by using an IPC to pass the
request from a process to another. You could use message queues for
that.

--=20


					    Gilles Chanteperdrix.


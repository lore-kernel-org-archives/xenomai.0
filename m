Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] What returns rt_task_self in relation
	tort_task_create
Date: Wed, 22 Nov 2006 13:48:11 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB015D4F9C@is-hdq-exchange.marel.net>
In-Reply-To: <1164200995.5006.280.camel@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
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

Philippe Gerum wrote:
> Use pthread_getspecific() for obtaining back a TLS data previously
> defined by pthread_setspecific(), indexed on a TLS key obtained from
> pthread_key_create(). Warning: AFAICT, only pthread_getspecific()
> refrain from performing any kind of Linux syscall (in the current
> NPTL and older LinuxThreads implementation, that is), thus won't
> migrate your RT task to secondary mode when called. The two others
> could call vanilla kernel services, so you must use them during
> non-critical preliminary init steps of your task.      =20

Does this mean that if you use pthread_getspecific() inside a user-space
application you will not switch to secondary mode ? I was just
abandoning using TLS because I could not imagine how the NPTL's
functionality can be done without a system call. Is this behaviour
something one can rely on in the future ?

Is there something similar like TLS inside the native API ?


Best regards,


Daniel.


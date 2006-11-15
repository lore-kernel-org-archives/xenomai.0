Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] pthread_setname_np
Date: Wed, 15 Nov 2006 15:49:28 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0154F003@domain.hid>
In-Reply-To: <455B29BE.3060805@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:

> You are being dishonest: the function expects a pthread_t argument,
> the only way to get a valid pthread_t value is to create a thread or
> to call pthread_self(). =20

No only a dumb newbie user of the Posix API with a background of
VxWorks.
If I want to create a task in VxWorks with e.g. int taskSpawn() I get
explecitly back a task id, comparable to a pthread_t for POSIX API.
Because it is a simple int (which is in fact not really true, because it
is a pointer in the task control block casted into an int), I know as a
dumb user that I cannot use it somehow before.

With pthreads I did the following:

pthread_t thread;
pthread_attr_t attr;
pthread_attr_init (&attr);
pthread_attr_setname_np(&attr, "newname"); (-->
pthread_set_name_np(thread, "newname");)
pthread_create (&thread, &attr, func, arg);


This did not compile, because only valid in kernel space, so I replaced
pthread_attr_setname_np() with pthread_set_name_np() and let it run. Of
course checking return values could have helped here.

I expected that pthread_t is a normal structure and would only be
modified with pthread_set_name_np() aka the attribute structure with
pthread_attr_setxxx(). I am simply not used to an API that doesn't
provide the possibility to spawn a thread already with the correct name
and rather forces the user to change the name after the thread is
already running ...
A collegue of mine stumbled over the exact same thing. A bit more
"redundancy" in the documentation would probably have opened our eyes,
although it seems according to Google that I am the first mentioning
this problem.

>> Btw. Is there a reason why the call to pthread_attr_setname_np() is
>> limited to kernel space ?
>=20
> It is impossible to implement pthread_attr_setname_np in user-space.
> I think I will remove this call, having different APIs in
> kernel-space and user-space only adds confusion. =20

Just out of curiosity: what are the exact reasons ? I mean: couldn't you
principially pass any information to the Xenomai subsystem at the time
of a pthread_create() ??


Best regards,

Daniel Schnell.


Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Maximum number of realtime tasks
Date: Tue, 31 Oct 2006 11:38:18 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0144D60D@is-hdq-exchange.marel.net>
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

Gilles Chanteperdrix wrote:
>=20
> Pay attention to the stack size of the user-space tasks: the default=20
> of 8 Megabytes will exhaust your RAM rapidly. So, you should either :
> - set the default stack size with ulimit;
> - or set the the stack size of the created threads, but in this case=20
> the main thread will have an 8 Megabytes stack.
>=20
> In order to set the stack size of a thread, use=20
> pthread_attr_setstacksize if using the POSIX skin or the stksize=20
> parameter of rt_task_create if using the native skin.

If I set the stacksize generally via ulimit -s and additionally via the
pthread_attr_setstacksize() how is the precedence of one of these calls
over the other ? Does pthread_attr_setstacksize() "overwrite" the stack
size limitation of ulimit -s ?

Daniel.


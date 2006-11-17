Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] MPC5200 OOPS time
Date: Fri, 17 Nov 2006 19:42:28 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB015D4834@domain.hid>
In-Reply-To: <455DE97D.6020701@domain.hid>
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

Hi,


Gilles Chanteperdrix wrote:
> You should set the threads stack size with pthread_attr_setstacksize
> (as other pthread_attr_set* functions, it should be used on a
> previously initialized pthread_attr_t structure), ulimit -s only set
> the stack size of the main thread, at least on some architectures.  =20

pthread_attr_setstacksize() doesn't work for us. The system still does
allocate the default linux stack size. Whereas ulimit -s sets the stack
size for all created threads correctly.

Can this confirm somebody with an mpc5200B based board (e.g. icecube,
lite5200) ?

> This is probably unrelated to the errors you see, but:
> - passing the pthread_mutex_t by value is not supposed to work; once
> a pthread_mutex_t is initialized with pthread_mutex_init, you should
> pass the address of the very same pthread_mutex_t to other functions
> of the API. =20

Hmm, this is mystique to me. pthread_mutex_t is a structure returned by
value from within MutexCreate(). Passing structures back by value
doesn't do harm to them. Also the pthread_mutex function seem to operate
normally.
=20

Best regards,

Daniel Schnell.


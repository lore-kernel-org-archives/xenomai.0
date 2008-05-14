Message-ID: <2ff1a98a0805140550p754de215l4ee6ea9f20c19e8e@domain.hid>
Date: Wed, 14 May 2008 14:50:37 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <482ADEE6.8080403@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <48299843.7090307@domain.hid>
	<2ff1a98a0805130731o5a78e490s77131ee48ee3b741@domain.hid>
	<482A9E3E.7040608@domain.hid>
	<2ff1a98a0805140157q65ed8014k6725fc7f0b3a8f64@domain.hid>
	<482ADEE6.8080403@domain.hid>
Subject: Re: [Xenomai-help] v2.4.3 bug with system() call (ERRATUM)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Wed, May 14, 2008 at 2:45 PM, St=E9phane ANCELOT <sancelot@domain.hid> wrot=
e:
>
>
>
>  Gilles Chanteperdrix a =E9crit :
>  On Wed, May 14, 2008 at 10:09 AM, St=E9phane ANCELOT <sancelot@domain.hid>
> wrote:
>
>
>  Gilles Chanteperdrix a =E9crit :
>
>  On Tue, May 13, 2008 at 3:31 PM, St=E9phane ANCELOT <sancelot@domain.hid> w=
rote:
>
>
>  Hi,
>  Using the v2.4.3 +kernel 2.6.24.7 I used the system("touch /tmp/xxx_ok")
>  call in a non realtime init context.
>
>  The task is only used to allocate some memory heaps.
>
>  I setted up some memory debugging features in the kernel :
>  CONFIG_DEBUG_KERNEL=3Dy
>  CONFIG_DEBUG_SLAB=3Dy
>  CONFIG_DEBUG_SLAB_LEAK=3Dy
>  CONFIG_DEBUG_BUGVERBOSE=3Dy
>  CONFIG_DEBUG_VM=3Dy
>  CONFIG_FORCED_INLINING=3Dy
>  CONFIG_EARLY_PRINTK=3Dy
>  CONFIG_DEBUG_PAGEALLOC=3Dy
>
>  This was not happening with v2.4.2 although that the kernel debugging
>  flags were not "on"
>
>  It would be nice if you could try the v2.4.2 with debugging options
> on, to know if it is a regression or not.
>
>
>  No time left, going back on v2.4.2. However, I have exactly the same
> problem, if I use the fork() call inside a program.
>
>  Have you tried Jan fix ?
>
>
>  Sorry, for the last post, I tried again the xeno kernel ...which Jan fix=
 to
> use?

That one:
https://mail.gna.org/public/xenomai-help/2008-05/msg00087.html

--=20
 Gilles


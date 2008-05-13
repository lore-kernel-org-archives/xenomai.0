Message-ID: <2ff1a98a0805130731o5a78e490s77131ee48ee3b741@domain.hid>
Date: Tue, 13 May 2008 16:31:34 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <48299843.7090307@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <48299843.7090307@domain.hid>
Subject: Re: [Xenomai-help] v2.4.3 bug with system() call
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

On Tue, May 13, 2008 at 3:31 PM, St=E9phane ANCELOT <sancelot@domain.hid> wrot=
e:
> Hi,
>  Using the v2.4.3 +kernel 2.6.24.7 I used the system("touch /tmp/xxx_ok")
>  call   in a non realtime init context.
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
>   This was not happening with v2.4.2 although that the kernel debugging
>  flags were not "on"

It would be nice if you could try the v2.4.2 with debugging options
on, to know if it is a regression or not.

--=20
 Gilles


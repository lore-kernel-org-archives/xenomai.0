Date: Tue,  3 Oct 2006 09:54:28 +0200
Message-Id: <J6JVAS$C4CF17214301337F8F99C4C608155EE6@domain.hid>
Subject: Re:[Xenomai-help] POSIX skin and dynamic libs
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
From: "gilles\.chanteperdrix" <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "jeff.webb" <jeff.webb@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

---------- Debut du message initial -----------

De     : xenomai-help-bounces@domain.hid
A      : "Xenomai help" xenomai@xenomai.org
Copies : 
Date   : Mon, 02 Oct 2006 18:43:40 -0500
Objet  : [Xenomai-help] POSIX skin and dynamic libs

> I have a main program that dynamically loads shared library
> modules using dlopen().  I would like to create a shared
> library module that is able to spawn a Xenomai RT thread.
>  This seems  like it should be possible, but I get the
> following error when loading the module:
> 
> IOError: /usr/xenomai/lib/libpthread_rt.so.0: undefined symbol:
> __real_pthread_getschedparam
> 
> This seems to be related to the "-Wl,--wrap" linker flags.  Is
> there a way to get this to work?  I don't think recompiling the
> main program is an option, but I can add some code that gets
> executed before the dynamic library is loaded.

The wrapper for __real_pthread_getschedparam is missing in
src/skins/posix/wrappers.c, try adding it.

-- 
                 Gilles Chanteperdrix=0A=0AAcc=E9dez au courrier =E9lectr=
onique de La Poste 
sur www.laposte.net ou sur 3615 LAPOSTENET (0,34=80 TTC /mn) 
1 Giga de stockage gratuit =96 Antispam et antivirus int=E9gr=E9s 
=0A



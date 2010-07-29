MIME-Version: 1.0
Date: Thu, 29 Jul 2010 15:14:25 +0200
Message-ID: <AANLkTinJVMQ3pa07AVeikv3HRyDMxw5HsWNiFC_3OTXG@mail.gmail.com>
From: Jan de Kruyf <jan.de.kruyf@domain.hid>
Content-Type: multipart/alternative; boundary=00c09f9b0bfc6ecc20048c868397
Subject: [Xenomai-help] ARM: missing symbols on building the libraries
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

--00c09f9b0bfc6ecc20048c868397
Content-Type: text/plain; charset=ISO-8859-1

Hallo,
I came across some weird problem, which might or might not be my own doings,
while cross compiling kernel + xenomai.
Although this is all Debian flavoured I have a suspicion it comes from the
xenomai source, so thats why I posted it here first.

kernel 2.6.31-rc3
xenomai git Date:   Mon Jun 28 00:35:30 2010 +0200

toolchain codesourcery-armgcc-2009q1.
DEB_HOST_GNU_TYPE=arm-none-linux-gnueabi  #(cross-compiler prefix)
DEB_BUILD_GNU_TYPE=$(shell dpkg-architecture -qDEB_BUILD_GNU_TYPE)

CONFIG_OPTS = --enable-arm-mach=at91sam926x --enable-arm-eabi
CONFIG_OPTS += --prefix=/usr \
                --includedir=/usr/include/xenomai \
                --mandir=/usr/share/man \
            --with-testdir=/usr/lib/xenomai\
            --enable-arm-tsc


The Debian library package build gives me this output, no matter what
directories I search:

dpkg-shlibdeps: warning: symbol xeno_bind_skin_opt used by
debian/libxenomai1/usr/lib/libvxworks.so.1.0.0 found in none of the
libraries.
dpkg-shlibdeps: warning: symbol xeno_set_current used by
debian/libxenomai1/usr/lib/libvxworks.so.1.0.0 found in none of the
libraries.
dpkg-shlibdeps: warning: symbol xeno_init_current_mode used by
debian/libxenomai1/usr/lib/libvxworks.so.1.0.0 found in none of the
libraries.
dpkg-shlibdeps: warning: symbol __xnsig_dispatch used by
debian/libxenomai1/usr/lib/libvxworks.so.1.0.0 found in none of the
libraries.
dpkg-shlibdeps: warning: symbol xeno_handle_mlock_alert used by
debian/libxenomai1/usr/lib/libvxworks.so.1.0.0 found in none of the
libraries.
dpkg-shlibdeps: warning: symbol xeno_sigshadow_install_once used by
debian/libxenomai1/usr/lib/libvxworks.so.1.0.0 found in none of the
libraries.
dpkg-shlibdeps: warning: symbol xeno_bind_skin_opt used by
debian/libxenomai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.
dpkg-shlibdeps: warning: symbol xeno_set_current used by
debian/libxenomai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.
dpkg-shlibdeps: warning: symbol xeno_map_heap used by
debian/libxenomai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.
dpkg-shlibdeps: warning: symbol xeno_init_current_mode used by
debian/libxenomai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.
dpkg-shlibdeps: warning: symbol __xnsig_dispatch used by
debian/libxenomai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.
dpkg-shlibdeps: warning: symbol xeno_handle_mlock_alert used by
debian/libxenomai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.
dpkg-shlibdeps: warning: symbol xeno_sigshadow_install_once used by
debian/libxenomai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.
dpkg-shlibdeps: warning: symbol xeno_bind_skin_opt used by
debian/libxenomai1/usr/lib/libuitron.so.0.0.0 found in none of the
libraries.
dpkg-shlibdeps: warning: symbol xeno_set_current used by
debian/libxenomai1/usr/lib/libuitron.so.0.0.0 found in none of the
libraries.
dpkg-shlibdeps: warning: symbol xeno_init_current_mode used by
debian/libxenomai1/usr/lib/libuitron.so.0.0.0 found in none of the
libraries.
dpkg-shlibdeps: warning: symbol __xnsig_dispatch used by
debian/libxenomai1/usr/lib/libuitron.so.0.0.0 found in none of the
libraries.
dpkg-shlibdeps: warning: symbol xeno_handle_mlock_alert used by
debian/libxenomai1/usr/lib/libuitron.so.0.0.0 found in none of the
libraries.
dpkg-shlibdeps: . . . . . .

so I concluded that perhaps these symbols  are in the realtime kernel
interface BUT:
the System.Map does NOT show they have been compiled in at all, although the
standard adeos and xenomai patches have been applied
and some of the skins have been enabled in the kernel .config.

Here is the location of most of the symbols in the xenomai.git source (The
OlimexKernel directory is merely the top directory where I keep all that
stuff)

jan@domain.hid$ grep
'xeno_bind_skin_opt' *.h
jan@domain.hid$ grep
'xeno_bind_skin_opt' */*.h
bits/bind.h:xeno_bind_skin_opt(unsigned skin_magic, const char *skin,
bits/bind.h:    int muxid = xeno_bind_skin_opt(skin_magic, skin, module,
sighandler);
jan@domain.hid$ grep
'xeno_set_current' */*.h
bits/current.h:void xeno_set_current(void);
jan@domain.hid$ grep
'xeno_init_current_mode' */*.h
bits/current.h:unsigned long *xeno_init_current_mode(void);
jan@domain.hid$ grep
'__xnsig_dispatch' */*.h
jan@domain.hid$ grep
'__xnsig_dispatch' *.h
syscall.h:int __xnsig_dispatch(struct xnsig *sigs, int cumulated_error, int
last_error);
syscall.h:int __xnsig_dispatch_safe(struct xnsig *sigs, int cumulated_error,
int last_error);
syscall.h:              return __xnsig_dispatch(sigs, cumul, last);
syscall.h:              return __xnsig_dispatch_safe(sigs, cumul, last);
jan@domain.hid$ grep
'xeno_handle_mlock_alert' */*.h
bits/bind.h:void xeno_handle_mlock_alert(int sig, siginfo_t *si, void
*context);
bits/bind.h:    sa.sa_sigaction = xeno_handle_mlock_alert;
jan@domain.hid$ grep
'xeno_sigshadow_install_once' */*.h
bits/sigshadow.h:void xeno_sigshadow_install_once(void);
jan@domain.hid$

Does someone perhaps know where the Kconfig file or the *.c/h file lives
that includes this stuff?


Cheers,

Jan de Kruyf.

--00c09f9b0bfc6ecc20048c868397
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hallo,<br>I came across some weird problem, which might or might not be my =
own doings, while cross compiling kernel + xenomai.<br>Although this is all=
 Debian flavoured I have a suspicion it comes from the xenomai source, so t=
hats why I posted it here first.<br>
<br>kernel 2.6.31-rc3<br>xenomai git Date:=A0=A0 Mon Jun 28 00:35:30 2010 +=
0200<br><br>toolchain codesourcery-armgcc-2009q1.<br>DEB_HOST_GNU_TYPE=3Dar=
m-none-linux-gnueabi=A0 #(cross-compiler prefix)<br>DEB_BUILD_GNU_TYPE=3D$(=
shell dpkg-architecture -qDEB_BUILD_GNU_TYPE)<br>
<br>CONFIG_OPTS =3D --enable-arm-mach=3Dat91sam926x --enable-arm-eabi<br>CO=
NFIG_OPTS +=3D --prefix=3D/usr \<br>=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 --includedir=3D/usr/include/xenomai \<br>=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 --mandir=3D/usr/share/man \<br>=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 --with-testdir=3D/usr/lib/xenomai\<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 --enable-arm-tsc<br><br><br>The Debian librar=
y package build gives me this output, no matter what directories I search:<=
br><br>dpkg-shlibdeps: warning: symbol xeno_bind_skin_opt used by debian/li=
bxenomai1/usr/lib/libvxworks.so.1.0.0 found in none of the libraries.<br>
dpkg-shlibdeps: warning: symbol xeno_set_current used by debian/libxenomai1=
/usr/lib/libvxworks.so.1.0.0 found in none of the libraries.<br>dpkg-shlibd=
eps: warning: symbol xeno_init_current_mode used by debian/libxenomai1/usr/=
lib/libvxworks.so.1.0.0 found in none of the libraries.<br>
dpkg-shlibdeps: warning: symbol __xnsig_dispatch used by debian/libxenomai1=
/usr/lib/libvxworks.so.1.0.0 found in none of the libraries.<br>dpkg-shlibd=
eps: warning: symbol xeno_handle_mlock_alert used by debian/libxenomai1/usr=
/lib/libvxworks.so.1.0.0 found in none of the libraries.<br>
dpkg-shlibdeps: warning: symbol xeno_sigshadow_install_once used by debian/=
libxenomai1/usr/lib/libvxworks.so.1.0.0 found in none of the libraries.<br>=
dpkg-shlibdeps: warning: symbol xeno_bind_skin_opt used by debian/libxenoma=
i1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.<br>
dpkg-shlibdeps: warning: symbol xeno_set_current used by debian/libxenomai1=
/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.<br>dpkg-shlibdeps=
: warning: symbol xeno_map_heap used by debian/libxenomai1/usr/lib/libvrtx.=
so.0.0.0 found in none of the libraries.<br>
dpkg-shlibdeps: warning: symbol xeno_init_current_mode used by debian/libxe=
nomai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.<br>dpkg-shl=
ibdeps: warning: symbol __xnsig_dispatch used by debian/libxenomai1/usr/lib=
/libvrtx.so.0.0.0 found in none of the libraries.<br>
dpkg-shlibdeps: warning: symbol xeno_handle_mlock_alert used by debian/libx=
enomai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.<br>dpkg-sh=
libdeps: warning: symbol xeno_sigshadow_install_once used by debian/libxeno=
mai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.<br>
dpkg-shlibdeps: warning: symbol xeno_bind_skin_opt used by debian/libxenoma=
i1/usr/lib/libuitron.so.0.0.0 found in none of the libraries.<br>dpkg-shlib=
deps: warning: symbol xeno_set_current used by debian/libxenomai1/usr/lib/l=
ibuitron.so.0.0.0 found in none of the libraries.<br>
dpkg-shlibdeps: warning: symbol xeno_init_current_mode used by debian/libxe=
nomai1/usr/lib/libuitron.so.0.0.0 found in none of the libraries.<br>dpkg-s=
hlibdeps: warning: symbol __xnsig_dispatch used by debian/libxenomai1/usr/l=
ib/libuitron.so.0.0.0 found in none of the libraries.<br>
dpkg-shlibdeps: warning: symbol xeno_handle_mlock_alert used by debian/libx=
enomai1/usr/lib/libuitron.so.0.0.0 found in none of the libraries.<br>dpkg-=
shlibdeps: . . . . . .<br><br>so I concluded that perhaps these symbols=A0 =
are in the realtime kernel interface BUT:<br>
the System.Map does NOT show they have been compiled in at all, although th=
e standard adeos and xenomai patches have been applied<br>and some of the s=
kins have been enabled in the kernel .config.<br><br>Here is the location o=
f most of the symbols in the xenomai.git source (The OlimexKernel directory=
 is merely the top directory where I keep all that stuff)<br>
<br>jan@domain.hid$ grep =
&#39;xeno_bind_skin_opt&#39; *.h<br>jan@domain.hid=
nomai/include/asm-generic$ grep &#39;xeno_bind_skin_opt&#39; */*.h<br>bits/=
bind.h:xeno_bind_skin_opt(unsigned skin_magic, const char *skin, <br>
bits/bind.h:=A0=A0=A0 int muxid =3D xeno_bind_skin_opt(skin_magic, skin, mo=
dule, sighandler);<br>jan@domain.hid/=
asm-generic$ grep &#39;xeno_set_current&#39; */*.h<br>bits/current.h:void x=
eno_set_current(void);<br>
jan@domain.hid$ grep &#39=
;xeno_init_current_mode&#39; */*.h<br>bits/current.h:unsigned long *xeno_in=
it_current_mode(void);<br>jan@domain.hid=
ude/asm-generic$ grep &#39;__xnsig_dispatch&#39; */*.h<br>
jan@domain.hid$ grep &#39=
;__xnsig_dispatch&#39; *.h<br>syscall.h:int __xnsig_dispatch(struct xnsig *=
sigs, int cumulated_error, int last_error);<br>syscall.h:int __xnsig_dispat=
ch_safe(struct xnsig *sigs, int cumulated_error, int last_error);<br>
syscall.h:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return __xnsig_dispatch(s=
igs, cumul, last);<br>syscall.h:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret=
urn __xnsig_dispatch_safe(sigs, cumul, last);<br>jan@domain.hid=
rnel2-6-31/xenomai/include/asm-generic$ grep &#39;xeno_handle_mlock_alert&#=
39; */*.h<br>
bits/bind.h:void xeno_handle_mlock_alert(int sig, siginfo_t *si, void *cont=
ext);<br>bits/bind.h:=A0=A0=A0 sa.sa_sigaction =3D xeno_handle_mlock_alert;=
<br>jan@domain.hid$ grep =
&#39;xeno_sigshadow_install_once&#39; */*.h<br>
bits/sigshadow.h:void xeno_sigshadow_install_once(void);<br>jan@domain.hid=
:~/OlimexKernel2-6-31/xenomai/include/asm-generic$ <br><br>Does someone per=
haps know where the Kconfig file or the *.c/h file lives that includes this=
 stuff?<br>
<br><br>Cheers,<br><br>Jan de Kruyf.<br>

--00c09f9b0bfc6ecc20048c868397--


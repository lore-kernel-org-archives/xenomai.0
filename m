Message-ID: <4C518635.3030600@domain.hid>
Date: Thu, 29 Jul 2010 15:46:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinJVMQ3pa07AVeikv3HRyDMxw5HsWNiFC_3OTXG@mail.gmail.com>
In-Reply-To: <AANLkTinJVMQ3pa07AVeikv3HRyDMxw5HsWNiFC_3OTXG@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ARM: missing symbols on building the libraries
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan de Kruyf <jan.de.kruyf@domain.hid>
Cc: xenomai@xenomai.org

Jan de Kruyf wrote:
> The Debian library package build gives me this output, no matter what
> directories I search:
> 
> dpkg-shlibdeps: warning: symbol xeno_bind_skin_opt used by
> debian/libxenomai1/usr/lib/libvxworks.so.1.0.0 found in none of the
> libraries.
> 
> so I concluded that perhaps these symbols  are in the realtime kernel
> interface BUT:

Errr... There is absolutely no way user-space code can be dynamically
linked with kernel functions. The interface between the two is the
system calls interface.

> the System.Map does NOT show they have been compiled in at all, although
> the standard adeos and xenomai patches have been applied
> and some of the skins have been enabled in the kernel .config.
> 
> Here is the location of most of the symbols in the xenomai.git source
> (The OlimexKernel directory is merely the top directory where I keep all
> that stuff)
> Does someone perhaps know where the Kconfig file or the *.c/h file lives
> that includes this stuff?

This is user-space stuff, so it is not related to Kconfig.

As explained in the README.INSTALL file, the sources for the kernel-part
are located in the subdirectories of the ksrc directory, while the
sources for the user-space part are located in the subdirectories of the
src directory.

Anyway, all this comes from the libxenomai library. As witnessed by
people installing and using Xenomai on ARM while following the
installation instructions in README.INSTALL, everything is fine with
Xenomai, your problem is elsewhere.

-- 
					    Gilles.


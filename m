Message-ID: <4AA95F97.6010802@domain.hid>
Date: Thu, 10 Sep 2009 22:20:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BB99A6BA28709744BF22A68E6D7EB51F03248BDB59@domain.hid>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F03248BDB59@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Installation and Makefile Help
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonathan Haws <Jonathan.Haws@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jonathan Haws wrote:
> All,
> 
> I am new to Xenomai, so please bear with me.
> 
> I have a question regarding creating Makefiles for building Xenomai 
> enabled programs.  I would like to simply use "xeno-config" to set my
>  CFLAGS and LDFLAGS settings in the Makefile.
> 
> However, the problem I run into is that my target (AMCC 405EX PPC 
> system) requires that I have the --prefix option set to 
> /usr/local/xenomai.  However, that is not the real path to where the 
> libraries are installed on my host system.  They are at 
> ~/eldk/ppc_4xx/usr/local/xenomai.  I then have a script that will 
> build a ramdisk and pull the libraries from the correct location (if 
> anyone has used the root filesystem builder from Denx that is how I 
> am doing it).
> 
> How can I fix that discrepancy?  I would like to accomplish this the 
> correct way and if that is simply creating a symlink, so be it.

Use DESTDIR, that is what it was made for. The makefiles use it when
running "make install", and xeno-config prepends it to the directories
it returns.

So, in a makefile, you woud do:

XENO_DESTDIR:=~/eldk/ppc_4xx
XENO_CONFIG:=$(XENO_DESTDIR)/usr/local/xenomai/bin/xeno-config
XENO_CPPFLAGS:=$(shell DESTDIR=$(XENO_DESTDIR) $(XENO_CONFIG) --xeno-cflags)
XENO_LIBS:=$(shell DESTDIR=$(XENO_DESTDIR) $(XENO_CONFIG) --xeno-ldflags)

Note that to ease working in a cross-compile embedded environnement
you may want to avoid copying header files, documentation, etc... in
the directory that will be used to generate the root filesystem. In
this case pass a different --prefix and --exec-prefix options to 
xenomai configure script.

-- 
					    Gilles.


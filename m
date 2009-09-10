Message-ID: <4AA96689.3010502@domain.hid>
Date: Thu, 10 Sep 2009 22:50:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BB99A6BA28709744BF22A68E6D7EB51F03248BDB59@domain.hid>
	<4AA95F97.6010802@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F03248BDBCD@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F03248BDBCD@midas.usurf.usu.edu>
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
>> Use DESTDIR, that is what it was made for. The makefiles use it
>> when running "make install", and xeno-config prepends it to the 
>> directories it returns.
>> 
>> So, in a makefile, you woud do:
>> 
>> XENO_DESTDIR:=~/eldk/ppc_4xx 
>> XENO_CONFIG:=$(XENO_DESTDIR)/usr/local/xenomai/bin/xeno-config 
>> XENO_CPPFLAGS:=$(shell DESTDIR=$(XENO_DESTDIR) $(XENO_CONFIG) -- 
>> xeno-cflags) XENO_LIBS:=$(shell DESTDIR=$(XENO_DESTDIR)
>> $(XENO_CONFIG) --xeno- ldflags)
> 
> Ah, that makes sense.  Thanks, Gilles.
> 
> 
>> Note that to ease working in a cross-compile embedded environnement
>>  you may want to avoid copying header files, documentation, etc...
>> in the directory that will be used to generate the root filesystem.
>> In this case pass a different --prefix and --exec-prefix options to
>>  xenomai configure script.
> 
> So, in that case I would do something like the following:
> 
> ./configure --exec-prefix=~/eldk/ppc_4xx/usr/local/xenomai \ 
> --prefix=/usr/local/xenomai --host=ppc-linux
> 
> That would put headers, documentation, and other development files in
> a usable location on the host and the libraries and executables in
> ~/eldk/ppc_4xx.

Well no, unfortunately not. To get things working properly, you have to 
pass ~/eldk/ppc_4xx as the DESTDIR when running "make install". At least
that is the way the makefiles coming from automake are supposed to be 
used.

So, what you would do is rather:
./configure --exec-prefix=/usr/local/xenomai --prefix=/xenomai-host --host=ppc-linux

And then in the script generating the rootfs, prune the 
~/eldk/ppc_4xx/xenomai-host directory.

-- 
					    Gilles.


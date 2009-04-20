From: jeff angielski <jeff@domain.hid>
In-Reply-To: <1240094529.26554.176.camel@domain.hid>
References: <1240088252.31471.6.camel@domain.hid>
	<1240094529.26554.176.camel@domain.hid>
Content-Type: text/plain
Date: Mon, 20 Apr 2009 15:17:02 -0400
Message-Id: <1240255022.8518.27.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Using xeno-config in cross compiling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Sun, 2009-04-19 at 00:42 +0200, Philippe Gerum wrote:
> On Sat, 2009-04-18 at 16:57 -0400, jeff angielski wrote:
> > 
> > What is the proper way to cross compiler a POSIX skin application in a
> > cross compiler development setup?
> > 
> 
> The way you did it is probably ok; but you may want to tell xeno-config
> where to find the staging directory via the DESTDIR variable, so it can
> locate all the host files it needs locally (e.g. posix.wrappers).
> 
> i.e.
> 
> DESTDIR=/srv/nfs/srp-xen /srv/nfs/srp-xen/usr/xenomai/bin/xeno-config
> --posix-cflags ...

This compiles but won't run as-is on the target because it complains
it's missing the pthread_rt library.

# ./readirq-posix
./readirq-posix: error while loading shared libraries:
libpthread_rt.so.1: cannot open shared object file: No such file or
directory

# ldd ./readirq-posix
        linux-vdso32.so.1 =>  (0x00100000)
        libpthread_rt.so.1 => not found
        libpthread.so.0 => /lib/libpthread.so.0 (0x0ff98000)
        librt.so.1 => /lib/librt.so.1 (0x0ff40000)
        libc.so.6 => /lib/libc.so.6 (0x0fda1000)
        /lib/ld.so.1 (0x48000000)


I used LD_LIBRARY_PATH to get it to work but it seems like I must be
missing a step somewhere in the process.

# LD_LIBRARY_PATH=/usr/xenomai/lib ./readirq-posix


Do other people cross compiling for POSIX skins have to do this?

TIA,
Jeff

-- 
Jeff Angielski
The PTR Group
www.theptrgroup.com




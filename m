From: jeff angielski <jeff@domain.hid>
Content-Type: text/plain
Date: Sat, 18 Apr 2009 16:57:32 -0400
Message-Id: <1240088252.31471.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Using xeno-config in cross compiling
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


I am unable to cross compile to any POSIX skin applications, including
the example, because the xeno-config is return that POSIX is not
supported.  However, when I run xeno-config on the target itself, it
returns the necessary posix-cflags and posix-ldflags.

Running it on my powerpc target:
 -bash-3.2# /usr/xenomai/bin/xeno-config --posix-cflags --posix-ldflags
-I/usr/xenomai/include -I/usr/xenomai/include/posix -D_GNU_SOURCE
-D_REENTRANT -D__XENO__
-Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt
-lpthread -lrt

Running it on my i686 build host:
jaa@domain.hid:~$ /srv/nfs/srp-xen/usr/xenomai/bin/xeno-config
--posix-cflags --posix-ldflags
-I/usr/xenomai/include -I/usr/xenomai/include/posix -D_GNU_SOURCE
-D_REENTRANT -D__XENO__
POSIX support is not available


What is the proper way to cross compiler a POSIX skin application in a
cross compiler development setup?



Gory details:
xen: xenomai-2.4.7
kernel: linux 2.6.28.5
arch: powerpc (MPC8544)
cc: ppc_85xxDP (from ELDK)


-- 
Jeff Angielski
The PTR Group
www.theptrgroup.com




MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17474.34228.663482.766745@domain.hid>
Date: Sun, 16 Apr 2006 19:58:12 +0200
Subject: Re: [Xenomai-help] Problems running testsuite
In-Reply-To: <44427E26.6040608@domain.hid>
References: <200604131149.40706.tmarscha@domain.hid>
	<443E9FD2.6070807@domain.hid>
	<200604141342.40129.tmarscha@domain.hid>
	<17471.38482.617361.14216@domain.hid>
	<443FB0BA.5060404@domain.hid> <44427E26.6040608@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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

Philippe Gerum wrote:
 > > Maybe we need a script thats run on the target box, that collects
 > > the needed configuration factors; presumably including:
 > > CPUFLAGS=`grep flags /proc/cpuinfo`
 > > NPTL_AVAIL=`getconf GNU_LIBPTHREAD_VERSION`
 > > 
 > 
 > The problem is that we might not always have the target at hand when 
 > building the user-space support (e.g. LiveCD, deployment distro stuff). 
 > Therefore it could only be some optional helper, but not part of the 
 > regular build process.

Maybe we could modify skins user-space initialization so that they test
whether running NPTL if SEP is enabled ? Here is an example, doing
this in plain C :

https://listman.redhat.com/archives/phil-list/2003-April/msg00036.html

-- 


					    Gilles Chanteperdrix.


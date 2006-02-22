From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17404.35525.600271.352919@domain.hid>
Date: Wed, 22 Feb 2006 17:01:09 +0100
Subject: Re: [Xenomai-help] 2.1-rc3 on ppcEmbedded...mpc5200
In-Reply-To: <43FB416A.6090001@domain.hid>
References: <43FB416A.6090001@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: teo <teo@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

teo wrote:
 > Hello,
 > I'm trying Xenomai latest release on kernel 2.4.25 of ppc_devel for 
 > MPC5200.
 > After patch, I have encountered  this error in kernel linking:
 > 
 > /kernel/xenomai/skins/posix/xeno_posix.o(.text+0xed9c): In function 
 > `close':        
 > /opt/ELDK/ppc_6xx/usr/src/sirLinuxXEN/linuxppc_2.4.25-xenomai/kernel/xenomai/skins/posix/shm.c:262: 
 > multiple definition of `close'
 > arch/ppc/kernel/kernel.o(.text+0x2c30):arch/ppc/kernel/entry.S: first 
 > defined here
 > make: *** [vmlinux] Error 1/
 > 
 > In file misc.S in arch/ppc/kernel there is
 > ...SYSCALL(close)...
 > and it's define close global symbol as in posix/shm.c
 > 
 > Is it possible to chage name of close in shm.c ?

Thanks for reporting, I am afraid we will have to rename "close" using a
macro, the way we did it for sem_init.

-- 


					    Gilles Chanteperdrix.


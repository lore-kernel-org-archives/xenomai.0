MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18012.28254.882249.144005@domain.hid>
Date: Tue, 29 May 2007 20:18:06 +0200
In-Reply-To: <465C6268.1090704@domain.hid>
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
	<465ADB44.2070705@domain.hid> <1180360288.4727.50.camel@domain.hid>
	<7289437c0705290130k627df2f9j2940c509311c75c5@domain.hid>
	<465BE777.7010204@domain.hid>
	<7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid>
	<465C6268.1090704@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] =?iso-8859-15?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Perrine Martignoni wrote:
 > ...
 > > -Wl,--wrap,close -Wl,--wrap,shm_open -Wl,--wrap,shm_unlink -Wl,--wrap,mmap
 > > -Wl,--wrap,munmap -L/usr/xenomai_arm-2.3.1uClibc/lib essai_mutex_rt.o
 > > -lpthread_rt -lpthread -lrt -o essai_mutex_rt
 > 
 > I think to remember the ordering makes a difference here: Try to put
 > essai_mutex_rt.o after the libs. That's also what happens when using the
 > Xenomai provided flags.

Yes, the order matters, but essai_mutex_rt.o should be before the
libraries. Xenomai makefiles pass libraries in the LDADD variable, which
is put at the very end of the compilation command line.

 > 
 > Apropos: Use `<xenomai-installation-path>/xeno-config --posix-ldflags`
 > (also for --posix-cflags) to make your life easier. There is generally
 > no need to maintain all the flags on your own - and it's error-prone.

I thought that what Perrine showed us was the result of running make and
that her makefiles really used xeno-config.

-- 


					    Gilles Chanteperdrix.


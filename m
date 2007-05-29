Message-ID: <465BE777.7010204@domain.hid>
Date: Tue, 29 May 2007 10:42:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>	<465ADB44.2070705@domain.hid>
	<1180360288.4727.50.camel@domain.hid>
	<7289437c0705290130k627df2f9j2940c509311c75c5@domain.hid>
In-Reply-To: <7289437c0705290130k627df2f9j2940c509311c75c5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

Perrine Martignoni wrote:
> I applied the patch xeno-2.3-posix-shm.diff and the installation of
> Xenomai works fine.
> Thanks
>  
> But after when I want to compile an application (who works with glibc),
> I have this error :
>  
> 
> /usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to
> `__wrap_mmap'
> 
> /usr/src/ELDK_arm/usr/../arm/lib/librt.so: undefined reference
> to`__wrap_close'
> 
> /usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to
> `__wrap_munmap'
> 
> collect2: ld returned 1 exit status
> 
> This error appears with any example of code.

Does this happen when compiling Xenomai posix programs, such as
cyclictest or switchtest ?
As usual, please show us an example of code that fails (including the
Makefile).

-- 
                                                 Gilles Chanteperdrix


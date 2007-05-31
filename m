Message-ID: <465EC7C9.1090807@domain.hid>
Date: Thu, 31 May 2007 15:04:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>	<465BE777.7010204@domain.hid>	<7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid>	<465C6268.1090704@domain.hid>	<18012.28254.882249.144005@domain.hid>	<7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid>	<7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid>	<465D664E.3040700@domain.hid>
	<465E8FA8.4030507@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01F54FE7@domain.hid>
	<7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>
In-Reply-To: <7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>
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
>>Perrine, did you happen to configure Xenomai with "configure --host=arm
>>..."? If yes (see config.log), please use "--host=arm-linux". This
>>solved all issues for me.
>>
>>Awaiting your feedback!
>  
> I configure Xenomai with --host=arm.
> I tried to configure like this but it doesn't work :
>  
> ./configure --build=arm-linux --host=arm-linux CC=arm-linux-gcc
> CXX=arm-linux-g++ LD=arm-linux-ld --prefix=/usr/xenomai_arm-2.3.1uClibc/
> --enable-posix-auto-mlockall
> checking build system type... arm-unknown-linux-gnu
> checking host system type... arm-unknown-linux-gnu
> checking for a BSD-compatible install... /usr/bin/install -c
> checking for arm-linux-gcc... arm-linux-gcc
> checking for C compiler default output file name... a.out
> checking whether the C compiler works... configure: error: cannot run C
> compiled programs.
> If you meant to cross compile, use `--host'.
> See `config.log' for more details.
> [root@domain.hid xenomai-2.3.1 ]#

Unless you are actually building on an ARM system, you should either not
set --build (config.guess will then be used to guess the architecture)
or set it to the effective architecture of your platform (something like
i686-linux I presume). If you do not set --build, configure will produce
a warning saying that you should set --build instead of --host, simply
ignore this warning.

-- 
                                                 Gilles Chanteperdrix


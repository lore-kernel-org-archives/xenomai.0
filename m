Message-ID: <4D386922.5080807@domain.hid>
Date: Thu, 20 Jan 2011 17:56:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
	<alpine.DEB.1.10.1101200922440.1211@domain.hid>
	<4D384CC9.2040303@domain.hid>
	<alpine.DEB.1.10.1101201702340.1990@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1101201702340.1990@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org, Pierre.QUELIN@solystic.com

Kolja Waschk wrote:
>> So, could you describe me exactly the procedure you are following wich
>> allows to reproduce this issue?
> 
> 
> My attempt to run cond-torture-posix step by step:
> 
> 1. copy cond-torture-posix as it was built in the blackfin-linux-dist (FDPIC) to target
> 
> /opt/uClinux/blackfin-linux-dist/user/xenomai/build-xenomai-2.5.5.2/src/testsuite/unit/.libs/cond-torture-posix
> 
> 2. first attempt to start cond-torture-posix fails because librt.so.0 was not on my target, so I transferred /opt/uClinux/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib/librt.so.0
> 
> 3. cond-torture-posix standalone passes
> 
> 4. I start cond-torture-posix on the target with "gdbserver :2222 ./cond-torture-posix"
> 
> 5. I start bfin-linux-uclibc-gdb and issue the commands
> 
> file cond-torture-posix
> target remote 10.0.10.9:2222
> break main
> cont

Ok. On my side: I call set solib-absolute-prefix to where the debug
binaries for the target filesystem are. And I call
handle SIG34 nostop noprint pass.

Coud you try and do the same?


-- 
                                                                Gilles.


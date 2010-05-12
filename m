Message-ID: <4BEAA7E5.2060103@domain.hid>
Date: Wed, 12 May 2010 15:06:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <SNT119-W494F38A017E8C5258B4B21B0FB0@domain.hid>
In-Reply-To: <SNT119-W494F38A017E8C5258B4B21B0FB0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai test problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: federico lolli <federicololli@domain.hid>
Cc: xenomai@xenomai.org

federico lolli wrote:
>  Hi all,
> 
> I'm trying to install Xenomai on ARM sam9g20.
> I compiled the kernel with Xenomai patch and create the filesystem with
> buildroot.
> crosscompiling Xenomai with these commands:
> 
> fede@domain.hid$ ./configure
> --host=arm-linux-gnueabi --enable-arm-eabi --enable-arm-mach=at91sam9
> --disable-arm-tsc --enable-static
> make DESTDIR=/home/fede/foxg20/kernel/l/ install
> I copy the file in the arm-filesystem
> but when I try to run / usr / Xenomai / bin
> for example, the file latency
> get:
> ./latency
> -sh: ./latency:not found
> any suggestions?

Could you try compiling with dynamic libraries, to see if
--enable-static could be the issue? Also, you should try running make
DESTDIR=/path/to/buildroot/nfsroot install to install the binaries.

-- 
					    Gilles.


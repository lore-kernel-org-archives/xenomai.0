Message-ID: <4DC430AE.20206@domain.hid>
Date: Fri, 06 May 2011 19:32:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=qj7YfrFvQJPPZQbLjx=QSJqWzng@domain.hid>
In-Reply-To: <BANLkTi=qj7YfrFvQJPPZQbLjx=QSJqWzng@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] user-space support : Inconsistency detected by
 ld.so
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Aurele Traynard <aurele.traynard@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 05/06/2011 05:13 PM, Aurele Traynard wrote:
> hello all,
> 
> I have a problem whith user-space support :
> I compile a program with makefile of Xenomai and when i want to use it this
> apear :
> 
> Inconsistency detected by ld.so: dl-deps.c: 622: _dl_map_object_deps:
> Assertion`nlist > 1' failed!
> 
> compilation process :
> 
> DESTDIR=/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging
> make
> XENO=/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging/usr/xenomai/
> arm-none-linux-gnueabi-gcc
> -I/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging/usr/xenomai/include
> -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__   -lnative
> -L/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging/usr/xenomai/lib
> -lxenomai -lpthread  -O -Xlinker -rpath -Xlinker
> /home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging/usr/xenomai/lib
> playing_led_rt.c   -o playing_led_rt
> playing_led_rt.c: In function 'main':
> playing_led_rt.c:126:2: warning: format '%08X' expects type 'unsigned int',
> but argument 3 has type 'long unsigned int'
> playing_led_rt.c:128:2: warning: format '%08X' expects type 'unsigned int',
> but argument 2 has type 'long unsigned int'
> 
> I have made two programs one with rt_tasks but he don't work, so supress all
> real-time call and it doesn't work again with the same error.
> 
> does anyone have a way to go?
> thanks for reply

This looks like a bug in the context switch routine. How is
CONFIG_IWMMXT in your kernel configuration?


-- 
                                                                Gilles.


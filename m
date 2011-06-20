Message-ID: <4DFEFF7F.3000308@domain.hid>
Date: Mon, 20 Jun 2011 01:06:23 -0700
From: David Wiebe <dwiebe2@domain.hid>
MIME-Version: 1.0
References: <BANLkTikoPvhb1XmycYm=MROT7=BGA8cisg@domain.hid>	<4DFDF79F.1090502@domain.hid>	<BANLkTinVUd-R1cpD+40MGZZckzGhwrqRvw@domain.hid>	<4DFDFD2F.1080506@domain.hid>	<BANLkTimdiUofRrXahOThW5C1RixQ-s5pMQ@mail.gmail.com>	<4DFE038F.202@domain.hid>	<BANLkTi=RiME1P8vvx3imrq39gEmyZOJbDQ@mail.gmail.com>	<4DFE2A71.5060307@domain.hid>	<BANLkTin1O4aZc0fAM2_W=wiaq+6Zy4+48w@domain.hid>	<4DFE8D82.1060903@domain.hid>
	<4DFED482.5050703@domain.hid> <4DFEF367.9000301@domain.hid>
In-Reply-To: <4DFEF367.9000301@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Compiling program with xenomai support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 11-06-20 12:14 AM, Gilles Chanteperdrix wrote:
> On 06/20/2011 07:02 AM, David Wiebe wrote:
>> /home/david/xenomai-2.5.6.test/include/nucleus/types.h:41:32: error:
>> asm/xenomai/system.h: No such file or directory
> Could you show us the arguments you pass to Xenomai "configure" script?
> Normally, the "asm" directory is created by Xenomai install rule.
>
> Posting your test code would also help us try and reproduce this issue.
>
Of course!

<test2.c>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <signal.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/timer.h>

#define TIMESLEEP 1000000000 /* 1 sec */


int main(void)
{
}
<!test2.c>

<The configure script>
./configure --build=i686-pc-linux-gnu --host=arm-none-linux-gnueabi 
--enable-arm-mach=omap3
<!The configure script>

<The make install>
make DESTDIR=/home/david/sdir/ install
<!The make install>

Thanks!

David


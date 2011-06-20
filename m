Message-ID: <4DFED482.5050703@domain.hid>
Date: Sun, 19 Jun 2011 22:02:58 -0700
From: David Wiebe <dwiebe2@domain.hid>
MIME-Version: 1.0
References: <BANLkTikoPvhb1XmycYm=MROT7=BGA8cisg@domain.hid>	<4DFDF79F.1090502@domain.hid>	<BANLkTinVUd-R1cpD+40MGZZckzGhwrqRvw@domain.hid>	<4DFDFD2F.1080506@domain.hid>	<BANLkTimdiUofRrXahOThW5C1RixQ-s5pMQ@mail.gmail.com>	<4DFE038F.202@domain.hid>	<BANLkTi=RiME1P8vvx3imrq39gEmyZOJbDQ@mail.gmail.com>	<4DFE2A71.5060307@domain.hid>	<BANLkTin1O4aZc0fAM2_W=wiaq+6Zy4+48w@domain.hid>
	<4DFE8D82.1060903@domain.hid>
In-Reply-To: <4DFE8D82.1060903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Compiling program with xenomai support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I'm having a bit of trouble compiling a my test program and was 
wondering if anyone could shed a bit of light on my troubles. I'm using 
code sourcery as my cross compiler.
<START>
arm-none-linux-gnueabi-gcc test2.c -o test2 -I 
/home/david/xenomai-2.5.6.test/include/

In file included from 
/home/david/xenomai-2.5.6.test/include/nucleus/thread.h:25,
                  from 
/home/david/xenomai-2.5.6.test/include/nucleus/sched.h:31,
                  from 
/home/david/xenomai-2.5.6.test/include/native/task.h:25,
                  from test2.c:11:
/home/david/xenomai-2.5.6.test/include/nucleus/types.h:41:32: error: 
asm/xenomai/system.h: No such file or directory
In file included from 
/home/david/xenomai-2.5.6.test/include/nucleus/thread.h:25,
                  from 
/home/david/xenomai-2.5.6.test/include/nucleus/sched.h:31,
                  from 
/home/david/xenomai-2.5.6.test/include/native/task.h:25,
                  from test2.c:11:
/home/david/xenomai-2.5.6.test/include/nucleus/types.h:103: error: 
expected '=', ',', ';', 'asm' or '__attribute__' before 'xnflags_t'
<END>

I cannot find a directory in any of the relevant working directories 
with the pathnames the errors mention.

Thanks,

David


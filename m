MIME-Version: 1.0
In-Reply-To: <5697D9DB.6070909@xenomai.org>
References: <CA+CJOCxoqmA1r0sGb_LwqvsXPzMG485YqUmR83hsfT2mTD6xnQ@mail.gmail.com>
 <5697D9DB.6070909@xenomai.org>
From: Nicolas SCHURANDO <schurann@ext.essilor.com>
Date: Fri, 15 Jan 2016 10:57:21 +0100
Message-ID: <CA+CJOCyPzwWEQScYL=hjzntHxGFq_oF+qen8WF+LEdZWoDAtnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] VxWorks API on Xenomai 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi Philippe,

Thank your for your answer. I have read the manual page entitled
"Application setup and init", and in particular the part about manual vs
automatic bootstrap, and I have tried to follow the instructions to the
letter.

Cross GCC Compiler command is :

> arm-linux-gnueabihf-gcc -D_GNU_SOURCE -D_REENTRANT -D__COBALT__
> -ID:\Gcc\Raspberry-4.9.2-Rpi2Test\arm-linux-gnueabihf\sysroot\usr\xenomai\include\cobalt
> -ID:\Gcc\Raspberry-4.9.2-Rpi2Test\arm-linux-gnueabihf\sysroot\usr\xenomai\include
> -ID:\Gcc\Raspberry-4.9.2-Rpi2Test\arm-linux-gnueabihf\sysroot\usr\xenomai\include\vxworks
> -O0 -g3 -Wall -c -fmessage-length=0 -mcpu=cortex-a7 -mfpu=neon-vfpv4
> -mfloat-abi=hard -MMD -MP -MF"main.d" -MT"main.d" -o "main.o" "../main.c"


Cross GCC Linker command is :

> arm-linux-gnueabihf-gcc -L../libs
> D:\Gcc\Raspberry-4.9.2-Rpi2Test\arm-linux-gnueabihf\sysroot\usr\xenomai\lib\xenomai\bootstrap.o
> -Wl,--wrap=main
> -Wl,--dynamic-list=D:\Gcc\Raspberry-4.9.2-Rpi2Test\arm-linux-gnueabihf\sysroot\usr\xenomai\lib\dynlist.ld
> -o "rpi-test-bug-watchdog"  ./main.o   -lvxworks -lcopperplate -lcobalt
> -lpthread -lrt


And if I try to add an explicit call to xenomai_init at the very beginning
of my main, here is what happens :

>    0"001.000| WARNING: [main] duplicate call to xenomai_init() ignored
>    0"001.618| WARNING: [main] (xeno-config --no-auto-init disables
> implicit call)


What could I be missing ?

Cheers,

Nicolas

2016-01-14 18:24 GMT+01:00 Philippe Gerum <rpm@xenomai.org>:

> On 01/14/2016 10:22 AM, Nicolas SCHURANDO wrote:
> > Hello everyone,
> >
> > In an attempt to migrate from Xenomai 2.6.4 on a Raspberry Pi 1 to
> Xenomai
> > 3.0.1 on a Raspberry Pi 2, I get an error when trying to spawn a VxWorks
> > task in a fairly simple test program. Here is the output :
> >
> >    0"000.064| WARNING: [main] Xenomai compiled with full debug enabled,
> >>                               very high latencies expected
> >> [--enable-debug=full]
> >>  [i] [main] Hello, launching root task ...
> >>  200"747.521| BUG in wind_task_normalize_priority():
> >
> >
> > The corresponding code is :
> >
> > int main(int argc, char *argv[]) {
> >
> >
> >> /* Hello world */
> >> printf(" [i] [%s] Hello, launching root task ...\r\n", __FUNCTION__);
> >
> >
> >> /* Spawn root task */
> >> taskSpawn("root_task", 100, 0, 16 * 1024, (FUNCPTR) &root_task, 0, 0, 0,
> >> 0, 0, 0, 0, 0, 0, 0);
> >
> >
> >> [...]
> >
> >
> >> }
> >
> >
> > I've tracked down the problem to threadobj_high_prio being equal to 0,
> > hence the following function expecting priorities from -1 to 0. I however
> > have no idea where threadobj_high_prio gets its value from.
> >
>
> Your application is not initializing properly, the Xenomai libs are not
> bootstrapped. There are detailed explanations about the init flow here:
> http://xenomai.org/2015/05/application-setup-and-init/
>
> --
> Philippe.
>

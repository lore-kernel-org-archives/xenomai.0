MIME-Version: 1.0
In-Reply-To: <569CD2BB.7000405@xenomai.org>
References: <CA+CJOCxoqmA1r0sGb_LwqvsXPzMG485YqUmR83hsfT2mTD6xnQ@mail.gmail.com>
 <5697D9DB.6070909@xenomai.org>
 <CA+CJOCyPzwWEQScYL=hjzntHxGFq_oF+qen8WF+LEdZWoDAtnQ@mail.gmail.com>
 <569CD2BB.7000405@xenomai.org>
From: Nicolas SCHURANDO <schurann@ext.essilor.com>
Date: Mon, 18 Jan 2016 13:34:32 +0100
Message-ID: <CA+CJOCw1MVqfB8524L3+MXAtfp=UDHP_=1YnDJorJOYb4zdBSQ@mail.gmail.com>
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

In your previous message you suggested that something might be wrong with
the way the application is initialized. And my message was an attempt at
further describing what I had already done.

Oh, I see. I suppose the tense of my message was misleading. I meant that I
had already read the documentation prior to reaching out to you, and the
compiler and linker commands above are the one I had already used.

Are you confirming that the init seems to happen fine ? And if so, what
could explain the error I get when trying to spawn the VxWorks task ?

Regards

2016-01-18 12:55 GMT+01:00 Philippe Gerum <rpm@xenomai.org>:

> On 01/15/2016 10:57 AM, Nicolas SCHURANDO wrote:
> > Hi Philippe,
> >
> > Thank your for your answer. I have read the manual page entitled
> > "Application setup and init", and in particular the part about manual vs
> > automatic bootstrap, and I have tried to follow the instructions to the
> > letter.
> >
> > Cross GCC Compiler command is :
> >
> >     arm-linux-gnueabihf-gcc -D_GNU_SOURCE -D_REENTRANT -D__COBALT__
> >
>  -ID:\Gcc\Raspberry-4.9.2-Rpi2Test\arm-linux-gnueabihf\sysroot\usr\xenomai\include\cobalt
> >
>  -ID:\Gcc\Raspberry-4.9.2-Rpi2Test\arm-linux-gnueabihf\sysroot\usr\xenomai\include
> >
>  -ID:\Gcc\Raspberry-4.9.2-Rpi2Test\arm-linux-gnueabihf\sysroot\usr\xenomai\include\vxworks
> >     -O0 -g3 -Wall -c -fmessage-length=0 -mcpu=cortex-a7 -mfpu=neon-vfpv4
> >     -mfloat-abi=hard -MMD -MP -MF"main.d" -MT"main.d" -o "main.o"
> >     "../main.c"
> >
> >
> > Cross GCC Linker command is :
> >
> >     arm-linux-gnueabihf-gcc -L../libs
> >
>  D:\Gcc\Raspberry-4.9.2-Rpi2Test\arm-linux-gnueabihf\sysroot\usr\xenomai\lib\xenomai\bootstrap.o
> >     -Wl,--wrap=main
> >
>  -Wl,--dynamic-list=D:\Gcc\Raspberry-4.9.2-Rpi2Test\arm-linux-gnueabihf\sysroot\usr\xenomai\lib\dynlist.ld
> >     -o "rpi-test-bug-watchdog"  ./main.o   -lvxworks -lcopperplate
> >     -lcobalt -lpthread -lrt
> >
> >
> > And if I try to add an explicit call to xenomai_init at the very
> > beginning of my main, here is what happens :
> >
> >        0"001.000| WARNING: [main] duplicate call to xenomai_init()
> ignored
> >        0"001.618| WARNING: [main] (xeno-config --no-auto-init disables
> >     implicit call)
> >
> >
> > What could I be missing ?
>
> I don't understand your question. What is wrong with this output?
>
> --
> Philippe.
>

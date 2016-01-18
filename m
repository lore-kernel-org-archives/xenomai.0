References: <CA+CJOCxoqmA1r0sGb_LwqvsXPzMG485YqUmR83hsfT2mTD6xnQ@mail.gmail.com>
 <5697D9DB.6070909@xenomai.org>
 <CA+CJOCyPzwWEQScYL=hjzntHxGFq_oF+qen8WF+LEdZWoDAtnQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <569CD2BB.7000405@xenomai.org>
Date: Mon, 18 Jan 2016 12:55:39 +0100
MIME-Version: 1.0
In-Reply-To: <CA+CJOCyPzwWEQScYL=hjzntHxGFq_oF+qen8WF+LEdZWoDAtnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] VxWorks API on Xenomai 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nicolas SCHURANDO <schurann@ext.essilor.com>
Cc: xenomai@xenomai.org

On 01/15/2016 10:57 AM, Nicolas SCHURANDO wrote:
> Hi Philippe,
> 
> Thank your for your answer. I have read the manual page entitled
> "Application setup and init", and in particular the part about manual vs
> automatic bootstrap, and I have tried to follow the instructions to the
> letter.
> 
> Cross GCC Compiler command is :
> 
>     arm-linux-gnueabihf-gcc -D_GNU_SOURCE -D_REENTRANT -D__COBALT__
>     -ID:\Gcc\Raspberry-4.9.2-Rpi2Test\arm-linux-gnueabihf\sysroot\usr\xenomai\include\cobalt
>     -ID:\Gcc\Raspberry-4.9.2-Rpi2Test\arm-linux-gnueabihf\sysroot\usr\xenomai\include
>     -ID:\Gcc\Raspberry-4.9.2-Rpi2Test\arm-linux-gnueabihf\sysroot\usr\xenomai\include\vxworks
>     -O0 -g3 -Wall -c -fmessage-length=0 -mcpu=cortex-a7 -mfpu=neon-vfpv4
>     -mfloat-abi=hard -MMD -MP -MF"main.d" -MT"main.d" -o "main.o"
>     "../main.c"
> 
> 
> Cross GCC Linker command is :
> 
>     arm-linux-gnueabihf-gcc -L../libs
>     D:\Gcc\Raspberry-4.9.2-Rpi2Test\arm-linux-gnueabihf\sysroot\usr\xenomai\lib\xenomai\bootstrap.o
>     -Wl,--wrap=main
>     -Wl,--dynamic-list=D:\Gcc\Raspberry-4.9.2-Rpi2Test\arm-linux-gnueabihf\sysroot\usr\xenomai\lib\dynlist.ld
>     -o "rpi-test-bug-watchdog"  ./main.o   -lvxworks -lcopperplate
>     -lcobalt -lpthread -lrt
> 
> 
> And if I try to add an explicit call to xenomai_init at the very
> beginning of my main, here is what happens :
> 
>        0"001.000| WARNING: [main] duplicate call to xenomai_init() ignored
>        0"001.618| WARNING: [main] (xeno-config --no-auto-init disables
>     implicit call)
> 
> 
> What could I be missing ?

I don't understand your question. What is wrong with this output?

-- 
Philippe.


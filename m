Message-ID: <c96dc71af67fe20655fa9785b52707dc.squirrel@www.xenomai.org>
In-Reply-To: <CAOiXNkA8u2TjB7FXoJh7opxasgCvnuFkuqOEPZ=tCMz-f-HMpQ@mail.gmail.com>
References: <CAOiXNkCw3e4mK7XeNif2MM5Ub2__xK8UKxaPNRzzMQUbWdhYRg@mail.gmail.com>
	<ff881ad96344018ff2cbf9f8211d7603.squirrel@www.xenomai.org>
	<CAOiXNkBMKNbXOAThav8L9esyRMLBHPk7uFg5fRPhifR_Sg4rXA@mail.gmail.com>
	<9d3ef55df641c8657ce09c6f6e023e4a.squirrel@www.xenomai.org>
	<CAOiXNkA8u2TjB7FXoJh7opxasgCvnuFkuqOEPZ=tCMz-f-HMpQ@mail.gmail.com>
Date: Sat, 3 Nov 2012 15:08:20 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] rt_task_create fails when running over ssh
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andrey Nechypurenko <andreynech@googlemail.com>
Cc: xenomai@xenomai.org


Andrey Nechypurenko wrote:
>> Ok, but there is no code in xenomai which accesses or relies on the
>> console
>> could you try to run the latency test from the ssh console to see if you
>> get the same issue?
>
> xeno-test works just fine. So I assume that it is related to how I am
> compiling the example. I've tried trivial-periodic.c using the
> following command to compile:
>
> ARCH=arm CROSS_COMPILE=arm-angstrom-linux-gnueabi- CFLAGS="
> -march=armv7-a -fno-tree-vectorize -mthumb-interwork
> -mfloat-abi=softfp -mfpu=neon -mtune=cortex-a8 " LOCALVERSION=""
> arm-angstrom-linux-gnueabi-gcc
> -I/home/bbcross/rootfs/usr/include/xenomai/ -D_GNU_SOURCE -D_REENTRANT
> -D__XENO__ -L/home/bbcross/rootfs/usr/lib -lxenomai -lnative
> trivial-periodic.c -o trivial-periodic

If your compiler compiles for thumb by default, please add -marm on the
command line.

>
> The resulting file runs as expected from the serial console, but
> rt_task_create() fails with the same -EPERM error if running over ssh
> as root. Do you see anything wrong with the command line above?

Could you try to run the latency test without xeno-test ?

-- 
                    Gilles.



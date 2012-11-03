MIME-Version: 1.0
In-Reply-To: <2b4941d6b09c5560d4074bc644ded41d.squirrel@www.xenomai.org>
References: <CAOiXNkCw3e4mK7XeNif2MM5Ub2__xK8UKxaPNRzzMQUbWdhYRg@mail.gmail.com>
	<ff881ad96344018ff2cbf9f8211d7603.squirrel@www.xenomai.org>
	<CAOiXNkBMKNbXOAThav8L9esyRMLBHPk7uFg5fRPhifR_Sg4rXA@mail.gmail.com>
	<9d3ef55df641c8657ce09c6f6e023e4a.squirrel@www.xenomai.org>
	<CAOiXNkA8u2TjB7FXoJh7opxasgCvnuFkuqOEPZ=tCMz-f-HMpQ@mail.gmail.com>
	<2b4941d6b09c5560d4074bc644ded41d.squirrel@www.xenomai.org>
Date: Sat, 3 Nov 2012 19:42:40 +0100
Message-ID: <CAOiXNkC=C6A=Mfhqx2rjg61D9UaOB55bnm-n5mOArsmpXdU-sg@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] rt_task_create fails when running over ssh
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 3 November 2012 15:09, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> Andrey Nechypurenko wrote:
>>> Ok, but there is no code in xenomai which accesses or relies on the
>>> console
>>> could you try to run the latency test from the ssh console to see if you
>>> get the same issue?
>>
>> xeno-test works just fine. So I assume that it is related to how I am
>> compiling the example. I've tried trivial-periodic.c using the
>> following command to compile:
>>
>> ARCH=arm CROSS_COMPILE=arm-angstrom-linux-gnueabi- CFLAGS="
>> -march=armv7-a -fno-tree-vectorize -mthumb-interwork
>> -mfloat-abi=softfp -mfpu=neon -mtune=cortex-a8 " LOCALVERSION=""
>> arm-angstrom-linux-gnueabi-gcc
>> -I/home/bbcross/rootfs/usr/include/xenomai/ -D_GNU_SOURCE -D_REENTRANT
>> -D__XENO__ -L/home/bbcross/rootfs/usr/lib -lxenomai -lnative
>> trivial-periodic.c -o trivial-periodic
>

> Could you try to run the latency test without xeno-test ?

Seams like it does not work in the similar way:

# latency -t 0
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
latency: failed to create latency task, code -1
warming up...

and then it exits. -t 1 and -t 2 works fine.

> It should be -lnative -lxenomai

Changing to -lnative -lxenomai does not help

> please use the xeno-config to obtain the flags, do not hardcode them.

I am cross-compiling and I did not figured out yet how to convince
xeno-config to pick right include and library directories. It generats
-I/usr/include and -L/usr/lib which is not where actual libraries for
cross-compilation are.

Thank you,
Andrey.


Message-ID: <4FA95A88.40801@domain.hid>
Date: Tue, 08 May 2012 19:40:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAJ7NaH-mLaPVMGJS9cUM3XwAGay_SwygXBmK7VZQMoYcO1=EaA@mail.gmail.com>	<4FA93CA8.3040305@domain.hid>	<CAJ7NaH_V9WpcAJnjcHXNVOc8UZGVfZxQ7zLkQSvW68J4y+nCEA@mail.gmail.com>	<4FA95514.40407@domain.hid>
	<CAJ7NaH8L5y7qdj2Gg7taM+PFuU4A+tShPb5eNRypxGYqQqpzTg@domain.hid>
In-Reply-To: <CAJ7NaH8L5y7qdj2Gg7taM+PFuU4A+tShPb5eNRypxGYqQqpzTg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Userland-compile error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vikram Dhillon <dhillonv10@domain.hid>
Cc: xenomai@xenomai.org

On 05/08/2012 07:34 PM, Vikram Dhillon wrote:
> On Tue, May 8, 2012 at 1:17 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 05/08/2012 06:23 PM, Vikram Dhillon wrote:
>>> Hello Gilles,
>>>
>>> On Tue, May 8, 2012 at 11:32 AM, Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>> =================================================================================================
>>>>> root@domain.hid# make
>>>>> XENO=/usr/xenomai/ KSRC=/usr/src/linux-2.6.38.8-xenomai/
>>>>> --xeno-cflags is deprecated, use --skin=name --cflags instead
>>>>> --xeno-ldflags is deprecated, use --skin=name --ldflags instead
>>>>> gcc -DCONSUMER -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall
>>>>> -Werror-implicit-function-declaration -pipe -D__XENO__
>>>>> -I/usr/xenomai/include/posix    -Wl,@/usr/xenomai/lib/posix.wrappers
>>>>> -L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt   -Xlinker
>>>>> -rpath -Xlinker /usr/xenomai/lib  satch.c   -o satch
>>>>> /usr/bin/ld: /tmp/ccLV0g8I.o: undefined reference to symbol
>>>>> 'pthread_cancel@domain.hid'
>>>>> /usr/bin/ld: note: 'pthread_cancel@domain.hid' is defined in DSO
>>>>> /lib/i386-linux-gnu/libpthread.so.0 so try adding it to the linker
>>>>> command line
>>>>> /lib/i386-linux-gnu/libpthread.so.0: could not read symbols: Invalid operation
>>>>> collect2: ld returned 1 exit status
>>>>> make: *** [satch] Error 1
>>>>> =================================================================================================
>>>>
>>>> This is a strange error, are you sure you are not mixing a 64 bits
>>>> toolchain with 32 bits libraries? Did xenomai compilation run correctly
>>>> otherwise? Do xenomai tests run, such as latency for instance?
>>>>
>>>
>>>
>>> Yes, the compile and latency tests actually work just fine, I can
>>> execute them, the error occurs when I try to compile a program from
>>> the examples or something that I wrote. Don't worry about the second
>>> error, that was just to demonstrate that after removing lpthread from
>>> compile switches, the program compiles.
>>
>> You do not answer all my questions. What machine are you running? Is it
>> an x86_64 or a 32 bits machine?
>>
>>  I'm using Ubuntu 12.04 if that
>>> provides any help, the debian package xeno-config also gives that
>>> deprecated error so that may just be a problem with the debian
>>> package.
>>
>> If you install xenomai from sources, you should not install debian
>> package. You will have conflict between the two.
>>
>> --
>>                                                                Gilles.
> 
> I have a 32-bit machine. Even after removing the debian package for
> xeno-config, I have the same error.

Things you can try:
- try and compile a simple example not using xenomai, calling
pthread_cancel and linking it with -lpthread, passing -Wl,-t on gcc
command line to see what libpthread.so is used.
- when you compile xenomai, look at how for instance cyclictest is
compiled, and see if the flags used to compile your examples are the same.

-- 
                                                                Gilles.


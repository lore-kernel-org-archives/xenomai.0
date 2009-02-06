Message-ID: <498C4777.8050801@domain.hid>
Date: Fri, 06 Feb 2009 15:21:43 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4B3F8896E1733D4787DDB0EA1C7FF91F704347@domain.hid>
	<498C0EBE.5000004@domain.hid>
	<4B3F8896E1733D4787DDB0EA1C7FF91F70443C@ukmail.uk.wirelessworld.airvananet.com>
In-Reply-To: <4B3F8896E1733D4787DDB0EA1C7FF91F70443C@ukmail.uk.wirelessworld.airvananet.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] lib order fails for xeno-config --posix-ldflags
 on	Blackfin
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mike McTernan <mmcternan@domain.hid>
Cc: xenomai@xenomai.org

Mike McTernan wrote:
> Philippe Gerum wrote:
>> Mike McTernan wrote:
>>> Hi,
>>>


> 
> I think you are using ELF, so maybe you don't see the problem - the
> dynamic linker maybe patching up the internal pthread references?  I'm
> using FLAT, which is essentially a static link, so everything has to be
> fully resolved.

Yes, this is where FLAT is biting you. All refs have to be resolved, so the
linker tries to pick whatever it needs at link time.

> 
> While I'm not familiar with the internals of Xenomai, I'd have thought
> that intercepting the internal call would be inefficient, but not
> harmful.  Presumably we end up in the normal pthread lib because the
> calling thread has no Xenomai context.  When the wrapper is called from
> pthread internally, it should always find there is no Xenomai-thread
> context for the caller and hence go back into the normal pthread lib.
> FWIW the compiled test app runs and produces the expected behaviour,
> although is too trivial to be a thorough test.  
> 

An internal uclibc call to grab e.g. a regular mutex from a Xenomai thread would
likely be an issue though.

>> Here is a trivial Makefile I have just used to produce an executable
>> against 2008-r1.5-rc3 and 2.4.1, without any problem. Obviously this 
>> also depends on the references dragged in by your example code; mine
>> was pulling condvar, mutex and thread support through the common 
>> pthread_* calls. If this simple Makefile does not work with a properly
> 
>> built Xenomai userland support, I'd be interested to see your example 
>> code. TIA,
>>
>> X := /usr/xenomai/blackfin
>> CFLAGS := $(shell $(X)/bin/xeno-config --posix-cflags)
>> LDFLAGS := $(shell $(X)/bin/xeno-config --posix-ldflags)
>> CC :=  $(shell $(X)/bin/xeno-config --cc)
>>
>> all: hello
>>
>> hello: hello.c
>> 	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
>>
>> clean:
>> 	$(RM) hello
>>
> 
> Unfortunately this does not link either (note I added -Wl,-elf2flt).
> Here's the program I am trying to compile, the compile output, and the
> xeno-config output:
> 

This is all due to the FLAT mode. So I guess your next option is two-stage
linking in you don't want to rely on shared fdpic libs.

> #include <stdio.h>
> #include <sys/mman.h>
> #include <pthread.h>
> 

-- 
Philippe.


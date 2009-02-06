Message-ID: <498C61B4.8040806@domain.hid>
Date: Fri, 06 Feb 2009 17:13:40 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4B3F8896E1733D4787DDB0EA1C7FF91F704347@domain.hid>
	<498C0EBE.5000004@domain.hid>
	<4B3F8896E1733D4787DDB0EA1C7FF91F70443C@ukmail.uk.wirelessworld.airvananet.com>
	<498C4777.8050801@domain.hid>
	<4B3F8896E1733D4787DDB0EA1C7FF91F7044CD@ukmail.uk.wirelessworld.airvananet.com>
In-Reply-To: <4B3F8896E1733D4787DDB0EA1C7FF91F7044CD@ukmail.uk.wirelessworld.airvananet.com>
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
>>> Philippe Gerum wrote:
>>>> Mike McTernan wrote:
>>>>> Hi,
>>>>>
>>> I think you are using ELF, so maybe you don't see the problem - the
>>> dynamic linker maybe patching up the internal pthread references?
> I'm
>>> using FLAT, which is essentially a static link, so everything has to
> be
>>> fully resolved.
>> Yes, this is where FLAT is biting you. All refs have to be resolved,
> so
>> the linker tries to pick whatever it needs at link time.
> <snip> 
>> This is all due to the FLAT mode. So I guess your next option is
> two-stage
>> linking in you don't want to rely on shared fdpic libs.
> 
> Unfortunately moving away from ZFLAT isn't trivial for us and is an
> unlikely step.
> 
> I think Xenomai should support FLAT though, it's just this link problem,
> right?
>

Yes, Xenomai does not care about the underlying binary format. It is just a
convenience for us to follow the default one uClinux uses on the Blackfin.

> Unless you have some hints as to how the two-stage link is done, I'm
> going to go and try to get this working and report back later.
> 

I was thinking about something along these lines (you probably need the flat
directive to be passed to the linker as well); totally untested, but the idea is
illustrated:

X=/usr/xenomai
CFLAGS= $(shell $(X)/bin/xeno-config --posix-cflags) -g
WRAPPERS := $(X)/lib/posix.wrappers
LDFLAGS_1 = -Bstatic -L$(X)/lib @$(WRAPPERS)
LDFLAGS_2 = -static -L$(X)/lib -lpthread -lrt
CC = $(shell $(X)/bin/xeno-config --cc)
LD = $(shell $(CC) --print-prog-name=ld)

all: hello

hello: hello-stage1.o
	$(CC) -o $@ $< $(LDFLAGS_2)

hello-stage1.o: hello.o $(X)/lib/libpthread_rt.a
	$(LD) -r -o $@ $^ $(LDFLAGS_1)

hello.o: hello.c
	$(CC) -c $< $(CFLAGS)

clean:
	rm -f *.o hello

> Regards,
> 
> Mike
> 


-- 
Philippe.


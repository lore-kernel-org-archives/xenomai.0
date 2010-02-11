Message-ID: <4B73E421.3050708@domain.hid>
Date: Thu, 11 Feb 2010 12:04:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1NfBdX-0001ga-4b@domain.hid>
	<4B72A7E2.5020001@domain.hid>	<4B72A9DA.1090104@domain.hid>
	<4B730A04.9040908@domain.hid> <4B731608.6010803@domain.hid>
	<4B73180C.6070301@domain.hid> <4B73207C.6020400@domain.hid>
	<4B73218A.9080306@domain.hid> <4B7323D5.1040804@domain.hid>
	<4B732487.50103@domain.hid> <4B732679.4030306@domain.hid>
	<4B73278F.9050603@domain.hid> <4B73C214.3010107@domain.hid>
	<4B73C421.1020200@domain.hid> <4B73CFD9.6010904@domain.hid>
	<4B73D202.5050004@domain.hid> <4B73DDC9.2020906@domain.hid>
In-Reply-To: <4B73DDC9.2020906@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : Make
 xnarch_init_timeconv an uninlined weak function
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
>>>>> BTW, what speaks against making it a dynamic library?
>>>> Complications. Currently the way of linking a native application is to do:
>>>>
>>>> `xeno-config --ldflags` -lnative
>>>>
>>>> Since when linking, the order matter, we can not hide this new library
>>>> in xeno-config --ldflags, so we would have to turn this into:
>>>>
>>>> `xeno-config --ldflags` -lnative -lxeno-common
>>>>
>>>> i.e. breaking user way of building applications. I do not think the gain
>>>> is worth the trouble: linking against only one xenomai library looks to
>>>> me like the most common case.
>>> What would break when swapping -lnative and -xeno-common arbitrarily?
>> If you are linking with static libraries (which is the case that
>> matters), the linker would skip all objects from xeno-common completely
>> since none of their symbols are required, then fail after libnative
>> because of missing symbols (defined in libxeno_common).
> 
> OK. But I this is a custom scenario and naturally requires careful
> library ordering by the user anyway. For us the rule is simple: put
> front-end libs to the front, push the xeno LDFLAGS to the end.

It does not fly either, the -L/usr/xenomai/lib is in the LDFLAGS, and
must be put before -lnative.

It would be nice to to add a --skin option to the xeno-config script,
which handles that. But again, we break the user interface.

that is:
xeno-config --skin=native --ldflags
would spit:
-L/usr/xenomai/lib -lnative -lxeno-common -lpthread -lrt

> 
> BTW, if you link via "`xeno-config --xeno-ldflags` -lnative --static",
> things break already today (as pthread is processed before native).
> Adding -lxeno_common to the output of xeno-config would not change the
> situation.

I guess it works because people usually use some pthread symbols in
their program already.

> 
>>> There is a _lot_ of cleanup potential. E.g. all that redundant __real
>>> wrappers are good candidates for libxeno-common.
>> Thanks to the wrap-link.sh script, the __real wrappers are no longer
>> required. Besides, they are only needed for the posix skin, so there is
>> no need to put them in libxeno-common. This is something which needs to
>> be fixed too.
> 
> wrap-link.sh is a convenience script, I don't think we could make its
> use mandatory. So every skin that uses wrapped symbols should remain
> hardened.

wrap-link.sh is already mandatory if you want to link statically with
the posix skin library. Which is also the case why the __real wrappers
exist at all.

> 
>>>>>> I guess the loader eliminates the duplicates.
>>>>>>
>>>>> It has to. For the same reason, we should be able to clean up
>>>>> skins/common/current.c now.
>>>> I am not that confident about that change. By using the weak directive,
>>>> we make sure that the same __thread variable is used for instance. If we
>>>> do not do that, what prevents the code from using the local symbols in
>>>> each library ? IOW, removing the duplicate could work for libxeno_common
>>>> symbols when invoked externally (which probably almost never happens),
>>>> but not inside the skin libraries. I do not know about that, which is
>>>> why I kept the weak declarations.
>>> Mixing weak functions with non-weak variables can cause troubles as
>>> well. Sticking our head into the sand is no good approach, understanding
>>> the requirements for weak or not is better - and eliminating weak would
>>> be best.
>> Yes, all non static variables must be made weak. But this should already
>> be the case in libxeno_common.
> 
> Yes, and all static inlines must be made global or the static symbols
> they access must become weak - that's where the bugs are hidden.

Not if the static symbols in all instances are initialized with the same
value (which is the case with xnarch_init_timeconv for instance).

> 
>> Using the weak attribute is the best approach. Having symbols multiply
>> defined is a bad idea and not "standard compliant". The problem is not
>> to understand what happens with one instance of a toolchain, the problem
>> is to know whether the behaviour is the same on all the toolchains of
>> all the seven architectures supported by Xenomai. The --wrap directive
>> proved that not all versions of all toolchains on all platforms are equal.
>>
>> The only alternative I would accept is a guaranteed portable ld
>> directive that would make all the symbols of the library automagically weak.
> 
> I'm convinced that weak is the non-standard approach here. If we need to
> mark commonly used functions weak, it indicates somethings is not yet
> optimally organized.

It is definitely non-standard. But works reliably the same way with gcc
on all platforms (well except if you declare some extern symbols weak,
but you are looking for trouble when doing that anyway).

I think we should not worry too much for these issues, as the current
situation works. So, we have plenty of time to decide what to do, and
more urgent issues to treat (such as the file descriptors situation, the
NTP stuff, or the posix signals to name a few).

-- 
					    Gilles.


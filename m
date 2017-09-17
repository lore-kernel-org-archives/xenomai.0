References: <20170907153622.Horde.hT_sRaGS6VmkuifQTO4pqBa@office.mrmoco.com>
 <2ceb59af-770f-d99f-1f6a-553a669d20b5@xenomai.org>
 <20170911121830.Horde.hdU-y9sijxk8OGHoWqdylfy@office.mrmoco.com>
 <d8eca49a-1491-0e42-064e-ccbe3c188949@xenomai.org>
 <20170911161756.Horde.5576SR9hJdNX3u6KppQElrb@office.mrmoco.com>
 <20170912132632.Horde.2n3kq1TB84KjAL7evP_5TA4@office.mrmoco.com>
 <4226b20c-7598-fd17-62e7-ace127b73796@xenomai.org>
 <20170915155855.Horde.nQ5i92f5rMxezSXdhTEkBwg@office.mrmoco.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1c9e66a6-fdbd-d1c0-f81e-75c068888c9d@xenomai.org>
Date: Sun, 17 Sep 2017 18:28:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170915155855.Horde.nQ5i92f5rMxezSXdhTEkBwg@office.mrmoco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Questions around porting app to Xenomai/Cobalt
 resulting in SIGABRT ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul Wilkinson <paul.w@mrmoco.com>, xenomai@xenomai.org

On 09/15/2017 05:58 PM, Paul Wilkinson wrote:
> 
> Quoting Philippe Gerum <rpm@xenomai.org>:
> 
> 
>>> Stack frame 6 shows std:thread is using pthreads under the hood, but the
>>> SIGABRT
>>> seems to imply that my increasing PTHREAD_STACK_DEFAULT hasn't had any
>>> effect, I
>>> now doubt Xenomai Cobalt is wrapping the pthread calls and applying
>>> the new
>>> PTHREAD_STACK_DEFAULT to the std::thread calls.
>>>
>>
>> Most likely, as the dynamic linker won't do the symbol wrapping we need
>> from pthread_create -> __wrap_pthread_create when loading a DSO. A not
>> so elegant way to force this would be to link against the static version
>> of libstdc++, but, you would risk unwanted wrapping of other POSIX calls
>> throughout the library in the same move.
>>
>> This post may help:
>> https://xenomai.org/pipermail/xenomai/2014-August/031475.html
> 
> Very interesting and insightful.
> 
>>
>>> I'd appreciate any insight into when and when not calls such as pthread*
>>> will be
>>> intercepted by Xenomai Cobalt.
>>>
>>
>> Easiest way: use gdb, setting a breakpoint in the __wrap_pthread_create
>> routine. This one is provided by libcobalt, and should not be hit when
>> instantiating the std::thread class from the libstdc++ DSO.
> 
> Thank you.
> 
> As you suggested I set a breakpoint in __wrap_pthread_create, it is never
> called following a std::thread thread creation.
> 
> Which makes me wonder why replacing the std::thread thread creation with
> pthread_create and bumping up the thread stack sizes made the SIGABRT and
> SIGSEGV's disappear.
> 

Considering the opposite, i.e. not having libcobalt limiting the stack
size by setting the proper attribute before calling pthread_create(), we
may have std::thread rely on the default size setting. If the stack size
is unspecified in the attribute block, the NPTL may use RLIMIT_STACK if
set as a default value for pthread_create(), which is commonly 8Mb
(ulimit -s).

Xenomai apps run mlocked, so the stack memory is actually committed when
a real-time thread emerges, which would mean 8Mb consumed every time a
new thread is instantiated this way.

Depending on how much memory you have on the target, and how many
threads are instantiated, you may well end up with a RAM shortage,
causing all sorts of fireworks. This is only guesswork at this stage,
but that is plausible.

-- 
Philippe.


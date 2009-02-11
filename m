Message-ID: <49921547.2060601@domain.hid>
Date: Wed, 11 Feb 2009 01:01:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20090204141542.GA9557@domain.hid>	<20090204161903.GA27688@domain.hid>	<20090205093528.GC11556@domain.hid>	<498D56C7.7020504@domain.hid>	<20090209165009.GD12938@domain.hid>
	<499089C8.2010303@domain.hid>
In-Reply-To: <499089C8.2010303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] posix shm problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tom Schouten <tom@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Tom Schouten wrote:
>> On Sat, Feb 07, 2009 at 10:39:19AM +0100, Gilles Chanteperdrix wrote:
>>> Tom Schouten wrote:
>>>> Hello,
>>>>
>>>> I tried with a different kernel .config (right.config) which made the 
>>>> userspace posix shm problem go away.  The significant difference I can see 
>>>> is this:
>>>>
>>>> ## cat right.config |grep SHM
>>>> CONFIG_SHMEM=y
>>>> # CONFIG_TINY_SHMEM is not set
>>>> # CONFIG_XENO_OPT_POSIX_SHM is not set
>>> Ok. In this case, you use Linux' shared memories, not xenomai's.
>>>
>> Aha.  
>>
>> Does this have any impact on real-time behaviour after the memory is 
>> mapped?
> 
> No, provided that the memory is locked with mlockall, there is no fault
> upon access to the mapped memory.
> 
> As explained in the Kconfig help, the only use of Xenomai posix skin
> shared memory is to share memory between kernel-space and user-space.
> So, if you only plan to write user-space applications, you do not need
> posix skin shared memory support.
> 
> Nevertheless, the bug you found needs fixing...

Ok. This should be fixed by now.

http://svn.gna.org/viewcvs/xenomai?rev=4617&view=rev

-- 
					    Gilles.


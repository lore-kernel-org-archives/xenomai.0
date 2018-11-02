Subject: Re: [I-PIPE] ipipe-core-4.14.71-x86-1 released
References: <20181101175938.D29167FB@centrum.cz>
 <33f0bc4d-f8ef-9950-74ac-8b62bca6f015@xenomai.org>
 <20181102110750.24650a70@md1za8fc.ad001.siemens.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a55697f8-f130-bab5-1f5f-f1a54fdf8119@siemens.com>
Date: Fri, 2 Nov 2018 12:45:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181102110750.24650a70@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: =?UTF-8?Q?Petr_=c4=8cervenka?= <grugh@centrum.cz>, Xenomai <xenomai@xenomai.org>

On 02.11.18 11:07, Henning Schild via Xenomai wrote:
> Am Thu, 1 Nov 2018 18:38:47 +0100
> schrieb Philippe Gerum <rpm@xenomai.org>:
> 
>> On 11/1/18 5:59 PM, Petr Červenka wrote:
>>> Hello.
>>>   
>>> Is it really finished?
>>> I have problems to compile the patched kernel.
>>>   
>>> At first, when it compiles machine.c, there is such error:
>>>    CC      arch/x86/xenomai/machine.o
>>> In file included from ./include/asm-generic/xenomai/syscall.h:23:0,
>>>                   from
>>> arch/x86/xenomai/include/asm/xenomai/syscall.h:24, from
>>> arch/x86/xenomai/machine.c:22: ./arch/x86/include/asm/uaccess.h: In
>>> function ‘set_fs’: ./arch/x86/include/asm/uaccess.h:33:9: error:
>>> dereferencing pointer to incomplete type ‘struct task_struct’
>>> current->thread.addr_limit = fs; ^~
>>>   
>>> After an ad-hoc fix, there are some other errors for example during
>>> compiling of thread.c, mostly connected to fpu: fpu.fpregs_active,
>>> fpu.active_state, __fpregs_deactivate(), __fpregs_activate(),
>>> clts(), stts(), SLAB_NOTRACK, ... Am I doing something wrong?
>>>     
>>
>> You are likely not using the proper Xenomai branch, you need -next.
> 
> I would not suggest next, master and stable/v3.0.x should do. But
> v3.0.7 and older will not work.

"next" is now a (potentially rebasing) integration branch for "master". The 
latter will only evolve linearly, no more rebasing. Unless there is particular 
interest in some fix, "master" is indeed the recommendation for following the 
development for the next major release. Otherwise: stable.

> 
> As far as i understood we will soon have a v3.1, for people that like
> their releases ;).

I'm also planning to do a 3.0.8 release "soonish", specifically now that we have 
x86-ipipe updates that require this.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


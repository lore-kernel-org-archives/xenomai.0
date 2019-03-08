Subject: Re: smokey's fork tests hangs?
References: <930188d381964d3794e4204d7ef2a477@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <11bb63cf-9719-0e72-2c97-dafdb3b54da8@siemens.com>
Date: Fri, 8 Mar 2019 14:00:07 +0100
MIME-Version: 1.0
In-Reply-To: <930188d381964d3794e4204d7ef2a477@andritz.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 07.03.19 15:55, Lange Norbert via Xenomai wrote:
> Hello,
> 
> I have problems with the fork tests, they both hang for me.
> 
> # xeno smokey --run=11 --verbose=2
> <hangs>
> 
> # xeno smokey --run=20 --verbose=2
> no leak withthread
> no leak withmutex
> no leak withcond
> no leak withsem
> no leak withnamed sem
> no leak withtimer
> no leak withmq
> <hangs>
> 
> When started under gdb, the parent is running into waitpid,
> The child is stuck at an innocent locking snippet [1].
> 
> #0  __lll_lock_wait_private ()
>      at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:63
> #1  0x00007ffff7ed74de in __GI___register_atfork (
>      prepare=0x7ffff7f5edc0 <atfork_lock>, prepare@entry=0x0,
>      parent=parent@entry=0x0,
>      child=child@entry=0x7ffff7f9f4e0 <cobalt_fork_handler>,
>      dso_handle=0x7ffff7de0e5b <__lll_lock_wait_private+27>)
>      at register-atfork.c:40
> #2  0x00007ffff7faca9d in __pthread_atfork (prepare=prepare@entry=0x0,
>      parent=parent@entry=0x0,
>      child=child@entry=0x7ffff7f9f4e0 <cobalt_fork_handler>)
>      at pthread_atfork.c:51
> #3  0x00007ffff7f9f307 in __cobalt_init ()
>      at /home/lano/buildroot/build/xenomai/lib/cobalt/init.c:212
> #4  cobalt_init () at /home/lano/buildroot/build/xenomai/lib/cobalt/init.c:252
> #5  0x00007ffff7f9f4fc in cobalt_fork_handler ()
>      at /home/lano/buildroot/build/xenomai/lib/cobalt/init.c:192
> #6  0x00007ffff7ed7898 in __run_fork_handlers (who=who@entry=atfork_run_child)
>      at register-atfork.c:134
> #7  0x00007ffff7e9b04a in __libc_fork () at ../sysdeps/nptl/fork.c:137
> #8  0x0000000000408d0b in ?? ()
> #9  0x00000000004051d1 in main ()
> 
> [1] - https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/x86_64/lowlevellock.S;h=71dd740202b1d6501a2ffd929aa99cbd99a019ef;hb=1e5c5303a522764d7e9d2302a60e4a32cdb902f1
> 

Not reproducible here with stable/3.0.x or next, and with ipipe-x86-4.14.y. What 
are your parameters?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


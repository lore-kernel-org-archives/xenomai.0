Subject: Re: cobalt_assert_nrt should use __cobalt_pthread_kill
References: <DB9PR05MB77239BFB7BA2E64E825FF123F6C09@DB9PR05MB7723.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cdab0109-de16-94ac-8dbf-3730ca7e46f2@siemens.com>
Date: Thu, 19 Aug 2021 12:53:40 +0200
MIME-Version: 1.0
In-Reply-To: <DB9PR05MB77239BFB7BA2E64E825FF123F6C09@DB9PR05MB7723.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
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

On 19.08.21 11:56, Lange Norbert via Xenomai wrote:
> Hello,
> 
> I have some small slight issue with the cobalt_assert_nrt function,
> incase a violation is detected the thread should get a signal,
> but the implementation will implicitly get a signal during the execution of pthread_kill, see:
> 
> 
> #0  getpid () at ../sysdeps/unix/syscall-template.S:60
> #1  0x00007fc1dc4fa0d6 in __pthread_kill (threadid=<optimized out>, signo=24) at ../sysdeps/unix/sysv/linux/pthread_kill.c:53
> #2  0x00007fc1dc8b2470 in callAssertFunction () at /home/lano/git/preload_checkers/src/pchecker.h:199
> #3  malloc () at /home/lano/git/preload_checkers/src/pchecker_heap_glibc.c:220
> #4 <actual instrumented function>
> 
> You see, the signal should happen with the pc of #2, not from the implementation of glibc (or whatever c library).
> So the function should be changed to:
> 
> void cobalt_assert_nrt(void)
> {
>             if (cobalt_should_warn())
>                         __cobalt_pthread_kill(pthread_self(), SIGDEBUG);
> }
> 
> (or even replaced with the raw syscall ?)
> 

Hmm, that's similar to an assert causing a lengthy trace, not failing
directly at the place where the assert was raised:

#0  0x00007ffff7a3918b in raise () from /lib64/libc.so.6
#1  0x00007ffff7a3a585 in abort () from /lib64/libc.so.6
#2  0x00007ffff7a3185a in __assert_fail_base () from /lib64/libc.so.6
#3  0x00007ffff7a318d2 in __assert_fail () from /lib64/libc.so.6
#4  0x0000000000400524 in main () at assert.c:5

What is your practical problem with the current implementation? Do you
expect a specific SIGDEBUG reason?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


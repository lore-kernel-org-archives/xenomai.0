Message-ID: <4EFC7AD7.2030202@domain.hid>
Date: Thu, 29 Dec 2011 15:36:07 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <BLU166-W4963DB0BDCBFDED1A1EF5CC4AD0@domain.hid>
In-Reply-To: <BLU166-W4963DB0BDCBFDED1A1EF5CC4AD0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] general questions
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan-Erik Lange <jan0385@domain.hid>
Cc: xenomai@xenomai.org

On 12/29/2011 01:04 PM, Jan-Erik Lange wrote:
> Hello,
> I'm new in the topic about the Xenomai co-kernel approach and I have
> some questions to the primary mode and secondary mode.
>
> I have trouble with the imagination of the fact in general, that one
> task (process oder thread) can be processed by two kernels (Xenomai
> nucleus and standard kernel), and treated by the one in real time and by
> the other in non real-time.
>
> 1. So far I understood this approach, the primary and secondary mode is
> an abstract description of the fact, that threads or processes can be
> scheduled by the Xenomai nucleus or by the standard Linux kernel
> scheduler. Is this correct?

Yes. A Xenomai thread in user-space is attached a "shadow" control area 
in addition to the regular linux context data, which enables both linux 
and the nucleus to schedule it in a mutually exclusive manner.

>
> 2. Now supose, that I have chosen the VxWork-skin and I started a task
> in the primary mode. Is it correct that when this task is calling a non
> VxWork-API-funtion, there will a change of the context from primary to
> the secondary mode? Or what is the exact condition of the switching of
> the context?
>

- invoking a regular linux syscall
- receiving a linux signal (e.g. kill(2) and GDB)
- causing a CPU trap (e.g. invalid memory access), hitting a breakpoint 
(e.g. GDB)

all these situations cause the switch from primary to secondary mode. We 
say that such thread "relaxes" in Xenomai parlance.

A common caveat is to call a glibc routine, which eventually issues a 
linux syscall under the hood. Think of malloc() detecting a process 
memory shortage, which then calls mmap or sbrk to extend the process 
data. Or, running into a mutex contention once in a while, forcing the 
calling thread to issue a syscall for sleeping on the mutex. 
Fortunately, we have a tool to detect these situations.

> It would be very nice, if you could tell me a little bit about these
> questions?
>
> Best regards
> Jan
>
>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.


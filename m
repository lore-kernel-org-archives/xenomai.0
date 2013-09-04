Message-ID: <52271E8C.8070801@gmail.com>
Date: Wed, 04 Sep 2013 07:50:36 -0400
From: Adam J <jacobvi123@gmail.com>
MIME-Version: 1.0
References: <CAC3AHrLQiZxgSrDxKhVa_171Ve7unw__ZjpA22z27mDDqVpmcQ@mail.gmail.com>
	<52270CC9.1090102@siemens.com>
	<CAC3AHr+NOAqPNAFnxGvcMxuJRorotv0O0WrGHCUGuV0zBZYEhw@mail.gmail.com>
	<52271128.9010401@siemens.com>
In-Reply-To: <52271128.9010401@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] unmapping and remapping /dev/rtheap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

I'm a researcher who's trying to use a linux system as a testbed for a 
new program sampling methodology. What I want to be able to do is take a 
checkpoint at a given point in a program and then run that checkpoint 
for a set amount of instructions repeatedly with deterministic run time. 
I am new to running programs deterministically on Linux.

Currently I am running my experiments on a vanilla 3.10.10 linux system. 
I have all user-space processes disabled except for the shell I'm using 
to launch jobs. I am running my process under test with SCHED_FIFO 99 
priority on a CPUSet with a single CPU and I have NUMA emulation setup 
to segregate a portion of memory for that CPU from the rest of the 
system. DVFS is disabled, and if there is an involuntary context switch 
the run is said to have failed. I'm also flushing the pagecache using 
drop_caches before restoring the program to get the system state as 
repeatable as possible.

My test programs are controlled using performance counters via PAPI and 
signaling. For example, if I want to run a program for 100M instructions 
I write 100,000,000 to a specific file and then send a signal to the 
program telling it to start. The program reads the file, runs for 100M 
instructions, produces the unhalted cycle count, and then pauses. I want 
this unhalted cycle count to be the same every time.

I have my experiments set up to be able to repeatedly warm-up and run a 
region of a program. For example, I have program A which I want to 
measure run time for 100M instructions starting at Instruction 300M in 
the program. To setup the experiment take a checkpoint at Instruction 
100M. When running the experiment I restore the checkpoint at 
Instruction 100M and then run the program for 200M instructions to 
warm-up the micro-architectural state. Then I run the program for 100M 
instructions and measure the run time.

The issue I'm having right now is that I'm getting non-deterministic run 
times when running samples and I'm not sure of the cause. The programs I 
am sampling are from SPEC2006 which are not real-time applications. I am 
also running the SPEC applications on a non-real time linux system. One 
hypothesis I have is because the system isn't real time there are system 
level effects causing the program region to run for a different amount 
of time for each execution. To test this hypothesis I wanted to use a 
real-time linux system such as Xenomai to see if running my program 
under Xenomai will eliminate the variability. The programs I'm using are 
still not designed for real-time linux, but since I'm only looking at a 
small region of the program I'm hoping compiling the program unmodified 
using Xenomai would be sufficient.

Another hypothesis we have that the issue is due to different memory 
mappings being used after every restore resulting in the program 
occupying different ways in the cache. I am not sure how to determine if 
this is the cause of the run time variability though.

To test my first hypothesis I am trying to take a checkpoint of my 
application using CRIU so I can compare the run time variability of the 
Xenomai compiled application to that of the standard compilation of the 
application. If you think though this is not a valid hypothesis, I am 
open to other ideas.

Thank you,

Adam



On 9/4/2013 6:53 AM, Jan Kiszka wrote:
> On 2013-09-04 12:39, Adam Jacobvitz wrote:
>> Yeah...I suppose that's the fundamental issue. I'm brand new to xenomai and
>> I'm not really familiar to what state xenomai maintains for an application.
>>
>> Do you know what state I would need to checkpoint and if its even possible
>> to checkpoint it?
> There is a lot, starting with core thread objects, sync objects etc.,
> then there are skin-specific extensions of those and also objects that
> are shared between processes. But even if you export all this, Xenomai
> wasn't designed with this use case in mind. So you may find many tricky
> corner cases around checkpoint/restart - just like in Linux...
>
> What overall use case are you aiming at with CRIU for your RT
> process(es)? What states would your processes be in when
> saving/restoring? And what Xenomai version do you consider for this, 2.6
> or upcoming 3.0?
>
> Jan
>



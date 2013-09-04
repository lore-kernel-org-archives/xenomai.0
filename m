Message-ID: <5227222E.2030000@gmail.com>
Date: Wed, 04 Sep 2013 08:06:06 -0400
From: Adam J <jacobvi123@gmail.com>
MIME-Version: 1.0
References: <CAC3AHrLQiZxgSrDxKhVa_171Ve7unw__ZjpA22z27mDDqVpmcQ@mail.gmail.com>
	<52270CC9.1090102@siemens.com>
	<CAC3AHr+NOAqPNAFnxGvcMxuJRorotv0O0WrGHCUGuV0zBZYEhw@mail.gmail.com>
	<52271128.9010401@siemens.com> <52271E8C.8070801@gmail.com>
	<66b86652c6224bb4db31a858f05f8ab4.squirrel@127.0.0.1>
In-Reply-To: <66b86652c6224bb4db31a858f05f8ab4.squirrel@127.0.0.1>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

Oops, yeah I forgot to mention that. Before running the experiments I do:

sysctl -w kernel.sched_rt_runtime_us=-1
sysctl -w kernel.sched_rt_period_us=1000000000

Adam

On 9/4/2013 8:03 AM, Gilles Chanteperdrix wrote:
> Adam J wrote:
>> I'm a researcher who's trying to use a linux system as a testbed for a
>> new program sampling methodology. What I want to be able to do is take a
>> checkpoint at a given point in a program and then run that checkpoint
>> for a set amount of instructions repeatedly with deterministic run time.
>> I am new to running programs deterministically on Linux.
>>
>> Currently I am running my experiments on a vanilla 3.10.10 linux system.
>> I have all user-space processes disabled except for the shell I'm using
>> to launch jobs. I am running my process under test with SCHED_FIFO 99
> Maybe I am stating the obvious, but have you tuned
> /proc/sys/kernel/sched_rt_sched_rt_period_us
> and
> /proc/sys/kernel/sched_rt_runtime_us
>



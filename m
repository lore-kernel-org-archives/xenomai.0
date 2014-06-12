Message-ID: <5399B9D8.3000201@xenomai.org>
Date: Thu, 12 Jun 2014 16:31:52 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5396CD6D.8060806@axelsw.it> <5397644B.9060806@xenomai.org>
 <5399AD6C.8070905@axelsw.it>
In-Reply-To: <5399AD6C.8070905@axelsw.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Gdb freezes when stepping through rt_task_spawn.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Tessore <marco.tessore@axelsw.it>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 06/12/2014 03:38 PM, Marco Tessore wrote:
> Thank you, I will try that commit.
> But I have another question about it:
> does the commit involve the patch to the kernel?

Yes.

> Since my kernel was patched using i-pipe git for the vanilla 3.10, but
> applied to a customized version of 3.11,
> if the commit involves the kernel patch, it can be difficult for me to
> upgrade.
>

There is no other option.

> I have found another problem with gdb:
> when I have multiple tasks pending on rt_sem_p,
> if I change the state of breakpoints, the function can return error code
> -38.
> May be that the same commit can resolve both problems.

It most likely does.

>
> Thank you very much
> Marco Tessore
>
> Il 10/06/2014 22:02, Gilles Chanteperdrix ha scritto:
>> On 06/10/2014 11:18 AM, Marco Tessore wrote:
>>> Hello,
>>> I have a problem, you've probably already dealt with in the past:
>>> when I debug with gdb / gdbserver, if I execute step by step while I
>>> invoke the call rt_task_spawn, gdb freezes with no chance of recovery.
>>>
>>> Since I have seen that you have already faced the problem a few years
>>> ago, I was wondering if you had found a solution.
>> Did you try xenomai 2.6 git? An issue was fixed very recently with
>> regard to gdb (it is actually the latest commit on this branch).
>>
>>
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.


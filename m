Message-ID: <507F2B04.4030907@mind.be>
Date: Thu, 18 Oct 2012 00:02:44 +0200
From: Arnout Vandecappelle <arnout@mind.be>
MIME-Version: 1.0
References: <507E9654.5020503@mind.be> <507EA55E.6010506@xenomai.org>
	<507EAC59.6000909@mind.be> <507EAE5E.5060200@xenomai.org>
	<507EDDF1.8090904@mind.be> <507F0E11.1080204@xenomai.org>
In-Reply-To: <507F0E11.1080204@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Native skin rt_task_create/rt_task_shadow doesn't
 inherit affinity
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 17/10/12 21:59, Gilles Chanteperdrix wrote:
>> >
>> >  When you do:
>> >
>> >  CPU_SET(1,&cpuset);
>> >  sched_setaffinity(0, sizeof(cpuset),&cpuset);
>> >  rt_task_shadow(&task, "test", 99, 0);
>> >
>> >  then rt_task_shadow will migrate the thread from cpu 1 to cpu 0,
>> >  so it migrates twice overall (assuming Linux had started it on cpu 0).
>> >
>> >  When you do:
>> >
>> >  rt_task_shadow(&task, "test", 99, 0);
>> >  CPU_SET(1,&cpuset);
>> >  sched_setaffinity(0, sizeof(cpuset),&cpuset);
>> >
>> >  then sched_setaffinity will migrate the thread from cpu 0 to cpu 1.
>> >
>> >     My point was that it seems inconsistent that it makes a difference
>> >  in which order you shadow the task and you specify which cpu it should
>> >  run on.
>
> Yes, I got it, we need to fix that too.

  On second thought, it actually makes more sense if the xenomai nucleus would
keep the thread on the CPU it is currently assigned to (unless the affinity
specifies something else).  In fact, I thought this was already the case...
And I can see code in xnpod_start_thread which does exactly that.  So why does
the first example migrate the task to a different CPU?


  Regards,
  Arnout
-- 
Arnout Vandecappelle                               arnout at mind be
Senior Embedded Software Architect                 +32-16-286540
Essensium/Mind                                     http://www.mind.be
G.Geenslaan 9, 3001 Leuven, Belgium                BE 872 984 063 RPR Leuven
LinkedIn profile: http://www.linkedin.com/in/arnoutvandecappelle
GPG fingerprint:  7CB5 E4CC 6C2E EFD4 6E3D A754 F963 ECAB 2450 2F1F


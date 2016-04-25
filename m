References: <E1aq1Ri-0002Ry-RW@sd-51317.xenomai.org>
 <571E312A.9040903@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <571E4057.7000703@xenomai.org>
Date: Mon, 25 Apr 2016 18:05:43 +0200
MIME-Version: 1.0
In-Reply-To: <571E312A.9040903@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Philippe Gerum : lib/cobalt: add config switch to
 enable lazy setsched update mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 04/25/2016 05:00 PM, Jan Kiszka wrote:
> On 2016-04-12 18:45, git repository hosting wrote:
>> Module: xenomai-3
>> Branch: wip/dovetail
>> Commit: 867070475384652b4e3d4a25f5ad983732a59a7e
>> URL:    http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=867070475384652b4e3d4a25f5ad983732a59a7e
>>
>> Author: Philippe Gerum <rpm@xenomai.org>
>> Date:   Sun Mar 20 17:58:33 2016 +0100
>>
>> lib/cobalt: add config switch to enable lazy setsched update mode
>>
>> --enable-lazy-setsched should be given for enabling lazy propagation
>> of scheduling parameters upon calls to pthread_setschedparam*(),
>> sched_setscheduler(). Defaults to off.
> 
> Missed this so far: Is there particular reason to keep it off by
> default? Regression concerns (i.e. this will be only off in the
> beginning) or downsides of the lazy implementation?

Basically, this is turned off by default because of the weird effects on
the regular glibc behavior due to bypassing the priority cache (e.g.
standard prio protect mutexes). At any rate, people switching this on
must know what they are doing, including the side-effects on the glibc,
and implicitly accept them.

Conversely, people who don't need this option should not have to bother
about those side-effects.

-- 
Philippe.


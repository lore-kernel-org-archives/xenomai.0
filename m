Message-ID: <49A52928.9010008@domain.hid>
Date: Wed, 25 Feb 2009 12:19:04 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20090217170418.1425.56126.stgit@domain.hid>
	<49A517B1.8000409@domain.hid>
In-Reply-To: <49A517B1.8000409@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v2 0/4] Various fixes and cleanups
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> This is a rework/rebase of the patch series I sent last December,
>> addressing the concerns and suggestions brought up during our discussion
>> in January.
>>
>>
>> Find the patches also at git://git.kiszka.org/xenomai.git queues/assorted
>>
>> Jan Kiszka (4):
>>       POSIX: Fix SCHED_RR thread creation

This one needs more review and testing. It will be merged in 2.5-rc1 to get more
exposure first, before any backport to 2.4 in order to reduce the impact of any
regression we might find.

>>       Mark libs nodlopen on initial-exec TLS
>>       Add --enable-dlopen-skins configure switch
>>       POSIX: Do not auto-shadow main with dlopen enabled
> 

Will make their way to 2.4.7 and 2.5-rc1 asap.

> What is the schedule for these patches? 2..4 shouldn't be controversial
> anymore (find them rebased as patch 1..3 under queues/assorted). And for
> the first one I already sent a rework (now patch 4 in that queue) that
> still looks fine to me. But I can also repost some/all of them if preferred.
> 
> Jan
> 


-- 
Philippe.


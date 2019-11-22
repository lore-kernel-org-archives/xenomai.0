Subject: Re: [PATCH 7/7] cobalt/sched: block CPU migration when rescheduling
 over root
References: <20191122171949.18021-1-rpm@xenomai.org>
 <20191122171949.18021-8-rpm@xenomai.org>
 <e64bcd29-43c9-6d3f-3f34-451513d319f7@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <16e0b004-345c-2f27-3591-073301ec396f@xenomai.org>
Date: Fri, 22 Nov 2019 19:20:53 +0100
MIME-Version: 1.0
In-Reply-To: <e64bcd29-43c9-6d3f-3f34-451513d319f7@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 11/22/19 7:01 PM, Jan Kiszka wrote:
> On 22.11.19 18:19, Philippe Gerum via Xenomai wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>>
>> In seldom cases, we might call xnsched_run() from the root context.
>> This call might be subject to CPU migration as the root stage would
>> likely be unstalled. In such a case, block CPU migration entirely
>> while checking for early exit conditions which involves accessing
>> per-cpu data.
> 
> So, should I read this as a fix, a safety measure, or rather an optimization?
> 

Keep this one on hold for the moment, unlike others it may need more thought. I'll follow up on this.

-- 
Philippe.


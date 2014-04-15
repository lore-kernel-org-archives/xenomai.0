Message-ID: <534D1A74.7010906@xenomai.org>
Date: Tue, 15 Apr 2014 13:39:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <533C100A.7050501@xenomai.org>
 <20140402134017.GG17765@csclub.uwaterloo.ca>
 <20140402134133.GH17765@csclub.uwaterloo.ca>
 <20140402134609.GI17765@csclub.uwaterloo.ca> <533C1709.3090305@xenomai.org>
 <20140402143809.GJ17765@csclub.uwaterloo.ca> <533C21A0.30502@xenomai.org>
 <20140403134647.GL17765@csclub.uwaterloo.ca> <533D688A.7050609@xenomai.org>
 <20140403141635.GM17765@csclub.uwaterloo.ca>
 <20140414210638.GI17765@csclub.uwaterloo.ca>
In-Reply-To: <20140414210638.GI17765@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 04/14/2014 11:06 PM, Lennart Sorensen wrote:
> On Thu, Apr 03, 2014 at 10:16:35AM -0400, Lennart Sorensen wrote:
>> On Thu, Apr 03, 2014 at 03:56:26PM +0200, Gilles Chanteperdrix wrote:
>>> On 04/03/2014 03:46 PM, Lennart Sorensen wrote:
>>>> Load script terminated, terminating checked scripts
>>>> ---|-----------|-----------|-----------|--------|------|-------------------------
>>>> RTS|     -1.140|      2.280|     10.811|       0|     0|    18:21:26/18:21:26
>>>> RTD|           0|         795|    63498250
>>>> RTD|           0|        4654|  1051007408
>>>> RTD|           1|       14862|  1064936835
>>>> RTD|           1|         134|    63457021
>>>> pipe_in: /tmp/xeno-test-in-9751
>>>>
>>>> I am guessing that looks successful.
>>>
>>> Yes, I guess a 15us worst case interrupt latency is unprecedented
>>> for the ARM architecture. The timer anticipation may be a bit too
>>> eager for this SOC, which results in negative latencies. What does
>>> cat /proc/xenomai/timer say?
>>
>> root@omap5:~# cat /proc/xenomai/timer
>> status=on+watchdog:setup=488:clock=3556147959244:timerdev=arch_sys_timer:clockdev=ipipe_tsc
> 
> Any more info on this?
> 
> The negative minimum latency seems a bit odd after all.
> 
No, it is a bit strange, since the anticipation is 488ns, the negative
latency should be less than twice that. Unfortunately, I can not
reproduce this issue easily. What you could try is to change the way the
timer setup time is calculated, and use the average value, instead of
average + std deviation.

-- 
                                                                Gilles.


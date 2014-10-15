Message-ID: <543E73AC.8030802@xenomai.org>
Date: Wed, 15 Oct 2014 15:16:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <543E4B9F.60602@cgglobal.com> <543E5380.3080700@cgglobal.com>
 <543E567C.4070800@xenomai.org> <543E72BB.50707@cgglobal.com>
In-Reply-To: <543E72BB.50707@cgglobal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] First call to rt_timer_tsc() causes an unexpected
 switch to secondary mode.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alberto.ozalla@cgglobal.com
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/15/2014 03:12 PM, ZIV-Alberto Ozalla Cantabrana wrote:
> 
> On 15/10/14 13:11, Gilles Chanteperdrix wrote:
>> On 10/15/2014 12:59 PM, ZIV-Alberto Ozalla Cantabrana wrote:
>>> Dear colleagues,
>>>
>>> I face an unexpected switch to secondary mode after the very first call to rt_timer_tsc() into a real-time task created by Xenomai.
>>> This unexpected switch  only arises if it is the very first call to rt_timer_tsc().
>> Hi,
>>
>> I see two possible reasons for that:
>> - either on-demand mapping of library text page
>> - or first access to the hardware register.
>>
>> In order to find which is the reason.
>>
>> Could you replace the call to rt_timer_tsc() with a call to __xn_rdtsc()
>> after including asm/xenomai/tsc.h ?
>>
>>
> Hello,
> 
> Thanks for the fast response.
> 
> Unfortunately replacing the call to rt_timer_tsc() with a call to 
> __xn_rdtsc() does not solve the problem.

The intent was not to solve the problem, but to investigate it.

> 
> Another clue is that PF value increases at the same time as MSW.
> 
> 
> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>    0  0      0          11594571   0     00500080   96.3 ROOT/0
>    0  1690   1          5339       1     00300184    1.0 Test_Task
> 
> It seems to be a first access to the hardware register.

It would seem so. I will prepare a piece of code tonight that does not
rely on any external symbol, just to be sure.

> 
> Note: I use a call to mlockall(MCL_CURRENT|MCL_FUTURE) before creating 
> the task.

I do not believe mlockall applies to register mapped from /dev/mem, only
to memory mappings


-- 
                                                                Gilles.


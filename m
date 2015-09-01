Message-ID: <55E60EF9.4020707@xenomai.org>
Date: Tue, 01 Sep 2015 16:47:53 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55E5E453.1080400@xenomai.org>
 <CAPuu0=jX6ig5L7SJrmPVOhCmOm=gwxEmTafTpOqzE85hOji8CA@mail.gmail.com>
 <55E5F849.1070708@xenomai.org> <55E5FCE0.8080702@xenomai.org>
In-Reply-To: <55E5FCE0.8080702@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Dmitriy Cherkasov <dmitriy@mperpetuo.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

On 09/01/2015 03:30 PM, Philippe Gerum wrote:
> On 09/01/2015 09:11 PM, Jorge Ramirez Ortiz wrote:
>> On 09/01/2015 02:27 PM, Dmitriy Cherkasov wrote:
>>> We have seen this before, but so far have not found a way to consistently
>>> reproduce it.
>>>
>>> There are some caveats with the current way context switching is done in Xenomai.
>>>
>>> On armv7, there was a completely separate implementation of xnarch_switch_to(),
>>> as well as separate fpu and TLS switching. At this stage for armv8 however, we
>>> are doing a direct call to the kernel's __switch_to(), which then performs the
>>> relevant register switches.
>>>
>>> Another possibility is that this may be lurking in the mm switch. During calls 
>>> to check_and_switch_context(), the interrupt state may not always
>>> match what is expected according to the comments in the original
>>> version of that function. 
>>>
>>> Overall, this mechanism could definitely benefit from further review.
>>>
>>
>>
>> Thanks Dimitry.
>> I'll also try to look into this for this specific platform (however I am hopping
>> that either Gilles or Philippe can spend some time on this soon)
>>
>> Just for completeness, as things stand this is pretty much that value I am
>> seeing over consecutive runs.
>>
>> RTD|      4.167|      6.099|     11.667|       0|     0|      3.333|     66.667
>> RTD|      4.167|      6.217|     13.333|       0|     0|      3.333|     66.667
>> RTD|      4.167|      6.259|     11.667|       0|     0|      3.333|     66.667
>> RTD|      4.167|      6.226|     12.500|       0|     0|      3.333|     66.667
>> RTD|      4.167|      6.105|     11.667|       0|     0|      3.333|     66.667
>> RTD|      4.167|      6.181|     12.500|       0|     0|      3.333|     66.667
>> RTD|      4.167|      6.232|     12.500|       0|     0|      3.333|     66.667
>> RTD|      4.167|      6.483|     20.000|       0|     0|      3.333|     66.667
>> RTD|      4.167|      6.409|      9.167|       0|     0|      3.333|     66.667
>> RTD|      4.167|      5.707|     12.500|       0|     0|      3.333|     66.667
>> RTD|      4.167|      5.026|      6.667|       0|     0|      3.333|     66.667
>> RTT|  00:15:04  (periodic user-mode task, 1000 us period, priority 99)
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
>> RTD|      4.167|      5.025|      6.667|       0|     0|      3.333|     66.667
>> Load script terminated, terminating checked scripts
>> ---|-----------|-----------|-----------|--------|------|-------------------------
>> RTS|      3.333|      6.540|     66.667|       0|     0|    00:15:04/00:15:04
>> pipe_in: /tmp/xeno-test-in-9797
>>
> 
> This won't address the current issue, but the notification of the head
> domain on memory aborts needs fixing:
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index f363368..e59da5e 100644


applied.
yes I still see the random translation faults (3 in total during the 15 minutes
test run)

feel free to post me suggestions of course. I have been chasing this one for
nearly three days now.



Subject: Re: [PATCH v3 0/5] y2038:clock_settime/gettime for timespec64
References: <1616052862-21869-1-git-send-email-chensong@tj.kylinos.cn>
 <c153b859f0d229bc13cdc794ab09eb2fd5588404.camel@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <605B0CEC.9050404@tj.kylinos.cn>+56FBB8AB0E1F18E3
Date: Wed, 24 Mar 2021 17:57:00 +0800
MIME-Version: 1.0
In-Reply-To: <c153b859f0d229bc13cdc794ab09eb2fd5588404.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>, "rpm@xenomai.org" <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>



On 2021年03月24日 17:33, florian.bezdeka@siemens.com wrote:
> Hi Song!
>
> That looks good so far.

That's great, if this patch serial looks good to you, i can follow it up 
for the rest syscalls.

  I'm on "vacation" for the next two weeks, so no
> timing guarantees, but I will give it a try and integrate it into my
> private gitlab tree once I've synchronized with the new Xenomai
> hackerspace.


>
> If there is some free time available I would start implementing the
> missing API from the back, so starting with the highest syscall. If you
> like, just continue "as used to"...

I'm not sure what is "as used to", but please enjoy your vacation, you 
have make the pattern for syscalls and testcases, and maintain the tree, 
let me take care of the rest.

i will start clock_nanosleep, clock_adjtime and clock_getres tomorrow.

/Song

>
> Best regards,
> Florian
>
> On Thu, 2021-03-18 at 15:34 +0800, chensong wrote:
>> This patch serial is aimed to introduce a new syscall clock_settime64
>> and clock_gettime64 which are specific for 64-bit time_t.
>>
>> There is no impact to current implementation of clock_settime, nothing
>> broken.
>>
>> ---
>> v2:
>> 1, merge clock_settime64 and compat clock_settime64
>> 2, remove checking __xn_feat_time64
>> 3, add clock_gettime64
>> 4, add smokey test for clock_settime64 and clock_gettime64
>>
>> v3:
>> 1, flip patch order: clock_settime64 and clock_gettime54
>> 2, flip syscall number order:
>>     sc_cobalt_clock_gettime64 and sc_cobalt_clock_settime64
>> 3, add documentation for cobalt_put_timespec64
>> 4, new implementation of smokey test for
>>     clock_gettime64 and clock_settime64
>>     it only validates syscalls and doesn't trigger y2038 problem
>>     to avoid jeopardizing environment.
>>
>> chensong (5):
>>    y2038: cobalt/posix/clock: Adding clock_gettime64
>>    y2038: cobalt/posix/clock: Adding clock_settime64
>>    y2038: lib/cobalt/clock: dispatch clock_settime
>>    y2038: lib/cobalt/clock: dispatch clock_gettime
>>    y2038: testsuite/smokey/y2038: testcase for settime64 and gettime64
>>
>>   include/cobalt/kernel/time.h           |  11 ++++
>>   include/cobalt/uapi/syscall.h          |   2 +
>>   kernel/cobalt/posix/clock.c            |  28 +++++++-
>>   kernel/cobalt/posix/clock.h            |   7 ++
>>   kernel/cobalt/posix/syscall32.c        |  27 ++++++++
>>   kernel/cobalt/posix/syscall32.h        |   8 +++
>>   kernel/cobalt/time.c                   |  11 ++++
>>   lib/cobalt/clock.c                     |  12 ++++
>>   testsuite/smokey/y2038/syscall-tests.c | 115 +++++++++++++++++++++++++++++++--
>>   9 files changed, 214 insertions(+), 7 deletions(-)
>>
>




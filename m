Subject: Re: [PATCH v2 0/5] clock_settime/gettime for timespec64
References: <1615521662-5770-1-git-send-email-chensong@tj.kylinos.cn>
 <a7b1d1b9ef48446ac096cbbd4700c0e77741f6b4.camel@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <6051C5FD.2010101@tj.kylinos.cn>+0A9710E77AB9D749
Date: Wed, 17 Mar 2021 17:03:57 +0800
MIME-Version: 1.0
In-Reply-To: <a7b1d1b9ef48446ac096cbbd4700c0e77741f6b4.camel@siemens.com>
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



On 2021年03月12日 18:19, florian.bezdeka@siemens.com wrote:
> On Fri, 2021-03-12 at 12:01 +0800, chensong wrote:
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
>> chensong (5):
>>    [y2038] cobalt: posix: clock: Adding clock_settime64
>>    [y2038] cobalt: posix: clock: Adding clock_gettime64
>
> I would suggest to change the order of the first two patches to use the
> same order for y2038 syscalls as for non-y2038 ones.

please clarify the order you expected:
[PATCH v2 2/5] [y2038] cobalt: posix: clock: Adding clock_gettime64
[PATCH v2 1/5] [y2038] cobalt: posix: clock: Adding clock_settime64

[PATCH v2 3/5] [y2038] lib: cobalt: clock: dispatch clock_settime
[PATCH v2 4/5] [y2038] lib: cobalt: clock: dispatch clock_gettime
[PATCH v2 5/5] [y2038] testsuite: smokey: y2038: testcase for settime64 
and gettime64

is it correct?

besides that, also need to do :
1, flip order c_cobalt_clock_settime64 and c_cobalt_clock_gettime64
2, documentation for cobalt_put_timespec64
3, improve test case

anything else?

Song

>
>>    [y2038] lib: cobalt: clock: dispatch clock_settime
>>    [y2038] lib: cobalt: clock: dispatch clock_gettime
>>    [y2038] testsuite: smokey: y2038: testcase for settime64 and gettime64
>>
>>   include/cobalt/kernel/time.h           |   3 +
>>   include/cobalt/uapi/syscall.h          |   2 +
>>   kernel/cobalt/posix/clock.c            |  28 +++++++-
>>   kernel/cobalt/posix/clock.h            |   7 ++
>>   kernel/cobalt/posix/syscall32.c        |  27 ++++++++
>>   kernel/cobalt/posix/syscall32.h        |   8 +++
>>   kernel/cobalt/time.c                   |  11 ++++
>>   lib/cobalt/clock.c                     |  12 ++++
>>   testsuite/smokey/y2038/syscall-tests.c | 114 +++++++++++++++++++++++++++++++--
>>   9 files changed, 206 insertions(+), 6 deletions(-)
>>
>




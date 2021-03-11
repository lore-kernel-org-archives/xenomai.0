Subject: Re: [PATCH 0/4] [y2038] clock_settime for timespec64
References: <1615430738-23692-1-git-send-email-chensong@tj.kylinos.cn>
 <b5f2535aa8cf432a23cda621a65ff0c266beff09.camel@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <6049D506.7050801@tj.kylinos.cn>+2C4189BE68BF6DD8
Date: Thu, 11 Mar 2021 16:29:58 +0800
MIME-Version: 1.0
In-Reply-To: <b5f2535aa8cf432a23cda621a65ff0c266beff09.camel@siemens.com>
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



On 2021年03月11日 16:27, florian.bezdeka@siemens.com wrote:
> Hi!
>
> On Thu, 2021-03-11 at 10:45 +0800, chensong wrote:
>> This patch serial is aimed to introduce a new syscall clock_settime64,
>> which is specific for 64-bit time_t.
>>
>> There is no impact to current implemetation of clock_settime, nothing
>> broken.
>>
>> chensong (4):
>>    include: wrappers: introduce old_timespec32 and __kernel_timespec
>
> This patch is not necessary. We don't care about the 4.4 kernel (the
> only one which does not provide this data types) as it has no y2038
> syscalls at all.
>
>>    [y2038]cobalt: posix: clock: Adding clock_settime64
>>    [y2038]cobalt: posix: syscall32: Adding compat clock_settime64
>
> This two patches should be squashed. No need to separate the compat
> syscall. Some inline comments will follow

ok, will do
>
>>    [y2038] lib: cobalt: clock: dispatch clock_settime
>
> Will comment on this patch separately.
>
>>
>>   include/cobalt/uapi/syscall.h                        |  1 +
>>   kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 17 +++++++++++++++++
>>   kernel/cobalt/posix/clock.c                          | 12 ++++++++++++
>>   kernel/cobalt/posix/clock.h                          |  4 ++++
>>   kernel/cobalt/posix/syscall32.c                      | 13 +++++++++++++
>>   kernel/cobalt/posix/syscall32.h                      |  4 ++++
>>   lib/cobalt/clock.c                                   |  6 ++++++
>>   7 files changed, 57 insertions(+)
>>
>




Sender: chensong_2000@189.cn
Subject: Re: [PATCH v5 1/5] y2038: cobalt/posix/clock: Adding clock_gettime64
References: <1618993992-21069-1-git-send-email-chensong_2000@189.cn>
 <96da9caa811594f0f910491d1c4a99cece5032f5.camel@siemens.com>
From: chensong <chensong_2000@189.cn>
Message-ID: <45c72bd2-2eac-f627-2e8f-8593389f4486@189.cn>
Date: Fri, 23 Apr 2021 19:48:19 +0800
MIME-Version: 1.0
In-Reply-To: <96da9caa811594f0f910491d1c4a99cece5032f5.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "chensong@tj.kylinos.cn" <chensong@tj.kylinos.cn>



On 2021/4/23 下午7:10, Bezdeka, Florian wrote:
> On Wed, 2021-04-21 at 16:33 +0800, Song Chen wrote:
>> From: chensong <chensong@tj.kylinos.cn>
>>
>> Add a syscall specific for clock_gettime with 64bit
>> time_t.
>>
>> Signed-off-by: chensong <chensong@tj.kylinos.cn>
>>
>> ---
>> v5:
>> 1, new helper __cobalt_clock_gettime64
>> ---
>>   include/cobalt/kernel/time.h    | 11 +++++++++++
>>   include/cobalt/uapi/syscall.h   |  1 +
>>   kernel/cobalt/posix/clock.c     | 23 ++++++++++++++++++++++-
>>   kernel/cobalt/posix/clock.h     |  6 ++++++
>>   kernel/cobalt/posix/syscall32.c |  8 ++++++++
>>   kernel/cobalt/posix/syscall32.h |  4 ++++
>>   kernel/cobalt/time.c            | 11 +++++++++++
>>   7 files changed, 63 insertions(+), 1 deletion(-)
>>
>> +COBALT_SYSCALL(clock_gettime64, current,
>> +	       (clockid_t clock_id, struct __kernel_timespec __user *u_ts))
>> +{
>> +	return __cobalt_clock_gettime64(clock_id, u_ts);	
> 
> Whitespace at end of line! Will fix it up in my tree.

sorry, i did checkpatch each time, probably missed it this time.
thanks for fixing it up.

Song
> 
>>
>> +COBALT_SYSCALL32emu(clock_gettime64, current,
>> +		    (clockid_t clock_id,
>> +		     struct __kernel_timespec __user *u_ts))
>> +{
>> +	return __cobalt_clock_gettime64(clock_id, u_ts);	
> 
> WS at EOL again. Will fix it up in my tree.
> 
> 
>> +}
>>
> 


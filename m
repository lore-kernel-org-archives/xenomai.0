Subject: Re: [RFC PATCH v2 2/4] y2038: Adding sem_timedwait_time64
References: <87h7lqzzzw.fsf@xenomai.org>
 <20210308170206.313181-1-florian.bezdeka@siemens.com>
 <20210308170206.313181-3-florian.bezdeka@siemens.com>
 <d28c9144-a339-f3a0-0b4b-564073b25ad5@siemens.com>
 <e607edd1cf3ea18cdcd758bfbfa08f8233e4ccba.camel@siemens.com>
 <7a4aaa493fe5afbea25722bc2a04f7d91fc71275.camel@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <60489562.3010809@tj.kylinos.cn>+EDDC467B3A7A983E
Date: Wed, 10 Mar 2021 17:46:10 +0800
MIME-Version: 1.0
In-Reply-To: <7a4aaa493fe5afbea25722bc2a04f7d91fc71275.camel@siemens.com>
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
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>, "rpm@xenomai.org" <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "chensong@kylinos.cn" <chensong@kylinos.cn>



On 2021年03月10日 15:51, florian.bezdeka--- via Xenomai wrote:
> On Tue, 2021-03-09 at 07:53 +0000, florian.bezdeka--- via Xenomai
> wrote:
>> On Mon, 2021-03-08 at 19:28 +0100, Jan Kiszka wrote:
>>> On 08.03.21 18:02, Florian Bezdeka wrote:
>>>> Implementation is heavily inspired by the sem_timedwait syscall,
>>>> but expecting time64 based timespec / timeout.
>>>>
>>>> [snip]
>>>> @@ -82,6 +83,28 @@ static inline int cobalt_strncpy_from_user(char *dst, const char __user *src,
>>>>   	return __xn_strncpy_from_user(dst, src, count);
>>>>   }
>>>>
>>>> +static inline int cobalt_get_timespec64(struct timespec64 *ts,
>>>> +				const struct __kernel_timespec __user *uts)
>>>> +{
>>>> +	struct __kernel_timespec kts;
>>>> +	int ret;
>>>> +
>>>> +	ret = cobalt_copy_from_user(&kts, uts, sizeof(kts));
>>>> +	if (ret)
>>>> +		return -EFAULT;
>>>> +
>>>> +	ts->tv_sec = kts.tv_sec;
>>>> +
>>>> +	/* Zero out the padding in compat mode */
>>>> +	if (in_compat_syscall())
>>>> +		kts.tv_nsec &= 0xFFFFFFFFUL;
>>>> +
>>>> +	/* In 32-bit mode, this drops the padding */
>>>> +	ts->tv_nsec = kts.tv_nsec;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>
>>> Why inline? But that question is likely obsolete when we can avoid the
>>> code duplication below.
>>
>> Inline can be removed. Something for v3. There will follow more calls
>> to that helper. All syscalls reading a struct timespec from userspace
>> will have to use it.
>>>>
>
> I was following the pattern of all the other struct timespec64 heplers
> introduced by Philippe here. So "static inline". Removing "inline" now
> throws some warnings (at least on gcc 10), because the function is
> unused in this file.
>
> So my question is now: Where should this function reside?
>
> Linux pattern: kernel/time/time.c (where get_timespec64 resides)
> Xenomai path would be kernel/cobalt/time.c
>
> This is the last thing I have to address. A non RFC series will follow
> afterwards, based on Philippe's tree.
>
> @Song: My hope was this series can be used as pattern, to start
> integration of all the other remaining parts. What do you think? Is
> that sufficient?

This series look good to me and i'm following it to work on my patches.

Song
> -
>




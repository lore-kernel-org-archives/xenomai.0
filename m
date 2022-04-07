Message-ID: <ed782d4c-544d-8d10-d53f-4c95f017ce3d@siemens.com>
Date: Thu, 7 Apr 2022 21:33:33 +0200
MIME-Version: 1.0
Subject: Re: 5.10-dovetail regression?
Content-Language: en-US
References: <48e0fc4f-0020-907c-136e-53f01e596fda@siemens.com>
 <874k34gbk8.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <874k34gbk8.fsf@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 07.04.22 17:24, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> Hi Philippe,
>>
>> does this already ring some bell?
>>
>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/419210
>>
>> Only triggers with qemu-amd64, not on real HW and not with 5.15.
>>
> 
> I could not reproduce locally, but visual inspection revealed something
> fishy in #8e2c09ee5323. Could you try this on the failing kernel? TIA,
> 
> diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
> index 2651c6cfd034..da6735d45a8a 100644
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -644,8 +644,8 @@ void clockevents_exchange_device(struct clock_event_device *old,
>  		 * to the release list, keep it around but mark it as
>  		 * reserved.
>  		 */
> +		list_del(&old->list);
>  		if (tick_check_is_proxy(new)) {
> -			list_del(&old->list);
>  			clockevents_switch_state(old, CLOCK_EVT_STATE_RESERVED);
>  		} else {
>  			clockevents_switch_state(old, CLOCK_EVT_STATE_DETACHED);
> 

Didn't reproduce locally for me as well, though using the same image.
But the patch helped on the CI system.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


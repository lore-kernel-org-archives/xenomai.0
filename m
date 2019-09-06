Subject: Re: [PATCH v4 2/2] cobalt/rtdm: allow for device teardown
References: <65ac2255-6651-1ef0-49aa-b40092b7512e@siemens.com>
 <fe4daa26-0818-d866-a707-d5e04a36fb0c@siemens.com>
 <67380ec5-cdf4-659e-6a7f-989f1e1f5c2a@xenomai.org>
 <c33eb899-357a-8b2e-25f5-c10551d79613@siemens.com>
 <4f2d7a55-68fe-c071-3bec-c81b52973fbc@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <57bc5c06-f2a0-8246-6a86-1764584074a2@siemens.com>
Date: Fri, 6 Sep 2019 18:16:15 +0200
MIME-Version: 1.0
In-Reply-To: <4f2d7a55-68fe-c071-3bec-c81b52973fbc@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>, Quirin Gylstorff <quirin.gylstorff@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06.09.19 18:09, Philippe Gerum wrote:
> On 9/6/19 5:43 PM, Jan Kiszka wrote:
>> On 06.09.19 16:52, Philippe Gerum via Xenomai wrote:
>>> On 9/4/19 4:44 PM, Quirin Gylstorff via Xenomai wrote:
>>>>
>>>> I tested xenomai-next with xeno-test on 4.19.66+ amd64.
>>>> This patch triggers a general protection fault during the execution of
>>>> xeno-test. The log is attached.
>>>>
>>> Ok, I'll have a look. Thanks.
>>>
>>
>> I've started to dig into this a bit already but got distracted multiple
>> times. One thing I already found out: It's not a good idea to close the
>> fd on unregister without also ensuring that it's no longer pending in
>> rtdm_fd_cleanup_queue. But fixing that does not resolve the issue we see
>> with the test case.
>>
>> Jan
>>
> 
> There is that stupid bug at least:
> 
> diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
> index ea72be15c..64767a3ef 100644
> --- a/kernel/cobalt/rtdm/device.c
> +++ b/kernel/cobalt/rtdm/device.c
> @@ -548,6 +548,8 @@ void rtdm_dev_unregister(struct rtdm_device *dev)
>   
>   	xnlock_get_irqsave(&nklock, s);
>   	for (;;) {
> +		if (list_empty(&dev->openfd_list))
> +			break;
>   		fd = list_get_entry(&dev->openfd_list, struct rtdm_fd, next);
>   		if (fd == NULL)
>   			break;
> 

Then you can also drop that NULL check - list_get_entry never returns NULL.

I'll remove the commit from next so that you can send a v5.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


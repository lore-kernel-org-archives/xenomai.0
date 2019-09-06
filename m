Subject: Re: [PATCH v4 2/2] cobalt/rtdm: allow for device teardown
References: <65ac2255-6651-1ef0-49aa-b40092b7512e@siemens.com>
 <fe4daa26-0818-d866-a707-d5e04a36fb0c@siemens.com>
 <67380ec5-cdf4-659e-6a7f-989f1e1f5c2a@xenomai.org>
 <c33eb899-357a-8b2e-25f5-c10551d79613@siemens.com>
 <4f2d7a55-68fe-c071-3bec-c81b52973fbc@xenomai.org>
 <0b22dfd6-5b8c-71b2-dfca-bf62c5b7177c@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a4ac1c99-a079-a0d7-e4f4-655b1525bdf9@xenomai.org>
Date: Fri, 6 Sep 2019 18:17:30 +0200
MIME-Version: 1.0
In-Reply-To: <0b22dfd6-5b8c-71b2-dfca-bf62c5b7177c@xenomai.org>
Content-Type: text/plain; charset=utf-8
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Quirin Gylstorff <quirin.gylstorff@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 9/6/19 6:12 PM, Philippe Gerum via Xenomai wrote:
> On 9/6/19 6:09 PM, Philippe Gerum via Xenomai wrote:
>> On 9/6/19 5:43 PM, Jan Kiszka wrote:
>>> On 06.09.19 16:52, Philippe Gerum via Xenomai wrote:
>>>> On 9/4/19 4:44 PM, Quirin Gylstorff via Xenomai wrote:
>>>>>
>>>>> I tested xenomai-next with xeno-test on 4.19.66+ amd64.
>>>>> This patch triggers a general protection fault during the execution of
>>>>> xeno-test. The log is attached.
>>>>>
>>>> Ok, I'll have a look. Thanks.
>>>>
>>>
>>> I've started to dig into this a bit already but got distracted multiple
>>> times. One thing I already found out: It's not a good idea to close the
>>> fd on unregister without also ensuring that it's no longer pending in
>>> rtdm_fd_cleanup_queue. But fixing that does not resolve the issue we see
>>> with the test case.
>>>
>>> Jan
>>>
>>
>> There is that stupid bug at least:
>>
>> diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
>> index ea72be15c..64767a3ef 100644
>> --- a/kernel/cobalt/rtdm/device.c
>> +++ b/kernel/cobalt/rtdm/device.c
>> @@ -548,6 +548,8 @@ void rtdm_dev_unregister(struct rtdm_device *dev)
>>  
>>  	xnlock_get_irqsave(&nklock, s);
>>  	for (;;) {
>> +		if (list_empty(&dev->openfd_list))
>> +			break;
>>  		fd = list_get_entry(&dev->openfd_list, struct rtdm_fd, next);
>>  		if (fd == NULL)
>>  			break;
>>
> 
> a second one involves a double release of an rtdm_fd from the openfd_list.
> 

not a double release in fact, but some fd lingers preventing the
unregister to complete. So reference count issue likely.

-- 
Philippe.


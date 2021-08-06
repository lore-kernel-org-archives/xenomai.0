Subject: Re: [PATCH 2/2] testsuite/smokey: net_client: skip late packet error
 in vm mode
References: <20210804024714.665-1-hongzhan.chen@intel.com>
 <20210804024714.665-2-hongzhan.chen@intel.com>
 <28fa1684-0e42-0879-234e-7eec12badf8c@siemens.com>
 <BN9PR11MB5227C79511DAA168FD36270EF2F29@BN9PR11MB5227.namprd11.prod.outlook.com>
 <04498083-5659-5a4b-abfe-2d96da8b359c@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55e8bcef-496d-0e06-8f37-fb4a723d6eed@siemens.com>
Date: Fri, 6 Aug 2021 09:41:56 +0200
MIME-Version: 1.0
In-Reply-To: <04498083-5659-5a4b-abfe-2d96da8b359c@siemens.com>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05.08.21 07:01, Jan Kiszka via Xenomai wrote:
> On 05.08.21 02:39, Chen, Hongzhan wrote:
>>
>>
>>> -----Original Message-----
>>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>>> Sent: Wednesday, August 4, 2021 6:20 PM
>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>>> Subject: Re: [PATCH 2/2] testsuite/smokey: net_client: skip late packet error in vm mode
>>>
>>> On 04.08.21 04:47, Hongzhan Chen via Xenomai wrote:
>>>> In vm mode, skip late packet error in functional test to avoid
>>>> test failure.
>>>>
>>>> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>>>>
>>>> diff --git a/testsuite/smokey/net_common/client.c b/testsuite/smokey/net_common/client.c
>>>> index d13d72918..752ea55ed 100644
>>>> --- a/testsuite/smokey/net_common/client.c
>>>> +++ b/testsuite/smokey/net_common/client.c
>>>> @@ -204,7 +204,7 @@ static int smokey_net_client_loop(struct smokey_net_client *client)
>>>>  		} while (err != -ETIMEDOUT);
>>>>  	}
>>>>  
>>>> -	if (glost || glate)
>>>> +	if (glost || (!smokey_on_vm && glate))
>>>>  		fprintf(stderr, "RTnet %s test failed", client->name);
>>>>  	if (glost) {
>>>>  		if (glost == limit)
>>>> @@ -214,11 +214,11 @@ static int smokey_net_client_loop(struct smokey_net_client *client)
>>>>  			fprintf(stderr, ", %Lu packets lost (%g %%)",
>>>>  				glost, 100.0 * glost / limit);
>>>>  	}
>>>> -	if (glate)
>>>> +	if (!smokey_on_vm && glate)
>>>>  		fprintf(stderr, ", %Lu overruns", glate);
>>>
>>> I think we can keep this report, just not mark the test failed in case
>>> of smokey_on_vm.
>>
>> But this string printed out here looks like ugly  in case of smokey_on_vm., do we need to change something ?
>> How about :
>>
>> if (!smokey_on_vm && glate)
>>           fprintf(stderr, "there is %Lu overruns", glate);
>> else if (glate)
>>          fprintf(stderr, ", %Lu overruns", glate);
>>
> 
> Hmm, what is the difference?
> 

OK, sorry, now I see the relevance. Applied this one.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


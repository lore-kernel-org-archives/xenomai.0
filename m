References: <954f3936-9906-a33e-4d6a-fa5e640430e4@xenomai.org>
 <bb013c41-9b90-4bc1-a84a-6e5137061ceb@alaxarxa.net>
 <20f31474-8d30-fad7-c79d-bd4cf03295ae@xenomai.org>
 <56e8674c-9744-3bf4-ba7a-b3df1fd113fa@alaxarxa.net>
 <657c0db4-6cb8-5876-3349-cd784ba69077@siemens.com>
 <7c3bd3a0-5d08-f1c9-1b39-1457b0826856@xenomai.org>
 <b8766709-ab3c-b6a8-c539-77343ca5aca1@siemens.com>
 <bde2e3b7-94a3-57bd-c33f-fac7bdcfb0be@xenomai.org>
 <1ca2dd05-123b-7d95-60ef-cd24156420eb@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <aa6f5c4c-7083-63f9-20aa-fb9929823065@siemens.com>
Date: Mon, 18 Dec 2017 07:33:27 +0100
MIME-Version: 1.0
In-Reply-To: <1ca2dd05-123b-7d95-60ef-cd24156420eb@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTnet fixes - testers needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Leopold Palomo-Avellaneda <leo@alaxarxa.net>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 2017-12-15 21:42, Philippe Gerum wrote:
> On 12/15/2017 02:48 PM, Philippe Gerum wrote:
>> On 12/15/2017 02:40 PM, Jan Kiszka wrote:
>>> On 2017-12-15 14:29, Philippe Gerum wrote:
>>>> On 12/15/2017 02:20 PM, Jan Kiszka wrote:
>>>>> On 2017-12-15 13:25, Leopold Palomo-Avellaneda wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I forgot something more:
>>>>>>
>>>>>> On 15/12/17 12:04, Philippe Gerum wrote:
>>>>>>
>>>>>> [...]
>>>>>>>>
>>>>>>>> I guess that there's something in the kernel config or somewhere in 3.x that
>>>>>>>> affects the PCI cards. In 2.6.x worked.
>>>>>>>
>>>>>>> On x86, I'd dare to say that it worked mostly by accident, as revealed
>>>>>>> by SMAP later on. RTnet was out of the Xenomai tree in 2.6.x, some
>>>>>>> changes introduced during the merge into 3.x might have caused
>>>>>>> regressions, or maybe some latent issues started to bite when transposed
>>>>>>> in a different environment, just like the SMAP problem on x86, revealing
>>>>>>> an ancient Rnet bug. I genuinely don't know when things started to hit
>>>>>>> the fan.
>>>>>>
>>>>>> I don't know if it's relevant or not, or I didn't understand it, but I think
>>>>>> that I still have problems with SMAP. If I activate it, I got:
>>>>>
>>>>> You must leave SMAP off until someone develops patches to convert the
>>>>> complete RTnet userspace API over to rtdm_copy_to/from_user.
>>>>>
>>>>
>>>> The patches in wip/rtnet-fixes address this issue, this is the patch
>>>> series I was referring to in this discussion.
>>>>
>>>
>>> Hmm, for the protocol core. I suspect you are missing further cases in
>>> RTmac and RTcfg (provided anyone needs them).
>>>
>>
>> The author of ioctl* support in both cases used copy_from_user directly,
>> maybe that is a problem with the calling mode. Ok, I'll check whether
>> rtnet_ioctls dispatcher actually routes from ioctl_nrt. Thanks.
>>
> 
> RTcfg and RTmac are fine in the wip/rtnet-fixes branch. The rtnet_ioctls
> dispatcher runs over a regular ioctl_unlocked context from a chrdev, so
> there is no mode issue. All user memory is accessed via copy_to/from
> routines. I see no sendmsg/recvmsg which could raise the SMAP issue there.
> 
> Do you have any hint about those missing cases?
> 

Nope, those two indeed seem to be fine. I didn't remember that we wrote
them with proper copy_to/from, also for the RT part (tdma_dev.c). The
core has a different, longer history, lacking any usercopy from day #1.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux


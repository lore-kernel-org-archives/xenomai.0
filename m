Subject: Re: Preview: 4.19-x86 support
References: <4a035faa-d1f8-d2ed-9351-192cea2d79eb@siemens.com>
 <20190621180432.483ea4a0@md1za8fc.ad001.siemens.net>
 <7b7ff8c9-0faa-2a9b-5347-ee5361a978d0@siemens.com>
 <20190624131858.41860152@md1za8fc.ad001.siemens.net>
 <ced098bf-d5fc-6dc0-cc82-05a5eec1c45b@siemens.com>
 <20190627155612.32bfc242@md1za8fc.ad001.siemens.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <018eeba9-c186-89d6-b152-ba12959c3a9f@siemens.com>
Date: Thu, 27 Jun 2019 18:50:30 +0200
MIME-Version: 1.0
In-Reply-To: <20190627155612.32bfc242@md1za8fc.ad001.siemens.net>
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
To: Henning Schild <henning.schild@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 27.06.19 15:56, Henning Schild via Xenomai wrote:
> Am Mon, 24 Jun 2019 13:29:16 +0200
> schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> 
>> On 24.06.19 13:18, Henning Schild wrote:
>>> Am Mon, 24 Jun 2019 08:32:24 +0200
>>> schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>>>    
>>>> On 21.06.19 18:04, Henning Schild via Xenomai wrote:
>>>>> Hi Jan,
>>>>>
>>>>> works fine. The only thing that did not was the gdb smokey test.
>>>>>       
>>>>>> FAILURE run_gdb:288: checking expression "primary_mode", expected
>>>>>> "$", found "N"
>>>>>
>>>>> did not look into where this came from.
>>>>
>>>> OK, didn't see that so far. Did you only see this on 4.19 so far,
>>>> ie. did you test 4.14 or older with master recently?
>>>
>>> Switches from stable to master for just this one, so can not tell.
>>>    
>>>>>
>>>>> Tested todays master but think the 4.19 changes should be
>>>>> backported to stable as well.
>>>>
>>>> I'm not planning for that due to the number of changes involved.
>>>> 3.1 will come out "soon", and that is for newer kernels.
>>>
>>> Ok.
>>>    
>>>>>
>>>>> I also ran into an smb issue from upstream, which is fixed there.
>>>>> So i think this should be rebased on latest 4.19 eventually. Or
>>>>> leave it on 33 and merge for the first release.
>>>>
>>>> Which one exactly?
>>>
>>> 37, but is there anything from preventing 55?
>>
>> I was referring to the concrete issue, or commit. I will rebase, I
>> just wanted to reduce the number of variables during the initial
>> stabilization.
> 
> upstream 088aaf17aa79300cab14dbee2569c58cfafd7d6e
> stable c69330a855ab4342d304f67f8c1e7d1fa2686bec
> 

Ah, SMB - I've read SMP and was expecting some thrilling patch.

BTW, regarding the failing smokey gdb test: Check if gdb is available on the 
target. That is now a precondition.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


Subject: Re: [I-PIPE] ipipe-core-4.14.89-x86-2 released
References: <E1gaKub-0002DE-4r@xenomai.org>
 <1368965303.3936165.1545600892860@mail.yahoo.com>
 <91ae88c0-4fb5-9e98-e08b-669ffe607bd1@xenomai.org>
 <7d356b91-90bb-ddd1-30a4-9b52ac362e62@web.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <123395f3-a80e-c883-3fea-f3a6a5c39ed5@siemens.com>
Date: Mon, 28 Jan 2019 12:22:17 +0100
MIME-Version: 1.0
In-Reply-To: <7d356b91-90bb-ddd1-30a4-9b52ac362e62@web.de>
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
To: Philippe Gerum <rpm@xenomai.org>, Alec Ari <neotheuser@ymail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, Henning Schild <henning.schild@siemens.com>

On 27.12.18 17:17, Jan Kiszka via Xenomai wrote:
> On 24.12.18 11:06, Philippe Gerum via Xenomai wrote:
>> On 12/23/18 10:34 PM, Alec Ari via Xenomai wrote:
>>> Hello,
>>>
>>>
>>> I'm not sure if the patch generator was believed to be fixed yet or not, but 
>>> files for other arches (arch/arm/include/asm/arch_timer.h) are still 
>>> included. If this still being worked on, disregard this message.
>>>
>>>
>>
>> The upstream tree at https://gitlab.denx.de/Xenomai/ipipe-x86 still
>> exports I-pipe bits for multiple architectures (at least for x86 and
>> arm) but does not include scripts/ipipe/genpatches.sh, so the generator
>> does a plain diff, assuming a single-arch tree.
>>
>> The ARM bits are likely left-overs and should be dropped to fix the tree.
>>
> 
> Going through the commits, it seems we have a couple of ARM-only driver and 
> timer patches in the x86 tree but no general ARM enabling. Those should be 
> removed, indeed.

In fact, the problem is imported from ipipe-noarch: There are many ARM-related 
driver changes that, strictly spoken, do not belong into the noarch tree. Some 
touch arch/arm, others just change drivers that are practically ARM-only.

Philippe, do we want to remove those commits from noarch and add them to ARM? Or 
should we filter out arch-unrelated diffs when generating the patches?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


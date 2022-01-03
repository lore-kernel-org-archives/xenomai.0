Message-ID: <1f17f246-7752-831b-98fd-5796ffd19883@siemens.com>
Date: Mon, 3 Jan 2022 19:22:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 9/9] cobalt/debug: Detect vDSO via absence of vm_file
Content-Language: en-US
References: <cover.1634126152.git.jan.kiszka@siemens.com>
 <24c44d412bea623b3815e0b82428c7201e46a6b0.1634126152.git.jan.kiszka@siemens.com>
 <d0a16015-46ad-efd7-e886-b3304726a9d0@siemens.com>
 <4309fc6a-058e-143d-01b7-a60fc00e6953@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <4309fc6a-058e-143d-01b7-a60fc00e6953@siemens.com>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org

On 03.01.22 19:04, Jan Kiszka via Xenomai wrote:
> On 03.01.22 17:34, Florian Bezdeka wrote:
>> On 13.10.21 13:55, Jan Kiszka via Xenomai wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> VM_DENYWRITE was removed in 5.15, so we need a different criteria.
>>> Absence of a file-backing seems to be a good one.
>>
>> Bringing this one up, because we recently had a "report" on the ML
>> regarding VM_DENYWRITE.
>>
>> I scanned the ld (dynamic loader) sources today. I was interested if
>> there is any magic involved when mapping DSOs to the vma of the process.
>> AFAICT there is none. I would expect the vma to be file-backed
>> (=vma->vm_file =! NULL), so not sure if that is going to work.
> 
> Then likely not.
> 
>>
>> Btw: Subject talks about vDSO, which is not what we are looking at here.
> 
> Yeah, misnomer of mine.
> 
>>
>> Just to make sure I got all that right: We need a way to figure out if
>> the reason for the thread relax was caused by the executable itself, or
>> any of it's dependencies, right?
> 
> The purpose is to calculate the correct PC value that makes sense and is
> useful for the userspace helper:
> 
>          * We compute PC values relative to the base of the shared
>          * executable mappings we find in the backtrace, which makes
>          * it possible for the slackspot utility to match the
>          * corresponding source code locations from unrelocated file
>          * offsets.
> 

Looking at the slackspot tool: We run addr2line for each spot that has a
mapping, thus executable name, and we pass in relative addresses then.
For the others, we just print the true PC value as recording and as NOT
adjusted. So my logic was at least wrong in being inverted. It should
work for telling DSOs apart from interpreter-created executable
sections. Not sure about other "executables", though.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


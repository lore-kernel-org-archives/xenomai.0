Message-ID: <df64fe08-f1f6-b3ac-3509-4f27b1d21b56@siemens.com>
Date: Wed, 13 Oct 2021 10:07:06 +0200
Subject: Re: [xenomai-images][PATCH 1/6] ci: Introduce kas option file for CI
 builds
Content-Language: en-US
References: <20211013071824.9394-1-florian.bezdeka@siemens.com>
 <20211013071824.9394-2-florian.bezdeka@siemens.com>
 <527dc285-07c7-1035-1240-d8f52bfbe412@siemens.com>
 <76aa8787-a60c-8394-30ed-3c158eda3a83@siemens.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <76aa8787-a60c-8394-30ed-3c158eda3a83@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 13.10.21 09:50, Florian Bezdeka via Xenomai wrote:
> On 13.10.21 09:26, Jan Kiszka wrote:
>> On 13.10.21 09:18, Florian Bezdeka via Xenomai wrote:
>>> For now the difference between the demo and the "ci image" is:
>>>  - Removed sshd-regen-keys: Reduces the (first) boot time especially on
>>>    low end CI hardware. Helps to stay within LAVA timeouts.
>>
>> opt-lava-test.yml?
> 
> I tried to avoid "product" names like LAVA. So it's opt-test.yml vs.
> opt-ci.yml. Which one do you prefer?
> 
>>
>>>
>>>  - Removed expand-on-first-boot: Doesn't make much sense on CI runs as
>>>    we don't really use the filesystem. Helps to reduce the first boot
>>>    time a bit.
>>
>> That should rather be attached to the image format. If building lava
>> (opt-lava-test.yml) or qemu (opt-ext4-gz.yml), it does not make sense
>> and should go.
> 
> That makes sense. Will do.
> 

Already done. The qemu machine config already has it. So the only place
where we need it is for CI / test boards, which is opt-ci.yml or
opt-test.yml.

>>
>> Jan
>>
> 
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


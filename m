Subject: Re: [RFC] status of [meta-]xenomai for Yocto
References: <878s4vu52u.fsf@xenomai.org>
 <20210503191615.7fc657ee@md1za8fc.ad001.siemens.net>
 <8f674099-6e29-b4b4-ba2e-b56214b63b47@siemens.com>
From: Stefano Babic <sbabic@denx.de>
Message-ID: <19cb0eef-993b-3499-f906-aadb0e9015ef@denx.de>
Date: Wed, 5 May 2021 10:19:50 +0200
MIME-Version: 1.0
In-Reply-To: <8f674099-6e29-b4b4-ba2e-b56214b63b47@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Henning Schild <henning.schild@siemens.com>, Philippe Gerum via Xenomai <xenomai@xenomai.org>

Hi Philippe, Jan, Henning,

On 03.05.21 19:30, Jan Kiszka via Xenomai wrote:
> On 03.05.21 19:16, Henning Schild via Xenomai wrote:
>> We have xenomai-images kind of maintained under the umbrella of the
>> project. But that is Isar and Yocto sure has its place as well. I have
>> also seen buildroot layers which include xenomai.
>>
>> Such integration systems tend to cause a lot of work. A project like
>> xenomai probably wants to be "very close" to one of them to allow
>> continous testing. We have that internally based on Isar and i think
>> Intel might be going the same way.
>>
>> Not against the idea, but also not convinced.
>>
> 
> Was about to express the same concern: Who will test that those
> preintegrations still work, produce reasonable results? If people stand
> up and say, "hey, I'm doing that anyway already, will take care of
> this!", then this could work.
> 

I had to integrate a couple of time Xenomai in a Yocto build and I had 
thought about if it is worth to start a "meta-xemnomai". But after that, 
supporting Xenomai in Yocto means two main things:

- add support for Xenomai libs and tools. Well, this is a single recipe 
(at least in my build).
- patch the kernel running scripts/prepare-kernel.sh.

And as we can use just LTS kernel, the second one means to add a new 
provider for kernel, let's say a linux-xenomai recipe.

But then, that's all. I do not know if this it is enough to add an own 
meta-xenomai and to maintain it.

Could be an alternative path to try to push the required recipes 
(kernel+libs) to OE-Core, exactly as it was done by Preemp-rt ? Recipes 
are then part of a standard layer, and I see as advantage that they can 
be shown by much more people and could help to advertise Xenomai.

Best regards,
Stefano

> And then the next aspect would be how to make generic assets like kernel
> configurations and integration reusable for xenomai-images, and vice versa.
> 
> Jan
> 
>> regards,
>> Henning
>>
>> Am Mon, 3 May 2021 18:58:49 +0200
>> schrieb Philippe Gerum via Xenomai <xenomai@xenomai.org>:
>>
>>> I'd like to discuss the current status of what exists, what might be
>>> planned regarding a meta layer which would/does provide support for
>>> Xenomai-enabled kernels. This could be a topic raised during the next
>>> community meeting.
>>>
>>> I can see a couple of options floating around on the net, all
>>> dedicated to specific hardware it seems, some/all extending their
>>> support up to the rootfs image.
>>>
>>> Would it be possible to conceive such support as a meta-bsp layer
>>> instead, implementing a new kernel type, one that could be included in
>>> bbconf settings without imposing anything about the image to be
>>> produced?  Something which could be extended to cover Xenomai 4/EVL at
>>> some point as well.
>>>
>>> It would be nice to discuss ideas around the general topic of having a
>>> reference meta layer for Xenomai in the most flexible way. Whether it
>>> already exists, or not.
>>>
>>
>>
> 


-- 
=====================================================================
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================


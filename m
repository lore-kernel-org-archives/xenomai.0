Subject: Re: [RFC] status of [meta-]xenomai for Yocto
References: <878s4vu52u.fsf@xenomai.org>
 <20210503191615.7fc657ee@md1za8fc.ad001.siemens.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8f674099-6e29-b4b4-ba2e-b56214b63b47@siemens.com>
Date: Mon, 3 May 2021 19:30:38 +0200
MIME-Version: 1.0
In-Reply-To: <20210503191615.7fc657ee@md1za8fc.ad001.siemens.net>
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
To: Henning Schild <henning.schild@siemens.com>, Philippe Gerum via Xenomai <xenomai@xenomai.org>

On 03.05.21 19:16, Henning Schild via Xenomai wrote:
> We have xenomai-images kind of maintained under the umbrella of the
> project. But that is Isar and Yocto sure has its place as well. I have
> also seen buildroot layers which include xenomai.
> 
> Such integration systems tend to cause a lot of work. A project like
> xenomai probably wants to be "very close" to one of them to allow
> continous testing. We have that internally based on Isar and i think
> Intel might be going the same way.
> 
> Not against the idea, but also not convinced.
> 

Was about to express the same concern: Who will test that those
preintegrations still work, produce reasonable results? If people stand
up and say, "hey, I'm doing that anyway already, will take care of
this!", then this could work.

And then the next aspect would be how to make generic assets like kernel
configurations and integration reusable for xenomai-images, and vice versa.

Jan

> regards,
> Henning
> 
> Am Mon, 3 May 2021 18:58:49 +0200
> schrieb Philippe Gerum via Xenomai <xenomai@xenomai.org>:
> 
>> I'd like to discuss the current status of what exists, what might be
>> planned regarding a meta layer which would/does provide support for
>> Xenomai-enabled kernels. This could be a topic raised during the next
>> community meeting.
>>
>> I can see a couple of options floating around on the net, all
>> dedicated to specific hardware it seems, some/all extending their
>> support up to the rootfs image.
>>
>> Would it be possible to conceive such support as a meta-bsp layer
>> instead, implementing a new kernel type, one that could be included in
>> bbconf settings without imposing anything about the image to be
>> produced?  Something which could be extended to cover Xenomai 4/EVL at
>> some point as well.
>>
>> It would be nice to discuss ideas around the general topic of having a
>> reference meta layer for Xenomai in the most flexible way. Whether it
>> already exists, or not.
>>
> 
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


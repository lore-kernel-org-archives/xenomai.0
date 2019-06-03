Subject: Re: Xenomai arm64 plans?
References: <fb2b5a6b-007e-9f2c-bcac-8df84fbaac84@theobroma-systems.com>
 <96f3c66c-816c-b2d8-071e-198488ad05be@siemens.com>
 <f735da35-123d-7352-46ec-420998540d61@theobroma-systems.com>
 <c888624bb653433ca2ab49bfef71f85f@NANS01204.it.intra.sercel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cd06c26e-6923-804b-fb38-6e7afa444b93@siemens.com>
Date: Mon, 3 Jun 2019 19:16:45 +0200
MIME-Version: 1.0
In-Reply-To: <c888624bb653433ca2ab49bfef71f85f@NANS01204.it.intra.sercel.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: MINIER Bertrand <Bertrand.MINIER@sercel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03.06.19 18:24, MINIER Bertrand via Xenomai wrote:
> Hi all,
> 
> Is there updated plans for a Xenomai release which includes arm64 ?
> Are there still blocking issues to not officially support it ?
> We are about to start the development of an industrial product based on an arm64 SoC and we would like to secure our choice of using Xenomai for that product.

ARM64 shall be officially supported by the next major Xenomai release, 3.1. That 
one is not delayed because auf ARM64, but rather because I'd like to integrate 
one major core feature beforehand (reminds me of reminding to provide feedback 
on that) and make sure that 4.19 support for the main archs brings no frictions 
(that is looking good I would say).

Jan

> 
> Thanks,
> 
> Bertrand Minier
> 
> -----Message d'origine-----
> De : Xenomai <xenomai-bounces@xenomai.org> De la part de via Xenomai
> Envoyé : vendredi 2 novembre 2018 17:30
> À : Jan Kiszka <jan.kiszka@siemens.com>
> Cc : xenomai@xenomai.org
> Objet : Re: Xenomai arm64 plans?
> 
> 
> 
> On 11/2/18 5:25 PM, Jan Kiszka wrote:
>> On 02.11.18 17:19, Christoph Müllner wrote:
>>> Hi Jan,
>>>
>>> I was wondering if there are any plans for a Xenomai release, which
>>> includes arm64.
>>
>> Yes, there are. The exact timeline is not settled yet, but somewhere
>> within the next month, I would say.
> 
> That's excellent news!
> 
>>> I'm familiar with the next branch, but I'd love to work with code
>>> from a branch, which is not subject to force-pushing.
>>
>> Actually there was a change: next is still potentially rebasing as I'm
>> integrating over it and may - when things go wrong - pull back or
>> reorder in that queue. But master is back, and that is forward-only.
>> It's not comparable to a release but it could help to bridge the time
>> to v3.1.
> 
> Ok, thank's for clarifying that.
> 
> Thanks,
> Christoph
> 
> This e-mail and any accompanying attachments are confidential. If you are not the intended recipient, you must not review, disclose, copy, distribute or use this e-mail; please delete it from your system and notify the sender immediately.
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


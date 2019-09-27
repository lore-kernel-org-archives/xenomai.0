Subject: Re: Kernel compilation error
References: <09a04461befe7ec4cf65b9f1a46e70fe.squirrel@mail.ige-grenoble.fr>
 <9344a542-3ca7-ea83-4b4a-a744d1d48b39@siemens.com>
 <db08b3df5aeb7dfbde41bee64b7ff142.squirrel@mail.ige-grenoble.fr>
 <978cbf79-06bd-3fb0-2396-b83270f8d92e@siemens.com>
 <bf32fd5ce254f7ccd4647a159cc0ce6a.squirrel@mail.ige-grenoble.fr>
 <30171666-5b1f-e302-6110-8d6e3ad3bed5@siemens.com>
 <30e33520dda331361d39260f15ea4585.squirrel@mail.ige-grenoble.fr>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <e1ae79ae-5e01-f758-c89b-d4907d444397@web.de>
Date: Fri, 27 Sep 2019 15:07:15 +0200
MIME-Version: 1.0
In-Reply-To: <30e33520dda331361d39260f15ea4585.squirrel@mail.ige-grenoble.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: davy.regneau@univ-grenoble-alpes.fr, xenomai@xenomai.org
Cc: frederic.cazenave@ird.fr

On 26.09.19 17:47, Davy via Xenomai wrote:
>> On 06.09.19 15:38, davy.regneau@univ-grenoble-alpes.fr wrote:
>>>
>>>
>>> Hi Jan,
>>>
>>> Thank you for your quick reply. If I want to use the last stable relea=
se
>>> xenomai which kernel release I need to use ?
>>>
>>
>> We will soon release 3.1, then you can use 4.19 with an officially stab=
le
>> baseline. If you start now, that combination will have been released wh=
en
>> you
>> are done - unless you really need to release "tomorrow".
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>> Corporate Competence Center Embedded Linux
>>
>
> Hi,
>
> Thanks for Xenomai 3.1.
>
> I compliled the linux kernel 4.19.66 with xenomai 3.1-rc1. No errors
> appeared during it.
>
> When I try to boot with it I get stuck with the error :
> can't find IRQ for PCI INT A; probably buggy MP table
>
> I attach a image of the last messages before the freeze.
>
> Do you have any idea how do I can fix this ?
> I also send my .config
>

Does the error disappear when you disable Xenomai and I-pipe in the kernel
configuration?

Jan


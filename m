MIME-Version: 1.0
In-Reply-To: <CAPN7LrGyu_deQ1Jhg3wW+f7HPpAOmqE1AiRXDL7x=e=U2es=2A@mail.gmail.com>
References: <CAPN7LrHBjkFqi8x3KGmZDn810GuYTij4gpyQc1pxhFMiifdycQ@mail.gmail.com>
 <CAPN7LrGe_wmRLdbvdcznMMqeyo1PgbrZnyUKVCWbfZAuF+t75A@mail.gmail.com>
 <20180926142128.4a127510@md1pvb1c.ad001.siemens.net>
 <CAPN7LrFNhNHoyPBW387vC15GF4n7JKyUKqVR2f1wZ3an67XQPg@mail.gmail.com>
 <4cbf5f1c-0381-8fcd-9e52-1221ca8e1b11@siemens.com>
 <CAPN7LrGyu_deQ1Jhg3wW+f7HPpAOmqE1AiRXDL7x=e=U2es=2A@mail.gmail.com>
From: c ww <cww230@gmail.com>
Date: Thu, 27 Sep 2018 09:55:29 +0800
Message-ID: <CAPN7LrHhqfiK_uZKDL6Km0B1pVMmhaqYoyLB3q35r1hA0fji7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] ipipe 4.14 causing kernel stuck at "Loading initial
 ramdisk...", failed to boot on x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Henning Schild <henning.schild@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
Ignore this as i added autoconf package to make it work. I'll proceed and
see everything else working correctly.

Thanks!

On Thursday, September 27, 2018, c ww <cww230@gmail.com> wrote:

> Hi Jan,
>
> Yes, i did that but it gave an error 'autoreconf: not found'. Am i missing
> something else? Or the file could be missing in the 'next' branch?
>
> Appreciate your advise!
>
> On Thursday, September 27, 2018, Jan Kiszka <jan.kiszka@siemens.com>
> wrote:
>
>> On 26.09.18 18:01, c ww wrote:
>>
>>> Hi Henning,
>>> Awesome, now the kernel compilation looks great and no more fpu errors.
>>> But
>>> one thing i noticed, in the unreleased xenomai 'next' branch it seems the
>>> configure file is missing. In this case, are there different method to
>>> configure the xenomai prior to install it?
>>>
>>
>> When you work against the Xenomai git tree, you need to call
>> scripts/bootstrap first. It will generate the files that are only part of
>> the release tarball (we do not version-control generated artifacts).
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>> Corporate Competence Center Embedded Linux
>>
>

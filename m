Message-ID: <51BE9EC9.5090408@web.de>
Date: Mon, 17 Jun 2013 07:29:45 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <51B73421.3050506@siemens.com>
	<CAFNBfte827XTvCApOaGaUYVcj_uLn67Yz5=qBcY4pmAPEHVbvg@mail.gmail.com>
	<CAFNBftfCrsdrbgkfzAr5ngJtYJ2PvPtJZAA1ZdBAongHAdO4xw@mail.gmail.com>
In-Reply-To: <CAFNBftfCrsdrbgkfzAr5ngJtYJ2PvPtJZAA1ZdBAongHAdO4xw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Stable update for ipipe-3.8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Flavio Castro Alves Filho <flavio.alves@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-06-17 02:17, Flavio Castro Alves Filho wrote:
> Hello Jan,
> =

> I tried to build Linux kerne from your ipipe repository but the
> compilation crashed, when building for BeagleBone Black.
> =

> During the patch application, I got just one error, with the inclusion
> of a #include directive. I solved the problem by hand and then I had
> the compilation error.

Err, what did you apply against which kernel? The repository is supposed
to be used as-is. Or are there still additional, non-upstream patches
required for your board?

Jan

> =

> Unfortunately I had to reboot my machine and I could not give you the
> complete feedback. I intend to do that tomorrow. Sorry ...
> =

> Anyway, I would like to provide the feedback.
> =

> Best regards
> =

> Flavio
> =

> =

> 2013/6/12 Flavio Castro Alves Filho <flavio.alves@gmail.com>:
>> Hello,
>>
>> This weekend I'll try to test it with the current kernel version for
>> BeagleBone Black and I'll let you know about the results.
>>
>> Best regards,
>>
>> Flavio
>>
>>
>> 2013/6/11 Jan Kiszka <jan.kiszka@siemens.com>:
>>> Hi all,
>>>
>>> I've merged 3.8.13 into our stable 3.8 branch. This triggered some minor
>>> conflicts in generic and ARM code. Please see
>>>
>>> git://git.xenomai.org/ipipe-jki for-upstream/3.8
>>>
>>> for details. The result works fine for x86, and if it's also OK for the
>>> other arch, I'd propose this to be merged into the official 3.8 stable
>>> branch.
>>>
>>> Jan
>>>
>>> --
>>> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
>>> Corporate Competence Center Embedded Linux
>>>
>>> _______________________________________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> http://www.xenomai.org/mailman/listinfo/xenomai
>>
>>
>>
>> --
>> Flavio de Castro Alves Filho
>>
>> flavio.alves@gmail.com
>> www.linuxembarcado.com
>> Twitter: http://twitter.com/#!/fraviofii
>> LinkedIn profile: www.linkedin.com/in/flaviocastroalves
> =

> =

> =



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130617/0a5f70e=
f/attachment.pgp>

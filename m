Message-ID: <4C724935.9010700@domain.hid>
Date: Mon, 23 Aug 2010 12:11:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinWHLk2fc0qMygBOmgYpAAh88FbUAUFDq2DPRKL@mail.gmail.com>	<4C7232E6.8070709@domain.hid>	<AANLkTi=sOUgazTM-OxCsC6Za0y=ZkRoM1PC61ADx54+c@domain.hid>	<4C723CD4.60604@domain.hid>
	<AANLkTinLVrdOomSMqKX8NcmDPLuNMnofnZu_VupNXJz+@mail.gmail.com>
In-Reply-To: <AANLkTinLVrdOomSMqKX8NcmDPLuNMnofnZu_VupNXJz+@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai patch for AT91ARM9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Prakash A S <asprakash83@domain.hid>
Cc: xenomai@xenomai.org

Prakash A S wrote:
> On Mon, Aug 23, 2010 at 2:48 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> Prakash A S wrote:
>>> On Mon, Aug 23, 2010 at 2:05 PM, Gilles Chanteperdrix <
>>> gilles.chanteperdrix@xenomai.org> wrote:
>>>
>>>> Prakash A S wrote:
>>>>> Dear All,
>>>>>          Now I am working on AT91RM9200 based processor ARM board with
>>>> Linux
>>>>> 2.6.20 kernel and also planing to port Xenomai on this board. I
>> preferred
>>>>> xenomai-2.4.0. Because it has adeos-ipipe patch for 2.6.20 kernel.
>>>> However I
>>>>> found that there is an separate ipipe patch available for AT91
>> processor
>>>> in
>>>>> xenomai-2.3.2. Do I need any similar patch for xenomai-2.4.0 or
>>>>> adeos-ipipe-2.6.20-arm-1.802.patch is enough?.
>>>>>
>>>>> I beleive the steps will be like,
>>>>> linux-2.6.20+2.6.20-at91.patch.gz+adeos-ipipe-2.6.20-arm-1.802.patch
>>>> You did it again: as documented in ksrc/arch/arm/patches/README,
>>>> what Xenomai version you pick is largely irrelevant to what I-pipe patch
>>>> you want to use, so, you can probably use the I-pipe patch for 2.6.20
>>>> with Xenomai 2.5.4.
>>>>
>>>>
>>> Agreed. The intention is to clarify few doubts. Otherwise I will missed
>> to
>>> get such an specific info mentioned below.
>>> Thanks for the info.
>>>
>>>
>>>> All releases of a Xenomai branch are backward compatible, so, if you
>>>> want to pick something in the any branch, pick the latest (2.4.10 for
>>>> 2.4 branch, 2.5.4 for 2.5 branch). Also note that all I-pipe patches up
>>>> to, but not including, 2.6.28-1.12-05, are buggy, so, if you want to use
>>>> 2.6.20, you will have to apply the patch attached to this mail:
>>>>
>>>> https://mail.gna.org/public/xenomai-core/2009-08/msg00021.html
>>>>
>>>> As for the initial question, I do not remember that far in the past.
>>>> But, at some point in the past, the I-pipe patch started being able to
>>>> be applied with and without the AT91 patch, I do not remember if
>>>> 2.6.20-1.8-02 was in this case.
>>>>
>>>>
>>> At this moment my board only supports linux-2.6.20. So I just like to
>> port
>>> xenomai and test the board with the same kernel version. Later I will
>>> upgrade the linux kernel and move to the latest xenomai.
>>>
>>> I would like to know in which format you getting my mails now?.
>> You can check the mail contents:
>>
>> Content-Type: multipart/alternative; boundary=001636c5a98061861f048e7a11ca
>>
>> --001636c5a98061861f048e7a11ca
>> Content-Type: text/plain; charset=ISO-8859-1
>>
>> On Mon, Aug 23, 2010 at 2:05 PM, Gilles Chanteperdrix <
>> gilles.chanteperdrix@xenomai.org> wrote:
>>
>> (...)
>>
>> --001636c5a98061861f048e7a11ca
>> Content-Type: text/html; charset=ISO-8859-1
>> Content-Transfer-Encoding: quoted-printable
>>
>> <br><br><div class=3D"gmail_quote">On Mon, Aug 23, 2010 at 2:05 PM, Gilles
>> =
>> Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:
>> gilles.chanteperdrix@=
>> xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span>
>> wrote:<br><blo=
>> ckquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204,
>> 204,=
>>  204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
>>
>>
>>
> Ya, Really ugly. I disabled "plain text option" in my mailinglist settings
> and sending this reply. Any changes now?.

No. And the mailing list settings are about how you want to receive the
mail, not how you send it. The mailing list can not control the mail you
send, only your mail client does.

> 
> -Prakash
> 


-- 
					    Gilles.


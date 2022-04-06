Message-ID: <a10be0d7-adaf-b589-f10f-d155a8acc522@siemens.com>
Date: Wed, 6 Apr 2022 11:21:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] x86: dovetail: reinstate I/O bitmap on user entry
Content-Language: en-US
References: <20220403144348.1775590-1-rpm@xenomai.org>
 <317493564.212576.1649003575604.JavaMail.zimbra@nod.at>
 <87ilrqnjdp.fsf@xenomai.org>
 <656392314.214549.1649064591209.JavaMail.zimbra@nod.at>
 <87ee2colqg.fsf@xenomai.org> <419235.1649236412@gemini.denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <419235.1649236412@gemini.denx.de>
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
To: Wolfgang Denk <wd@denx.de>, Philippe Gerum <rpm@xenomai.org>, Philippe Gerum via Xenomai <xenomai@xenomai.org>
Cc: Richard Weinberger <richard@nod.at>

On 06.04.22 11:13, Wolfgang Denk via Xenomai wrote:
> Dear Philippe,
> 
> In message <87ee2colqg.fsf@xenomai.org> you wrote:
>>
>>> BTW: Do you have a Patchwork instance for the Xenomai mailing list?
>>
>> Unfortunately not.
>>
>>> I makes dealing with patch
>>> series so much easier.
>>>
>>> Or even better, can we have Xenomai at lore.kernel.org? Then we can use b=
>> 4. :-)
>>
>> It seems unlikely that kernel.org would consider hosting us since the
>> project does not upstream patches to the mainline kernel.
> 
> Did you try it?  I don't thhink this is a mandatory requirement.
> For example, U-Boot also does not upstream any kernel patches.
> 

I agree, we should give that a try [1]. Philippe, would you do as
mailing list hoster or should I (and then ask you to sync with them
regarding the archive)?

Jan

[1] https://korg.docs.kernel.org/lore.html

-- 
Siemens AG, Technology
Competence Center Embedded Linux


Subject: Re: [CXP][RFC] pick POSIX/cobalt for the common user API
References: <87mtyr1abi.fsf@xenomai.org> <5FCD907C.6040309@tj.kylinos.cn>
 <251767.1607349501@gemini.denx.de>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5FD30DEA.8010603@tj.kylinos.cn>+37BFCCBCE14F70E5
Date: Fri, 11 Dec 2020 14:12:58 +0800
MIME-Version: 1.0
In-Reply-To: <251767.1607349501@gemini.denx.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Denk <wd@denx.de>, chensong via Xenomai <xenomai@xenomai.org>

Mr. Denk,

Thanks a lot for the explanation, now it's clear to me.

My concern was, it's a competition outside, RTOS emulators might be 
additional value xenomai brings to customers besides low and 
deterministic latency.

If we think nobody benefits, we should move on and focus on what is 
defined in CXP.

Thanks again and best regards,

Song

On 2020年12月07日 21:58, Wolfgang Denk wrote:
> Dear Chensong,
>
> In message <5FCD907C.6040309@tj.kylinos.cn>+BA6FC9DAC615AEA6 you wrote:
>>
>> As far as i know, some vxworks customers like xenomai because they can
>> move their RT processes from vxworks to linux without rewriting their
>> code by the help of vxworks skin.
>
> I agree - we also had customers who used this - but that was may
> years ago, and I haven't seen any such request for at least 5 years,
> probably more.
>
>> If we "Excluding the legacy RTOS emulators such as VxWorks", we will
>> lose them. It could depend on the balance of the request and effort.
>
> I think we should move on and not get ourself stuck in "maybe
> someone still needs it" compatibility issues.  If such users still
> exist, they can speak up here, and offer to cover the needed efforts
> to add and maintain such a compatibility layer again.
>
> I would not hold my breath waiting for such volunteers, though...
>
> Best regards,
>
> Wolfgang Denk
>




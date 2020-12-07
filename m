From: Wolfgang Denk <wd@denx.de>
Subject: Re: [CXP][RFC] pick POSIX/cobalt for the common user API
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <5FCD907C.6040309@tj.kylinos.cn>+BA6FC9DAC615AEA6
References: <87mtyr1abi.fsf@xenomai.org>
 <5FCD907C.6040309@tj.kylinos.cn>+BA6FC9DAC615AEA6
Date: Mon, 07 Dec 2020 14:58:21 +0100
Message-ID: <251767.1607349501@gemini.denx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: chensong <chensong@tj.kylinos.cn>, chensong via Xenomai <xenomai@xenomai.org>

Dear Chensong,

In message <5FCD907C.6040309@tj.kylinos.cn>+BA6FC9DAC615AEA6 you wrote:
>
> As far as i know, some vxworks customers like xenomai because they can 
> move their RT processes from vxworks to linux without rewriting their 
> code by the help of vxworks skin.

I agree - we also had customers who used this - but that was may
years ago, and I haven't seen any such request for at least 5 years,
probably more.

> If we "Excluding the legacy RTOS emulators such as VxWorks", we will 
> lose them. It could depend on the balance of the request and effort.

I think we should move on and not get ourself stuck in "maybe
someone still needs it" compatibility issues.  If such users still
exist, they can speak up here, and offer to cover the needed efforts
to add and maintain such a compatibility layer again.

I would not hold my breath waiting for such volunteers, though...

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
READ THIS BEFORE OPENING PACKAGE: According to Certain Suggested Ver-
sions of the Grand Unified Theory, the Primary Particles Constituting
this Product May Decay to Nothingness Within the  Next  Four  Hundred
Million Years.


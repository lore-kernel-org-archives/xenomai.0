Message-ID: <4C4D7B8E.4000309@domain.hid>
Date: Mon, 26 Jul 2010 14:11:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTilWSsSuCKRxQg0NIkeeR28eqpdJfaVm_CiemnqF@mail.gmail.com>	<4C46D49F.6030102@domain.hid>	<AANLkTikJgzkkxQyM8DQqVz17ovJmPiIkdZMIFJImExIE@mail.gmail.com>	<4C46F0D9.4030906@domain.hid>	<AANLkTilP98GMfCx1rcgWto9eBmnDwtuavBteD8inFM6V@mail.gmail.com>	<4C47F932.3060400@domain.hid>	<AANLkTilP1f217jN3krm_Cdqu4LaYwpUMu6mMnLiUJq2f@domain.hid>	<4C4823DC.4050500@domain.hid>
	<AANLkTi=GuZADaU-CedYiqBU1Bj_Li+EAQ_7ZJKXA_qRR@mail.gmail.com>
In-Reply-To: <AANLkTi=GuZADaU-CedYiqBU1Bj_Li+EAQ_7ZJKXA_qRR@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Unexpected preemption of highest priority thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephen Bryant <sbxenomai@domain.hid>
Cc: xenomai@xenomai.org

Stephen Bryant wrote:
> On 22 July 2010 11:56, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> Stephen Bryant wrote:
>>> On 22 July 2010 08:54, Gilles Chanteperdrix <
>>> gilles.chanteperdrix@xenomai.org> wrote:
>>>
>>>> Stephen Bryant wrote:
>>>>> On 21 July 2010 14:06, Gilles Chanteperdrix
>>>>> <gilles.chanteperdrix@xenomai.org
>>>>> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
>>>>>
>>>>>     Stephen Bryant wrote:
>>>>>     > I've had a look at dmesg, but cannot find any references to SMI -
>>>> what
>>>>>     > should I be looking for?
>>>>>
>>>>>     What is described in the TROUBLESHOOTING file.
>>>>>
>>>>>
>>>>> I have tried disabling the SMI workaround, ensuring that SMI detection
>>>>> is not disabled, and logging the kernel output (setting the kernel log
>>>>> level to 8 in grub and sending the output to the serial port to be
>>>>> picked up by another machine). The troubleshooting file states that I
>>>>> should see "Xenomai: Intel chipset found and SMI workaround not
>>>>> enabled, you may encounter high interrupt latencies." in this output,
>>>>> however this does not occur - I am using an Intel Core 2 Duo but with
>>>>> SMP disabled, if this has any relevance.
>>>> The SMI detection/workaround is based on the chipset you have. If your
>>>> chipset is an ICH10, Stefan posted a patch a few days ago. If it is
>>>> another one, then please send us the result of lspci -vv on your target.
>>>>
>>> It seems to be ICH8, so the result is attached,
>> Please try with the following patch:
>>
>>
>> --
>>                                             Gilles.
>>
> 
> With the patch applied and SMI Workaround not used I get the kernel message
> as expected: "...SMI workaround not enabled...".
> 
> However, with the SMI Workaround enabled and Globally disabling SMI I get
> the messages:
> "Xenomai: SMI-enabled chipset found
> Xenomai: SMI workaround failed!"

It probably means that your board manufacturer has decided, at BIOS
level, to prevent you from disabling the SMIs. You may want to try
disabling the SMI bits one by one.

-- 
					    Gilles.


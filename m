Message-ID: <4FA00EC2.5080806@domain.hid>
Date: Tue, 01 May 2012 18:26:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F7333E7.7030608@domain.hid>
	<4F7339A8.6060701@domain.hid>	<4F735716.4020508@domain.hid>
	<4F7C7DEA.5070201@domain.hid>	<990B36E792F1A4488D3E2B1C46FD62D692DDD85791@domain.hid>	<4F86FB84.3030009@domain.hid>
	<4F9925E3.9020702@domain.hid>
In-Reply-To: <4F9925E3.9020702@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt latency greater than 250ms
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/26/2012 12:39 PM, Philippe Gerum wrote:
> On 04/12/2012 05:57 PM, Philippe Gerum wrote:
>> On 04/12/2012 05:45 PM, Michael Pustylnik wrote:
>>> The code masking the interrupt in IPIC (call for
>>> ipipe_pre_cascade_noeoi()) initially showed up in the patch you
>>> recommended (see your email attached).
>>>
>>> Later on it was integrated in Xenomai commit
>>> "9a5e42df8bccc59620c08caeb4b9fe92dbf94a1b".
>>>
>>> As shown in the trail below, it keeps interrupts all the time until the
>>> scheduler returns, thus breaking real-time responsiveness.
>>>
>>> A solution to this is probably to remove calling
>>> ipipe_pre_cascade_noeoi() and let the cascading handler mask the
>>> interrupt. Am I missing something? Do you think it is safe to use this
>>> solution?
>>
>> No, as interrupts could be re-enabled before invoking the handler, you 
>> would get an IRQ storm.
>>
>> The solution is to rework the cascaded IRQ handling in the generic 
>> pipeline core, so that all decoded IRQs are acked/masked, then the 
>> multiplex IRQ unmasked, then all the decoded IRQ handlers fired when 
>> syncing the relevant pipeline stage.
>>
>> A fix for this will follow when enough testing will have been done on 
>> arm and ppc, to check whether that logic does not raise other issue.
>>
> 
> This is the patch series fixing the issue in the newest pipeline "core"
> implementation, currently for kernel 3.2. Something along these lines would work for
> earlier kernels as well.
> 
> http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=0a9a7b4e4ce9f4196a574471ad58f4389820c438
> http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=f2ca3c2baf58bf43f4c00fb05b91b16da9fd77f2
> http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=a4b909ccf80c5afa132aa7a9ccf0022cb8a6e6f2
> http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=b47bc773ff07ce886aaf490921ac59e98ed9575a

I have done a backport of this change for a pre ipipe-core (ARM) I-pipe. The diff is here:
http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=81bfc05c4716b76e79f5e486baf4c52015a3b92c;hp=7d31a77f62acb57eb83409c8f514d0f2dacf7fe5

-- 
                                                                Gilles.


Message-ID: <4C4AE341.8010903@domain.hid>
Date: Sat, 24 Jul 2010 14:57:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid>	<4C43D265.9080609@domain.hid>	<4C43FC4F.3010006@domain.hid>	<4C440D6F.1060204@domain.hid>	<4C44E9C9.3020600@domain.hid>	<4C454C0C.6000100@domain.hid>	<4C4550C8.3070504@domain.hid>	<4C45541C.5090507@domain.hid>
	<4C45CEE6.5000903@domain.hid>	<4C460506.3010103@domain.hid>
	<4C46141F.50103@domain.hid>	<4C468040.3030509@domain.hid>
	<4C468485.5060408@domain.hid>	<4C47597F.1010406@domain.hid>	<4C478313.2030606@domain.hid>	<4C48C1BB.8080606@domain.hid>
	<4C48C2CE.1030706@domain.hid>	<4C4A292F.5040900@domain.hid>
	<4C4ADFC6.1010900@domain.hid>
In-Reply-To: <4C4ADFC6.1010900@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Adeos patch prevents IRQ 384 (MMC Chip Detect)
 on omap-2.6.33
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Bob Feretich wrote:
>>   I have started a new thread with a name that better describes the 
>> failure I am seeing. This may or may not be the reason I was seeing root 
>> file system mount hang on omap-2.6.31 (previous thread).
> 
> Ok. In the case where you have Adeos without Xenomai, do you have
> CONFIG_IPIPE enabled, if yes, then please verify that when CONFIG_IPIPE
> is disabled, you return in the same situation as without the I-pipe
> patch. Please also try enabling CONFIG_IPIPE and only removing the
> commit which "fixes" the spurious irqs.

To clarify my suggestions: I think the "fix" for spurious irqs may in
fact paper over the real problem of twl4030 irqs with the Adeos patch. I
simply did not spend to much sweat on it, because the twl4030 irqs code
look a lot like an hacky UFO which is going to disappear thanks to
threaded interrupts. But obviously, that is not going to happen for
2.6.31 or 2.6.33.

Anyway, I am going to test 2.6.33 without I-pipe on my side to see if I
get the interrupts and I can reproduce your issue.

-- 
					    Gilles.


Message-ID: <4C45CEE6.5000903@domain.hid>
Date: Tue, 20 Jul 2010 18:29:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid>
	<4C43D265.9080609@domain.hid>	<4C43FC4F.3010006@domain.hid>
	<4C440D6F.1060204@domain.hid>	<4C44E9C9.3020600@domain.hid>
	<4C454C0C.6000100@domain.hid>	<4C4550C8.3070504@domain.hid>
	<4C45541C.5090507@domain.hid>
In-Reply-To: <4C45541C.5090507@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Adeos patched kernel hangs mounting root file
 system
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
>>   Angstrom doesn't support 2.6.33 yet. The Angstrom developers are 
>> working at 2.6.32. The 2.6.31 kernel is the newest kernel that both 
>> Angstrom and Xenomai support.
>>
>> That said, I could grab a 2.6.33 kernel and drop it in to see what 
>> happens. I build everything via OpenEmbedded. I would either need to 
>> create the OpenEmbedded receipes for the 2.6.33 kernel (which I don't 
>> know how to do right now); or set up a build environment for the kernel 
>> outside OpenEmbedded, then merge it back in (also haven't this done 
>> before).
>>
>> Either would be a fair amount of work. I'd like to hear your response to 
>> my last e-mail detailing the specific IRQs involved and support for a 
>> Level 2 interrupt handler before I start.
> 
> Building a kernel by using only its build system is pretty easy.
> Building it for Xenomai involves one more step: running the
> prepare-kernel.sh script, but that is not very complicated either.
> 
> The situation we have is:
> 2.6.31 does not work for you on Beagle
> 2.6.33 works for me on IGEPv2.
> 
> The fact that 2.6.33 works for me rules out automatically anything that
> would be missing in the Adeos patch.
> 
> Now we have two possibilities, either the problem comes from a
> difference between 2.6.31 and 2.6.33, or it comes from a difference
> between Beagle and IGEP. And since I do not have time to test 2.6.31, I
> ask you to test 2.6.33.

The thing I did not explain is that 2.6.31 has no support for the IGEPV2
board. So, to get it working I would need to backport the board support.

However, I can compile a 2.6.33 kernel with a configuration for the
beagle board. To be sure that the configuration works for you, I would
need your .config though.

-- 
					    Gilles.


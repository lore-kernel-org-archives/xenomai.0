Message-ID: <4C4550C8.3070504@domain.hid>
Date: Tue, 20 Jul 2010 00:31:20 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid> <4C43D265.9080609@domain.hid>
	<4C43FC4F.3010006@domain.hid> <4C440D6F.1060204@domain.hid>
	<4C44E9C9.3020600@domain.hid> <4C454C0C.6000100@domain.hid>
In-Reply-To: <4C454C0C.6000100@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

  Angstrom doesn't support 2.6.33 yet. The Angstrom developers are 
working at 2.6.32. The 2.6.31 kernel is the newest kernel that both 
Angstrom and Xenomai support.

That said, I could grab a 2.6.33 kernel and drop it in to see what 
happens. I build everything via OpenEmbedded. I would either need to 
create the OpenEmbedded receipes for the 2.6.33 kernel (which I don't 
know how to do right now); or set up a build environment for the kernel 
outside OpenEmbedded, then merge it back in (also haven't this done 
before).

Either would be a fair amount of work. I'd like to hear your response to 
my last e-mail detailing the specific IRQs involved and support for a 
Level 2 interrupt handler before I start.

Regards,
Bob

On 7/20/2010 12:11 AM, Gilles Chanteperdrix wrote:
> ... snipped ...
> What about testing 2.6.33 ?
>


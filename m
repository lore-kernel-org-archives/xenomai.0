Message-ID: <4EB6E26E.1040107@domain.hid>
Date: Sun, 06 Nov 2011 20:39:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4EB6CA3B.1040608@domain.hid>
In-Reply-To: <4EB6CA3B.1040608@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.6.0 - kernel seg faults on AT91
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: at91_enthus <nwromania@domain.hid>
Cc: xenomai@xenomai.org

On 11/06/2011 06:56 PM, at91_enthus wrote:
> Hi.
> 
> I gave Xenomai 2.6.0 a try and installed a newly patched kernel on my
> AT91SAM9G20 board.
> 
> Here is my setup:
> 
> proc:   AT91SAM9G20
> kernel: 2.6.35.9
> OS: embedded Debian Squeeze
> 
> The board boots fine up to stage 2 (user terminal). Sometimes, I am able
> to get a login terminal, despite seg fault messages.
> 
> A similar behavior occurs in a Xenomai capable 2.6.37 kernel, only
> without the fault messages. In this case the board simply freezes.
> 
> I included the files (.config and fault messages) in the attachments.

On my side, I tried booting on at91sam9263 a kernel with the same kernel
options as you, but am unable to reproduce any problem.

Could you make the root filesystem you are using available somewhere for
download?

-- 
                                                                Gilles.


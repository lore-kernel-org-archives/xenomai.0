Message-ID: <4D34617C.6060702@domain.hid>
Date: Mon, 17 Jan 2011 16:34:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D31B6C3.5060007@domain.hid> <4D3227DA.9080909@domain.hid>
	<4D342298.8090603@domain.hid> <4D344563.6060506@domain.hid>
	<4D3460A7.2080109@domain.hid>
In-Reply-To: <4D3460A7.2080109@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Question on periodic task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wong Sheng Chao <wong@domain.hid>
Cc: xenomai@xenomai.org

Wong Sheng Chao wrote:
> You can try booting in text mode, and set the vga mode to have a lot of
> lines, then run the test in text mode, to at least see if the reason of
> the freeze you observe is a kernel oops.
> 
> I tried booting it in text mode and the program still freezes after i 
> execute the user-space program. There were no error messages.
> 
> If you do not see anything, then enable all the I-pipe and Xenomai
> debugs, and try again.
> 
> How do I enable I-pipe and Xenomai debugs? Do I need to set these 
> options during kernel configuration time?

Yes. What about trying things first, and then ask questions if it does
not work?


> Will enabling I-pipe let me know if it's a kernel-oops?

No, it will allow you to see if something else went wrong.

-- 
                                                                Gilles.


Message-ID: <499C5E49.90002@domain.hid>
Date: Wed, 18 Feb 2009 20:15:21 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <499B36C5.3060104@domain.hid>
In-Reply-To: <499B36C5.3060104@domain.hid>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] BUG fs/buffer.c with Linux 2.6.26,27
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roman Pisl <rpisl@domain.hid>
Cc: xenomai@xenomai.org

Roman Pisl wrote:
> Hello,
> I'm porting our application to Xenomai and I found a bug with Linux
> 2.6.26 and 2.6.27 (and also .19) and Xenomai 2.4.6.1. This happens when
> the application is running and there is hard disk activity. It happens
> also when latency test is running for a while. Linux 2.6.16 with Xenomai
> 2.4.6.1 works without problem. So this is solution for now.
> 
> Tested on x86 - thinkpad laptop and pentium 4 desktop.
>

Could you disable CONFIG_PREEMPT and test again?

TIA,

> I'm not a kernel hacker but surely try to help with fixing. I'd like to
> see this fixed.
> 
> Thank you.
> 
> Roman Pisl
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.


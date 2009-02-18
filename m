Message-ID: <499B5136.2030107@domain.hid>
Date: Wed, 18 Feb 2009 01:07:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <499B36C5.3060104@domain.hid> <499B3F35.2080604@domain.hid>
In-Reply-To: <499B3F35.2080604@domain.hid>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] BUG fs/buffer.c with Linux 2.6.26,27
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Roman Pisl wrote:
>> Hello,
>> I'm porting our application to Xenomai and I found a bug with Linux
>> 2.6.26 and 2.6.27 (and also .19) and Xenomai 2.4.6.1. This happens when
>> the application is running and there is hard disk activity. It happens
>> also when latency test is running for a while. Linux 2.6.16 with Xenomai
>> 2.4.6.1 works without problem. So this is solution for now.
>>
>> Tested on x86 - thinkpad laptop and pentium 4 desktop.
>>
>> I'm not a kernel hacker but surely try to help with fixing. I'd like to
>> see this fixed.
> 
> /me, too. But could you first of all check if the problem persists even
> with latest adeos-ipipe-2.6.27.13-x86-2.2-05.patch [1]?
> 
> If it does: Go back to 2.6.26 (in order to have the ipipe tracer).
> Before the oops can occur, extend /proc/ipipe/trace/back_trace_points
> to, say, one thousand ("echo 1000 > /proc/..."). Then post the resulting
> trace. It may include some hints about when Linux IRQs were last enabled
> and when they became stuck at disabled. Also, please attach your .config.

Other traces show that it happens in __ipipe_unstall_iret_root.
-- 
					    Gilles.


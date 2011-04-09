Message-ID: <4D9FB431.6010203@domain.hid>
Date: Sat, 09 Apr 2011 03:19:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <F73025C3-F590-4CB7-A8E1-0EFF62E9A656@domain.hid>	<4D9EB884.6020804@domain.hid>
	<205D3924-0110-4DA7-838B-DF40BDBE6702@domain.hid>
In-Reply-To: <205D3924-0110-4DA7-838B-DF40BDBE6702@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Total system lockup doing anything real-time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nolan Waite <nolan@domain.hid>
Cc: xenomai@xenomai.org

Nolan Waite wrote:
> Hi, thanks for taking a look.
> 
> Before trying the suggestions below, I configured the kernel as requested in your other reply: I disabled Xenomai debug and turned off the function tracer. I attached the new .config for reference.
> 
> On 2011-04-08, at 1:25 AM, Gilles Chanteperdrix wrote:
> 
>> Is there any way you could set up a serial console instead?
> 
> I'll try but odds aren't good. Sorry.

If:
- the machine has a serial port (I mean a ream one, ttySx, not ttyUSBx)
- you have another machine which can be plugged on this serial port
Then it should work, simply read Documentation/serial-console.txt in the
Linux kernel sources. Otherwise, forget it.

> 
>> Could you try running latency in text mode?
> 
> Sure. I get the same results as in desktop mode. See attached 'textmode.kernel.log', a dump of dmesg immediately before running latency.

The question being, do you get the text of a kernel oops when the bug
happens? Because if this is what happens, what we would like is the
kernel oops text, and the serial console is the best way to get it. If
you do not get any message after launching the latency test, then forget
about the serial console, please try enabling the nmi watchdog as
explained in Documentation/nmi_watchdog.txt in the Linux kernel sources.


-- 
                                                                Gilles.


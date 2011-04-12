Message-ID: <4DA433B7.5020608@domain.hid>
Date: Tue, 12 Apr 2011 13:12:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <F73025C3-F590-4CB7-A8E1-0EFF62E9A656@domain.hid>	<4D9EB884.6020804@domain.hid>	<205D3924-0110-4DA7-838B-DF40BDBE6702@domain.hid>	<4D9FB431.6010203@domain.hid>
	<9948C373-EE10-42D0-A854-DC6A6C38B830@domain.hid>
In-Reply-To: <9948C373-EE10-42D0-A854-DC6A6C38B830@domain.hid>
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
> Hello,
> 
> Thanks for the help so far.
> 
> On 2011-04-08, at 7:19 PM, Gilles Chanteperdrix wrote:
> 
>> The question being, do you get the text of a kernel oops when the
>> bug happens? Because if this is what happens, what we would like is
>> the kernel oops text, and the serial console is the best way to get
>> it. If you do not get any message after launching the latency test,
>> then forget about the serial console, please try enabling the nmi
>> watchdog as explained in Documentation/nmi_watchdog.txt in the
>> Linux kernel sources.
> 
> Enabling the nmi watchdog (had to add nmi_watchdog=2 to the boot
> command line, not nmi_watchdog=1 like I had expected) got me some
> panic text (in attached zip as panic.log) which I got via the
> netconsole. Nothing else appeared on the screen after the panic log.

That is an improvement.

In the kernel configuration. Could you try changing the following
configuration options:
CONFIG_FTRACE to n
CONFIG_SECURITY to n
CONFIG_DEBUG_RODATA to n
CONFIG_KGDB to n
CONFIG_AUDIT to n
Could you to try a 64 bits kernel (with the 32 bits compatibility layer,
it should work with a 32 bits rootfs)?

If you still get a oops, please send us a disassembly of the EIP where
the NMI watchdog triggers.2

-- 
                                                                Gilles.


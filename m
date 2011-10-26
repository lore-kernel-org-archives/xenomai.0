Message-ID: <4EA81F08.4040509@domain.hid>
Date: Wed, 26 Oct 2011 16:54:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1319490255.1417.YahooMailNeo@domain.hid>
	<4EA69486.4030106@domain.hid>
	<1319638430.4857.YahooMailNeo@domain.hid>
In-Reply-To: <1319638430.4857.YahooMailNeo@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] address spaces of real-time task and standard
 linux process
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tom Z <tomz30@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/26/2011 04:13 PM, Tom Z wrote:
> 
> 
> Thanks. I increased the stack size and the problem was gone. This
> problem was hard to find for me, as when I step into the functions in
> gdb, the locations where the problem occurs are different.
> 
> 
> BTW, in your previous reply you mentioned debugging techniques such
> as examining the registers and disassembling, can you suggesting some
> readings that elaborate such techniques. I have a few questions
> regarding such techniques, e.g., how do I interpret the meaning of
> each register? By disassembling, do you mean looking at the assembly
> codes?

The best I could find is this:
http://www.urbanmyth.org/linux/oops/slides.html

Which explains how to debug a kernel oops. The method transpose easily
to user-space.

In case of stack overflow, the stack pointer register should show an
address not mapped, or mapped read-only. You can see a process mappings
in /proc/pid/maps (if you want this file to exist in case of a segfault,
install a signal for SIGSEGV which calls the pause() function).

But if gdb does not modify the program behaviour, debugging with gdb is
much easier.

-- 
					    Gilles.


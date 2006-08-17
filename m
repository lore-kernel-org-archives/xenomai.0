From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17636.26239.60678.358249@domain.hid>
Date: Thu, 17 Aug 2006 14:52:15 +0200
Subject: Re: [Xenomai-help] Debugging
In-Reply-To: <200608171405.44978.s.zimmermann@domain.hid>
References: <200608171405.44978.s.zimmermann@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

Stephan Zimmermann wrote:
 > Hello List,
 > I am facing some trouble debugging my Xenomai application. When I set a 
 > breakpoint in my main() task, everything works fine. If I set a breakpoint in 
 > another task, the debugger won't stop the application. Is this a known 
 > problem, or am I doing something wrong (compiler/debugger options)? I tryed 
 > it within Eclipse and gdb commandline interface, both gave me the same 
 > results. Can someone give me a Hint?
 > 
 > My System:
 > Debian 3.1 on AMD X2, running in 32bit mode
 > Xenomai 2.2 on Kernel 2.6.17.6, with no other patches
 > debian standard gcc 3.3.5
 > (same problem on intel notebook)
 > The program I'm working on is written in C++, wrapping classes around the 
 > native skin.

Next idea: are you trying to put a breakpoint on a class constructor ?
There is a known issue with gdb and gcc version 3 and later: the
compiler generate several versions of each constructor, and you are not
necessarily putting the breakpoint on the version that is really
executed.

-- 


					    Gilles Chanteperdrix.


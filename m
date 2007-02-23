From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17887.19492.921482.412573@domain.hid>
Date: Fri, 23 Feb 2007 21:18:44 +0100
Subject: Re: [Xenomai-help] include-path conundrum types.h
In-Reply-To: <bc4264770702231136u74de12f3q9bbcfe980390c5f8@domain.hid>
References: <bc4264770702231136u74de12f3q9bbcfe980390c5f8@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
 > Hi
 > 
 > In the first steps of introducing xenomai into my project I notice
 > that there seems to
 > be a strange misdirection in one of the header files.
 > 
 > #include <asm/xenomai/system.h>
 > 
 > in <nucleus/types.h> does not seem to make sense. I seem to have to
 > change this to
 > 
 > #include <asm-i386/system.h>
 > 
 > But before I start hacking perhaps someone wants to shed some light on
 > what is going on here?

Have a look at /usr/xenomai/include, there, asm and asm/xenomai are
symbolic links. If these symbolic links have not been set-up, then you
have an installation problem.

Changing from asm to asm-i386 would make nucleus/types.h only work on
i386, whereas by using the asm symbolic link, it works on any
architecture.

-- 


					    Gilles Chanteperdrix.


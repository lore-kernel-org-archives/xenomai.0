From: Michael Bernhard <michael.bernhard@domain.hid>
Date: Tue, 4 Oct 2011 15:14:13 +0000 (UTC)
Message-ID: <loom.20111004T165835-555@domain.hid>
References: <4E8981F9.9090105@domain.hid> <4E89AA0F.8020104@domain.hid>
	<4E89D5E7.8050106@domain.hid> <4E8AED21.7010709@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help]
	=?utf-8?q?SIGILL_when_calling_pthread=5Fcleanup=5F?=
	=?utf-8?b?cHVzaCgp?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Gilles Chanteperdrix <gilles.chanteperdrix <at> xenomai.org> writes:
> 
> On 10/03/2011 05:33 PM, Gilles Chanteperdrix wrote:
> > On 10/03/2011 02:26 PM, Gilles Chanteperdrix wrote:
> >> Ok. Thanks for testing xenomai 2.6 by the way. I will try the test
> >> program on an ARMv5 I have tonight. However, could you tell us a bit
> >> more about your setup? What toolchain do you use? What threading library?
We use codesourcery toolchain arm-2010.09. The rootfs was built using PTXdist.
I think, but have to verify, that NPTL is used as threading library.

> > And also: is your libc built with iwmmxt support?
I don't know, but will find out.

> I can not reproduce this issue on another armv5 I have, but it does not
> support iwmmxt. So, in order to see if the problem you have comes from
> iwmmxt, you should try and build a root filesystem with a soft-float
> toolchain, such as, for instance, the codesourcery toolchain.
> 
> Currently, iwmmxt floats are not supported with Xenomai, so, if you want
> to get them working, something will have to be done.
In the example I gave, no floats were used. Does Xenomai needs to support iwmmxt
floats also in this case? And would compiling the application with -msoft-float
do the trick?

ATM, I'm busy with other things but have time to investigate tomorrow evening. 

--
Michael





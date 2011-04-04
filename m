Message-ID: <4D9A46FB.1040607@domain.hid>
Date: Tue, 05 Apr 2011 00:32:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=QSd8qm6jwQKB3mZLwTsmp1t7phw@domain.hid>
In-Reply-To: <BANLkTi=QSd8qm6jwQKB3mZLwTsmp1t7phw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] commercial users of xenomai, commercial support,
 JTAG
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Eric <ericrebates@domain.hid>
Cc: xenomai@xenomai.org

Eric Eric wrote:
> Hello, in the course of evaluating migration from Integrity to
> Xenomai, a few questions have come up that I am having a hard time
> finding info on:
> 
> - Are there any examples of commercial projects that use Xenomai?  I'm
> specifically looking for propaganda like this RTEMS flier:
> http://www.rtems.com/sites/default/files/RTEMS-Users-V2.pdf

Have a look here:
http://www.denx.de/en/view/News/XenomaiUserMeeting2009#Abstracts_and_Presentations

> 
> - Are there any companies offering commercial support services for
> Xenomai, such as FSMLabs does for RTLinux or OAR does for RTEMS?

There are a few, I will let others answer this question.

> 
> - Can Xenomai kernel-level tasks be debugged via JTAG?  Although we
> would do most of our work in user-tasks, there is a non-trivial part
> that is highly latency sensitive and will need to go in the kernel
> (bearing in mind GPL compliance of course).  There is concern that
> this could be problematic to debug.  We sometimes use a Blackhawk JTAG
> with TI CodeComposer to debug Linux drivers.
> 
> I think it was asked before, but we are using ARM.

There should be no problem for debug with JTAG, the JTAG debugger
accesses the processor at a level far below any sofware layer. Except
for thread-aware debuggers, which will not be able to debug Xenomai
threads, only Linux threads. I am not sure what CCS is able to do.

-- 
                                                                Gilles.


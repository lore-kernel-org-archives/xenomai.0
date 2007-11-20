From: Paul <paul_c@domain.hid>
Date: Tue, 20 Nov 2007 20:47:31 +0000
References: <4b7912400711201144y21e893c0w7e494e1eba20f3b1@domain.hid>
In-Reply-To: <4b7912400711201144y21e893c0w7e494e1eba20f3b1@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711202047.31990.paul_c@domain.hid>
Subject: Re: [Xenomai-help] rtai_free & rtai_malloc problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Tuesday 20 November 2007 19:44, zhangwei zhang wrote:
> I try to install emc2 on xenomai (x86), the error is like this:
<snip>
> usrmot-usrmotintf.o: In function `usrmotExit':
> /home/kyla/eldk/xenomai-2.3.4/src/emc/iotask/usrmotintf.c:1052:

This line tells me you are compiling from a tarball sent over last night. This 
code is based on the original NIST EMC code, not emc2.

<snip>
> How can I modify the code to solve this problem?

I'll take a look at the code I sent, and will advise shortly - Compiling on a 
PowerPC reveals a couple of problems with the configure script, and there 
will also be some issues with includes.

Unless there is a wider interest in this particular project, general compile 
time problems & bugs are probably best dealt with off-list. Feel free to 
email me anytime.


Regards, Paul.


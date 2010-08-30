Message-ID: <4C7BD811.9070403@domain.hid>
Date: Mon, 30 Aug 2010 18:10:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTin4EBuE7jeKeeJorBVk+CGy=6w86o2_DzjHLdUs@domain.hid>
In-Reply-To: <AANLkTin4EBuE7jeKeeJorBVk+CGy=6w86o2_DzjHLdUs@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xeno-test failed on ARM AT91RM9200 processor
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Prakash A S <asprakash83@domain.hid>
Cc: xenomai@xenomai.org

Prakash A S wrote:
> Hi,
>     I am trying to port Xenomai-2.4.0 on ARM AT91RM9200 processor. I used
> adeos-ipipe-2.6.20-arm-1.7-06.patch with Linux kernel 2.6.20.

That is a useless effort, since that patch already contains a port of
Xenomai on this processor. Besides, these versions are outdated.

 All the stuffs
> went fine, compiled the kernel and ported on the same processor. The xenomai
> components loaded fine while loading the kernel image. However when I
> executed the xeno-test, I am getting the error,  "please build busybox's ash
> with support for getopts" and quit the test.
> 
> I am using BusyBox-1.15.3 enabled with GETOPT. I noticed that the "getopts"
> link is not available with the busybox bin. But it has only "getopt". I
> checked few other latest version of Busybox. But I could not find it in
> other versions also. However the x86 desktop Linux contains both getopt and
> getopts.
> 
> Few online guides claimed that the getopts is builtin with Busybox. I
> created an getopts softlink for busybox manually anf then tried the
> xeno-test. But getting the error,  "getopts: applet not found". I could not
> find the exact reason for this issue. I also tried to execute the tests
> separately like latency, switchtest,.etc. But getting the same error, "syntax
> error: word unexpected (expecting ")")".
> 
> FYI, the busybox configured with ASH shell.
> 
> Help me to solve the issues.

Well this is an issue with busybox, which has nothing to do with
Xenomai, so, you are posting on the wrong list.

-- 
					    Gilles.


In-Reply-To: <5387289F.2090404@xenomai.org>
References: <OFBAF613A3.27D3BC8A-ONC1257CE7.003515C1-C1257CE7.0042F1F4@selex-es.com>
 <5387289F.2090404@xenomai.org>
From: <matteo.semmoloni@selex-es.com>
Message-ID: <OFCCBDF17D.EBCF7A9B-ONC1257CE7.00512F0F-C1257CE7.00529C5C@selex-es.com>
Date: Thu, 29 May 2014 17:02:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] User Space Interrupt not working
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org


Thanks, I'm running on ARM platform Xilinx Zynq.

I have a doubt about patch suggested; Ipipe version is 1, but Ipipe version
mentionated in your post is 3. Is it possibile that I'm using an older
Ipipe patch? Lines suggested by your post do not match with my Ipipe.

I'm using linux-xilinx release 14.5 (vanilla kernel 3.8.0 ) for zync soc,
and I've applied this ipipe patch: ipipe-core-3.8-arm-1.patch

Am I using a wrong ipipe patch? I'm a little bit confuse.
Thanks





From:	Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
To:	<matteo.semmoloni@selex-es.com>, <xenomai@xenomai.org>,
Date:	29/05/2014 14.31
Subject:	Re: [Xenomai] User Space Interrupt not working



On 05/29/2014 02:11 PM, matteo.semmoloni@selex-es.com wrote:
>
>
> Hi all,
>
> I've pached (succefullly...I hope so) linux kernel 3.8 with Xenomai
2.6.3.
>
> I've two issue about interrupt handled in userspace: the first one is
> related to asynchronous notifications from kernelspace to userspace, the
> second one related to creation of interrupt in userspace.

This interface is deprecated, not recommended for new developments.
Please implement an RTDM driver and unblock the task in the "read" or an
"ioctl" call.

> 1) I've have an application that must be triggered by an IRQ; if I create
> interrupt in kernel space it works properly and interrupt service routine
> is fired. In this case, if I create a task at userspace, bind it to
kernal
> space interrupt and waiting for it, it doesn't work; userspace task is
> always blocked at rt_intr_wait() function. An unexpected behaviour occurs
> during debugging: when task switches to secondary mode adding a
breakpoint,
> task is released with error ENOSYS( -38) returned by rt_intr_wait().

Are you running on the ARM platform? If yes, you need the following patch:
http://www.xenomai.org/pipermail/xenomai/2014-May/031025.html


--
                                                                Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: graycol.gif
Type: image/gif
Size: 105 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140529/a8a0429d/attachment.gif>

Message-ID: <5387289F.2090404@xenomai.org>
Date: Thu, 29 May 2014 14:31:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OFBAF613A3.27D3BC8A-ONC1257CE7.003515C1-C1257CE7.0042F1F4@selex-es.com>
In-Reply-To: <OFBAF613A3.27D3BC8A-ONC1257CE7.003515C1-C1257CE7.0042F1F4@selex-es.com>
Content-Type: text/plain; charset=UTF-8
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
To: matteo.semmoloni@selex-es.com, xenomai@xenomai.org

On 05/29/2014 02:11 PM, matteo.semmoloni@selex-es.com wrote:
> 
> 
> Hi all,
> 
> I've pached (succefullly...I hope so) linux kernel 3.8 with Xenomai 2.6.3.
> 
> I've two issue about interrupt handled in userspace: the first one is
> related to asynchronous notifications from kernelspace to userspace, the
> second one related to creation of interrupt in userspace.

This interface is deprecated, not recommended for new developments.
Please implement an RTDM driver and unblock the task in the "read" or an
"ioctl" call.

> 1) I've have an application that must be triggered by an IRQ; if I create
> interrupt in kernel space it works properly and interrupt service routine
> is fired. In this case, if I create a task at userspace, bind it to kernal
> space interrupt and waiting for it, it doesn't work; userspace task is
> always blocked at rt_intr_wait() function. An unexpected behaviour occurs
> during debugging: when task switches to secondary mode adding a breakpoint,
> task is released with error ENOSYS( -38) returned by rt_intr_wait().

Are you running on the ARM platform? If yes, you need the following patch:
http://www.xenomai.org/pipermail/xenomai/2014-May/031025.html


-- 
                                                                Gilles.


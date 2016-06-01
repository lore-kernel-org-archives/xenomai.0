Date: Wed, 1 Jun 2016 14:25:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160601122543.GA14103@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A739854@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A739854@mb2010-1.intra.tut.fi>
Subject: Re: [Xenomai] rtdm_timer_start causes switching to secondary mode
 and Bug
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ali Umair <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Jun 01, 2016 at 12:15:57PM +0000, Ali Umair wrote:
> Hello
> 
> I am using 3.14.39-xenomai-3.0.1. I am trying following

Please use Xenomai 3.0.2

> 
> Kernel module:
> - Make a buffer i.e. char  buffer[4000][126] and initializing the buffer using memset in the initial thread
> - Filled the buffer in the read thread of module 
> - After filling the buffer start the timer 
> 
> As I start the timer after filling the buffer the kernel displays the message that switching to secondary  mode and A bug. The whole message is end of the email

The data you sent are unreadable. If you want help, and do not want
to give all the details asked by the
https://xenomai.org//asking-for-help/ page, then at least send
properly formatted logs.

Anyway, very much likely the timer address you pass to
rtdm_timer_start is not initialized, or the address you pass is
invalid, or becomes invalid because you used an object on stack.

In such a case, posting the code of the module would help: the
description you send describes what you think you are doing, the
code shows what you are really doing, and usually, if there is a
bug, it is because there is a difference between the two.

-- 
					    Gilles.
https://click-hack.org


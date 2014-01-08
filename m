Message-ID: <52CD48BB.6000608@xenomai.org>
Date: Wed, 08 Jan 2014 13:46:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2014010819392068395112@gmail.com>,
 <52CD40F1.1090707@xenomai.org> <2014010820435085431023@gmail.com>
In-Reply-To: <2014010820435085431023@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to port Linux 3.2.21 to beaglebone (TI AM3358
 Cortex A8 SoC)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "tianlangroot@gmail.com" <tianlangroot@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 01/08/2014 01:43 PM, tianlangroot@gmail.com wrote:
>     I am glad you have read my letter.
>     I have patched the Xenomai-2.6.1 to the Linux Kernel linux-omap 3.2.21. When I applied the patch to the target kernel it seems ok. 
> Now the problem is I don't know how to modify the hardware-dependent part for my board. Because I am a freshman about porting the linux kernel.
> I hope you can help me.

I am certainly not going to fix conflicts between a buggy patch and a
non-mainline kernel. So, I am afraid no, I will not help you.

However, same question again: why not using xenomai 2.6.3 and one of the
I-pipe patches it contains, including for beaglebone?

Please no top-posting or private messages.

Regards.

-- 
                                                                Gilles.


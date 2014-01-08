Message-ID: <52CD40F1.1090707@xenomai.org>
Date: Wed, 08 Jan 2014 13:13:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2014010819392068395112@gmail.com>
In-Reply-To: <2014010819392068395112@gmail.com>
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
Cc: xenomai <xenomai@xenomai.org>

On 01/08/2014 12:39 PM, tianlangroot@gmail.com wrote:
> As the TI AM3358 is not supported in 3.2.21 mainline kernel, I want
> to use the slightly patched kernel from linux-omap for Xenomai, but I
> don't know where should be changed in the Linux 3.2.21 source code.
> Can anyone help me?

Well, to do that, you have to apply xenomai patch to the linux-omap
kernel and fix the conflicts. But:
- the I-pipe patch for 3.2.21 has known bugs
- there is support for the beaglebone processor for 3.5, 3.8, 3.10,
without the bugs.

So, the question is: are you sure this is really what you want to do?

-- 
                                                                Gilles.


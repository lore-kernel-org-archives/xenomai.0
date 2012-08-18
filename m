Message-ID: <502F8A65.9020305@xenomai.org>
Date: Sat, 18 Aug 2012 14:28:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAGVaUoFSCeUWb2b9WXiSi1kNo6MhE8VGgSNdqo8N5Vco_=MNdA@mail.gmail.com>	<502F8228.6010008@xenomai.org>
	<CAGVaUoEx3+QCFSGUn8_t7ddxqu==4TtaERyuMchmhisZTXu8gQ@mail.gmail.com>
In-Reply-To: <CAGVaUoEx3+QCFSGUn8_t7ddxqu==4TtaERyuMchmhisZTXu8gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] The kernel stops after the message "Uncompressing
 Linux... done, booting the kernel."
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bao Rui <rbaocug@gmail.com>
Cc: xenomai@xenomai.org

On 08/18/2012 02:20 PM, Bao Rui wrote:

> Hi Gilles,
> 
> I guess I choose a hard way to integrated Xenomai for the TI's PSP :(
> 
> You are right, the better way is patch the Linux main line 3.2.21 with OMAP
> patch and IPIPE patch, not to integrate IPIPE patch to TI's PSP.


Just so we are clear, when telling you not to integrate Xenomai sources
into the patched kernel, I was talking about *Xenomai* sources, not
*I-pipe* patch. I would recommend maintaining a kernel tree patched with
the I-pipe patch. And in fact, this is the way the I-pipe patch is
maintained.

> 
> I go through the discuss between you and Stephan, finally Stephan work out
> it and upload the patch at the end of discussion, where we can find the
> patchs? Is is on the git tree of xenomai? Or I may need to following the
> steps which Stephan have been done again for the modifications.


No, the Xenomai git tree only contains patches for the mainline kernel,
maintaining patches for many vendor trees would require way too much
time when upgrading the I-pipe patch. But the two changes described by
Stefan are easy:
- ensure that the clock source is not GPTIMER1
- replace handle_IRQ with ipipe_handle_multi_irq in omap3_intc_handle_irq

-- 
                                                                Gilles.


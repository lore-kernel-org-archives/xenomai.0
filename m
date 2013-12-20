Message-ID: <52B401DC.6080002@xenomai.org>
Date: Fri, 20 Dec 2013 09:37:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52A184EC.40407@axelsw.it> <52A1C10B.4010101@xenomai.org>
 <52B3FE46.3010202@axelsw.it>
In-Reply-To: <52B3FE46.3010202@axelsw.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_set_priority hangs/loops sometimes on boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roberto Bielli <roberto.bielli@axelsw.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/20/2013 09:22 AM, Roberto Bielli wrote:
> Hi Gilles,
> 
> i attached an image with the stall. (Excuse me for the image but it's 
> impossibile in a fast way to convert into text ).
> The old backtrace is invalid. The system cannot be updated.

Why is that, you do not have the root password on your test system? The
root filesystem is read-only?

I am just asking you to upgrade your test system, to see if you can
reproduce the bug with the latest version, as a first step, not to
upgrade the systems you have installed in the field. A lot of things
happened since 2.5.6 and whatever linux version you are using, which is
why I would like you to test xenomai 2.6.3 with linux 3.8.13. I do not
have time to spare on an issue which has already been fixed.

> The new backtrace says that the system loop in __ipipe_walk_pipeline.
> It seems that irqpend_imask = 2 and irqpend_lowmask = (0,
> 4194304,......) are the problem.
> In a good start there arent that values.

Using a symbolic debugguer shows you the things by the wrong end of the
problem. It is a bit like looking at the sun with a microscope.
ipipe_walk_pipeline is a function which is called all the time in the
I-pipe patched kernel.

If you feel like debugging the issue you have yourself, instead of
answering my request of upgrading before retesting, my advice would be
that there is no subtitute to really understanding what the code does,
on a macroscopic view, rather than on a miscroscopic view of "variable x
has value y".

The first thing I would try, is to add a printk in the interrupt
controller masking function, and the gpio demux function, if there is
one, to see if either one is not called in a loop.

-- 
                                                                Gilles.


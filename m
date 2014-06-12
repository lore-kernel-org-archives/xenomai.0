Message-ID: <5399EA56.2050700@xenomai.org>
Date: Thu, 12 Jun 2014 19:58:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5396CD6D.8060806@axelsw.it> <5397644B.9060806@xenomai.org>
 <5399AD6C.8070905@axelsw.it>
In-Reply-To: <5399AD6C.8070905@axelsw.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Gdb freezes when stepping through rt_task_spawn.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Tessore <marco.tessore@axelsw.it>, xenomai@xenomai.org

On 06/12/2014 03:38 PM, Marco Tessore wrote:
> Thank you, I will try that commit.
> But I have another question about it:
> does the commit involve the patch to the kernel?
> Since my kernel was patched using i-pipe git for the vanilla 3.10, but 
> applied to a customized version of 3.11,
> if the commit involves the kernel patch, it can be difficult for me to 
> upgrade.

If you kept the ipipe kernel separated from Xenomai kernel sources, the
change is a change in xenomai sources, so the update should be painless.
If you put the xenomai-patched kernel under source control, then it will
be harder.

-- 
                                                                Gilles.


Date: Fri, 25 Sep 2015 17:02:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150925150248.GE1332@hermes.click-hack.org>
References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55E5E453.1080400@xenomai.org>
 <CAPuu0=jX6ig5L7SJrmPVOhCmOm=gwxEmTafTpOqzE85hOji8CA@mail.gmail.com>
 <55E5F849.1070708@xenomai.org> <55E5FB89.3080604@xenomai.org>
 <55E60743.30600@xenomai.org>
 <CAJqUr7zP85A6V7n9O=++iC4tJK8LCG5JC8xtO9Xd+u3sQW4G1A@mail.gmail.com>
 <5604517A.2000602@mperpetuo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5604517A.2000602@mperpetuo.com>
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Sep 24, 2015 at 12:39:38PM -0700, Dmitriy Cherkasov wrote:
> Hello,
> 
> I've added some basic FPU support. It does not do lazy switching, since 
> this is not supported in the arm64 kernel yet.

Xenomai only does lazy switching for the first use of FPU by a task,
but then switches eagerly: a user-space task is always created
without the XNFPU bit. Its first use of FPU causes a fault, which
then switches FPU context, and set the XNFPU bit. Starting from
there, every context switch to this tasks switches the FPU context.

> I've tested it 
> successfully with switchtest. Below is a pull request if you guys are 
> interested in picking this up.
> 
> -Dmitriy
> 
> The following changes since commit 17095784c6d3d44dc7f1512ffab9bb957e298466:
> 
>    cobalt/arm64: leave mm tracking to the pipeline (2015-09-17 15:08:34 
> +0200)
> 
> are available in the git repository at:
> 
>    http://gitlab.mperpetuo.com/it/xenomai-3.git arm64-fp
> 
> for you to fetch changes up to 4825d1c170b773e82f90dd15409dde489447301e:
> 
>    cobalt/arm64: add basic FPU support (2015-09-24 12:04:42 -0700)

Just had a look. It looks fine, except that:

- you should not set the XNFPU bit in xnarch_init_shadow_tcb,
this has been done by the upper layers
(kernel/cobalt/posix/thread.c, function pthread_create) for user
threads, and some kernel threads do not set the XNFPU bit when they
do not use the FPU

- you do not need to set it in xnarch_switch_fpu either:
xnarch_switch_fpu is only called for tasks which have the XNFPU bit
set (kernel/cobalt/thread.c function xnthread_switch_fpu).

- the context switch should set or clear a hardware bit somewhere to
cause any use of the FPU to cause a trap: some threads do not have
the XNFPU bit (some kernel threads), and you want any FPU use by
these threads to cause a trap rather than clobbering the fpu
context. Note that switchtest does not allow to test this case. This
bit should be flipped when loading the FPU context for a thread
which has the XNFPU bit.

Note that the last point requires modifying the I-pipe for arm64 to
emit I-pipe events when entering a fault caused by any FPU use. But
this modification is mandatory anyway, you also need it to handle
gracefully the FPU exceptions (div by zero, etc...).

And once you have that modification done, modifying the code to do
lazy switching for the first fault is not hard.

If you agree, I can propose patches for I-pipe and Xenomai to do
that, and let you test if it works.

-- 
					    Gilles.
https://click-hack.org


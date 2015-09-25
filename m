Date: Fri, 25 Sep 2015 20:01:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150925180137.GF1332@hermes.click-hack.org>
References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55E5E453.1080400@xenomai.org>
 <CAPuu0=jX6ig5L7SJrmPVOhCmOm=gwxEmTafTpOqzE85hOji8CA@mail.gmail.com>
 <55E5F849.1070708@xenomai.org> <55E5FB89.3080604@xenomai.org>
 <55E60743.30600@xenomai.org>
 <CAJqUr7zP85A6V7n9O=++iC4tJK8LCG5JC8xtO9Xd+u3sQW4G1A@mail.gmail.com>
 <5604517A.2000602@mperpetuo.com>
 <20150925150248.GE1332@hermes.click-hack.org>
 <560580E6.6070208@mperpetuo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560580E6.6070208@mperpetuo.com>
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

On Fri, Sep 25, 2015 at 10:14:14AM -0700, Dmitriy Cherkasov wrote:
> Hi Gilles,
> 
> Thank you for the feedback.
> 
> Yes, I saw that the armv7 design had trapped FPU usage and switched 
> context then. While this is good for performance of threads that never 
> use the FPU, it may introduce a one-time delay for threads that do, 
> which may not be desirable in a real-time system.
> 
> I haven't had a chance to measure the specific delay, so I am not sure 
> what the real impact is.

You can avoid that and only switch FPU for threads which have XNFPU,
that is what we did in xenomai 2.x). The cost of your solution is an
FPU switch for every context switch, whereas some threads, and
especially kernel-space threads, will never use the FPU.

> 
> Also, since Linux does not currently support lazy switching, we would 
> have to make sure the FPU is enabled (meaning FPU access traps are 
> disabled) every time we switch back to the kernel. As far as I can tell, 
> the FPU in Linux is always on for arm64. This is in contrast to armv7, 
> where it was okay to return to the kernel with FPU traps enabled.

That does not look like a problem.

-- 
					    Gilles.
https://click-hack.org


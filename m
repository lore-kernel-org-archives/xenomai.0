Date: Wed, 1 Jun 2016 17:45:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160601154543.GD14103@hermes.click-hack.org>
References: <574EFA37.5030607@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <574EFA37.5030607@mitre.org>
Subject: Re: [Xenomai] SIGDEBUG_RESCNT_IMBALANCE with recursive mutex
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeffrey Melville <jmelville@mitre.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Jun 01, 2016 at 11:07:35AM -0400, Jeffrey Melville wrote:
> Hi,
> 
> Setup: Xenomai 2.6.4 (actually 2.6 git rev 4f349cf0553, with a99426
> cherry-picked) with kernel 3.14.17 on a Zynq and the POSIX skin using
> the ipipe patches included with the specified git rev)
> 
> We've noticed that SIGDEBUG_RESCNT_IMBALANCE is generated when a
> (Xenomai) mutex is taken recursively by an NRT thread. The snippet at
> the bottom of this message will reproduce the issue. I omitted most of
> the error-checking for brevity.
> 
> A couple previous threads have discussed slightly similar problems, but
> I never saw final resolutions:
> http://www.xenomai.org/pipermail/xenomai/2012-January/025278.html

This issue is unrelated: setting a thread priority while holding a
mutex is clearly something we consider you should not be doing.

> http://www.xenomai.org/pipermail/xenomai/2014-October/031919.html

In this case, the mail asked the user to provide a test case, and
the user never provided one, it seems.

> 
> As far as "why are we doing this?", the problem area occurs in a test
> suite where some tests have to run as NRT threads because they don't
> have to run real-time and will get killed by the watchdog if they run as
> RT threads. Removing the Xenomai wrappers would also be complicated for
> reasons that are outside of the scope of this email.

Now we have a testcase it seems. However, a Xenomai mutex used by an
NRT thread only makes sense if the mutex is shared with an RT thread
(otherwise you could use plain Linux mutex). In that context, it
makes little sense to not enable priority inheritance on the mutex.
So, the question is: do you have the same problem if you enable
priority inheritance?

Also, could you check the function return values, to make sure that
you did not miss any error?

Regards.

-- 
					    Gilles.
https://click-hack.org


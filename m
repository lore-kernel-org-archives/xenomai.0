Date: Mon, 12 Oct 2015 10:10:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151012081028.GA23413@hermes.click-hack.org>
References: <20151011130536.GA1765@hermes.click-hack.org>
 <561B6002.3010409@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561B6002.3010409@siemens.com>
Subject: Re: [Xenomai] Issue with CONFIG_PREEMPT_VOLUNTARY
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Mon, Oct 12, 2015 at 09:23:46AM +0200, Jan Kiszka wrote:
> On 2015-10-11 15:05, Gilles Chanteperdrix wrote:
> > Hi,
> > 
> > It seems commit fdb5d54d04b8c3b6b6a6ad7ac2b6248cf0b415e0 in the
> > I-pipe kernels cause a warning when CONFIG_PREEMPT_VOLUNTARY and
> > CONFIG_IPIPE_DEBUG_INTERNAL are enabled. The culprit is the call to
> > __ipipe_root_p.
> 
> Compiler warning? Runtime warning? Which architecture? I assume that
> ftrace is on then, right?

Yes. Because preempt_disable()/preempt_enable*() is a nop without
CONFIG_PREEMPT_COUNT, __ipipe_root_p ends up being called without
any protection, and __ipipe_check_percpu_access() emits the warning.

> 
> > 
> > The following patch avoids this warning:
> 
> How?

It disables the test for preemption (the call to preempt_count()) in
__ipipe_check_percpu_access() if CONFIG_PREEMPT_COUNT is disabled,
because if it is disabled, you can not be preempted anywhere, so
calling __ipipe_root_p without protection is valid. Or maybe not?

-- 
					    Gilles.
https://click-hack.org


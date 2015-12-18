Date: Fri, 18 Dec 2015 18:12:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151218171203.GC21744@hermes.click-hack.org>
References: <5674331B.2010807@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5674331B.2010807@siemens.com>
Subject: Re: [Xenomai] SMAP-detected direct userspace access
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

On Fri, Dec 18, 2015 at 05:23:55PM +0100, Jan Kiszka wrote:
> Hi all,
> 
> I know this is legacy code, but this is where we currently stumbled into
> it, and maybe the same pattern also exists in 3.x:
> 
> http://git.xenomai.org/xenomai-2.6.git/tree/ksrc/skins/posix/syscall.c#n1182
> 
> more precisely:
> 
>     return pse51_mutex_check_init(&umx->shadow_mutex, attr);
> 
> Here we pass the userspace object for initialization to the core instead
> of handing over the kernel shadow and then copying over the result. Is
> there a reason for this? Could we have more of such cases?
> 
> Background: SMAP detects and prevents any direct userspace memory access
> on x86 except or those that are wrapped in stac() and clac() (which
> toggle a bit in eflags). Generally a useful feature we should allow to
> be enabled for robustness reasons.

BTW, I believe most RTnet ioctls have this issue.

-- 
					    Gilles.
https://click-hack.org


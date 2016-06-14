Date: Tue, 14 Jun 2016 19:04:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160614170443.GH23680@hermes.click-hack.org>
References: <E1b6BNz-0003TC-QN@sd-51317.xenomai.org>
 <20160614155740.GE23680@hermes.click-hack.org>
 <57602CA7.5050108@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57602CA7.5050108@siemens.com>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Allow to
 restart clock_nanosleep and select after signal processing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Tue, Jun 14, 2016 at 06:11:19PM +0200, Jan Kiszka wrote:
> On 2016-06-14 17:57, Gilles Chanteperdrix wrote:
> > On Fri, May 27, 2016 at 08:36:43AM +0200, git repository hosting wrote:
> >> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> >> index 060ce85..0f9ab14 100644
> >> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> >> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> >> @@ -133,4 +133,10 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
> >>  #error "Xenomai/cobalt requires Linux kernel 3.10 or above"
> >>  #endif /* < 3.10 */
> >>  
> >> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,0,0)
> >> +#define cobalt_get_restart_block(p)	(&task_thread_info(p)->restart_block)
> >> +#else
> >> +#define cobalt_get_restart_block(p)	(&(p)->restart_block)
> >> +#endif
> >> +
> > 
> > This is bad. First off as explained in the comment heading
> > wrappers.h the wrappers are ordered by kernel version and the most
> > recent is first. Second, no other wrapper has a #else clause, the
> > idea is that we want to be able to remove some old wrappers from
> > time to time, and removing the #if completely should be enough.
> > Obviously, if you put a #else, this does not work. I agree that in
> > that case it is going to be hard, but please try anyway...
> 
> I'm open for concrete ideas.

There are examples in wrapper.h, with COBALT_BACKPORT. Maybe this
can be used? The thing is that wrappers.h is supposed to contain
implementation of new services for older kernels;
cobalt_get_restart_block does not fit that definition.

> 
> > 
> > Other than that, I see your patch modifies each syscall handler
> > directly, can not the result be achieved in a different way? For
> > instance by factoring it in the core? Relying more on Linux syscall
> > restart mechanism.
> 
> Linux does it similarly, i.e. requires modifications on a per-syscall
> basis. As the logic is widely syscall-specific, I also don't see a
> generic way under Xenomai either. The good news is that all cases that
> Linux covers (minus futexes which we don't have) are already implemented
> in the patch, thus this shouldn't spread.

Ok, but much of the code you add runs under nklock, I am not sure I
see the use for this. Also, this code reuses an existing status bit
(XNLBALERT) for a different purpose, I foresee unforeseen
consequences with that. Also the case you handle is a corner case,
and with your patch, handling that corner case ends-up taking the
majority of the nanosleep code. And finally, maybe some changes
could be moved in the I-pipe patch, if that helps (reading the
commit message, I believe it could help).

So, all and all, I do not think this patch is acceptable as is.

-- 
					    Gilles.
https://click-hack.org


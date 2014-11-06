Date: Thu, 6 Nov 2014 12:47:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141106114734.GA28321@sisyphus.hd.free.fr>
References: <20141105205917.GA28595@sisyphus.hd.free.fr>
 <637400768.107888843.1415271440604.JavaMail.root@zimbra90-e16.priv.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <637400768.107888843.1415271440604.JavaMail.root@zimbra90-e16.priv.proxad.net>
Subject: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
 adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: tbultel@free.fr
Cc: xenomai@xenomai.org

On Thu, Nov 06, 2014 at 11:57:20AM +0100, tbultel@free.fr wrote:
> Hi Gilles,
> I can't afford going on that commit, it is a too old kernel and my BSP
> patch does not apply on it.
> Meanwhile, I have fixed the slowness issue, I had not payed enough
> attention to some rejections when applying the ipipe patch.
> 
> But this leads to the reason why I was interested in taking your latest
> ipipe patch.
> We used to work with the previous one, which was in 3 pieces (pre-x-post).

Yes, it is one piece now, because only mx6 users use the I-pipe
patch for Linux 3.0, so this reduces the maintenance cost.

I am surprised to hear that you are using this I-pipe patch as I had
heard it caused over-heating issue with your setup.

> 
> We are facing random kernel crashes when using the eth intensively.
> (ping -i 0.01 -s 65000)
> That crashs happen with both ipipe patches versions.
> 
> That random freeze only happen on some machines ( 3 machines on a total
> of 17 are impacted), that first had let us think about an hardware bug.
> (There are no CPU revs differences between those machines)
> But after some testing, the crash does not happen with a non-patched
> 3.0.35_4.1.0 kernel, or with a patched kernel that has CONFIG_IPIPE
> disabled.
> The freeze sometimes gives a backtrace on the serial port, sometimes not.
> See a backtrace sample below. It has rarely the same shape.
> 
> By doing some code re-reading, and performing some dichotomy,
> I found out that removing the mb() call in bufdesc_read_status() ....
> 
> static inline unsigned short bufdesc_read_status(struct bufdesc *bdp)
> {
> #if 0
> #ifdef CONFIG_ARCH_MX6
> 	mb();
> #endif /* CONFIG_ARCH_MX6 */
> #endif /* 0 */
> 	return bdp->cbd_sc;
> 
> }
> 
> ... makes the freeze less reproducible (a machine that froze in less
> than 10 secs stayed alive for 2h30)
> 
> I noticed that the call mb() is not done on more recent kernels.
> It is introduced by the Ipipe patch.
> I do not understand neither why it makes the freeze happen,

I believe I know why this happens. In order to workaround some
hardware issue, the imx6 idle loop is issuing calls to mb(), and
they cause starvation if a non-idle cpu is attempting to call mb().
The first fix that was posted on the lakml is to add a bunch of
"nops" in front of the mb() in the idle loop, I have not followed
how this got fixed finally. I would not be surprised if the fix for
this issue has not been backported to 3.0 kernels.

> nor why it is part of the ipipe patch.

It is part of the patch because it was passed in the tree I used
when starting working on imx6. Ironically, I believe it is a fix for
an eth lockup issue. Anyway, I do not believe this patch itself is a
problem, inserting a mb() should not cause any lockup, unless this
read_status function is called in a tight loop, which would cause
the issue mentioned above.

-- 
					    Gilles.


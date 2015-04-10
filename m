Date: Fri, 10 Apr 2015 18:11:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150410161112.GR20752@hermes.click-hack.org>
References: <5527DF9B.9020304@galauner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5527DF9B.9020304@galauner.de>
Subject: Re: [Xenomai] Xenomai on Linux 3.18 on Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Galauner <andreas@galauner.de>
Cc: xenomai@xenomai.org

On Fri, Apr 10, 2015 at 04:35:07PM +0200, Andreas Galauner wrote:
> On a sidenote: That patch
> https://git.xenomai.org/ipipe-gch.git/commit/?h=for-ipipe-3.18&id=f98b6d95359ea0429307d98759357d54dcfba7e8
> makes the board stop directly after the bootloader jumps into the
> kernel.

Please try branch for-ipipe-3.18 in ipipe-gch.git, it contains a
totally untested, not even compiled patch for fixing this particular
issue.

In short, I believe kmalloc may be using percpu, so ends-up using
ipipe_processor_id() which ends up dereferencing the NULL
__cpu_reverse_map, so I temporarily set __cpu_reverse_map to
__cpu_logical_map before calling kmalloc. 

This is correct, because at this point in the code we can rely on
__cpu_logical_map to contain what is necessary to be used as a
reverse map.

If the kernel still crashes, then the problem does not come from
kmalloc using per-cpu data.

-- 
					    Gilles.


Date: Thu, 6 Nov 2014 16:37:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141106153738.GC30908@sisyphus.hd.free.fr>
References: <545B9297.2090003@cgglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <545B9297.2090003@cgglobal.com>
Subject: Re: [Xenomai] rt_task_sleep_until() miss release point?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ZIV-Alberto Ozalla Cantabrana <alberto.ozalla@cgglobal.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Nov 06, 2014 at 03:24:08PM +0000, ZIV-Alberto Ozalla Cantabrana wrote:
> Hi all,
> 
> enclosed you will find two examples:
> 
>   *   rt_task_sleep_until() missing release point, and
>   *   rt_task_sleep_until() working fine.
> 
> In the first example:
> 
> Current time: t1=4205571 ms - Calculated next release point: t2= 4205572 ms
> Real release: t3=4205574 ms
> 
> Many Thanks
> Alberto Ozalla
> 
> Simplest example that shows the issue:

When you post an example, please post a "self contained" one, i.e.
one that can be compiled and run without:
- any missing code or ellipses
- references to functions not contained in the code or xenomai
librairies, such as cu_log.

> #1 SMP 20<6>kernel: [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d

You do not need CONFIG_SMP on an uniprocessor, this adds some
overhead. The overhead is mitigated on Xenomai 3, but not on xenomai
2.x.

-- 
					    Gilles.


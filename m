Date: Mon, 29 Feb 2016 20:16:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160229191625.GA26312@hermes.click-hack.org>
References: <20160229183956.5869650.18060.4@asyring.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160229183956.5869650.18060.4@asyring.de>
Subject: Re: [Xenomai] Ipipe 4.1 on Allwinner A20 (Cubietruck) takes a very
 long start time
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alexander Syring <xenomai@asyring.de>
Cc: xenomai@xenomai.org

On Mon, Feb 29, 2016 at 07:39:56PM +0100, Alexander Syring wrote:
> On. On, Feb 29, 2016 at 13:55, Gilles Chanteperdrix
>  wrote:‎
> >On Mon, Feb 29, 2016 at 01:47:17PM +0100, Alexander >Syring wrote:
> >> Hi
> >> I patched the 4.1.15 from git.xenomai.org to compile it on the Cubietruck.
> >> But it takes a long time to boot.
> > >‎
> > > [...]
> >> 
> >> has anyone a clue why it takes more than two hours to bring up the interrupt 
> >> pipeline?
> >
> >The problem is not the interrupt pipeline.
> >
> >The Allwinner A20 is not among the processors supported by the
> >I-pipe patch, (see list here: 
> http://xenomai.org/embedded-hardware/)
> >
> >Thus, before using this processor, you need to follow the porting
> >guide:
> >http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/
> >
> >Also you do not tell us what version of the I-pipe patch >you are
> >using, I guess not the latest, so you should try the latest to be
> >sure you get the latest fixes, notably:
> >
> >https://git.xenomai.org/ipipe.git/commit/?h=ipipe-4.1.y&id=0a037e7db92fb0f0c4a1d77c6bac38814649ee26
> 
> >Regards.
> 
> I used the last version from yesterday of the ipipe.git
> ipipe-4.1.y

I doubt that, since you are talking about 4.1.15 whereas yesterday
version is for 4.1.18. But "yesterday" is a vague notion anyway,
with people living around the world in different time zones. A
git hash is more precise. Are you using
9920b05b219c09c2fa7036d9d7db1a9bcf04094e ?
Also, I pointed you to a precise patch, has the patch been applied
on the kernel you use or not?

> 
> I tested 3.18.12 on Allwinner A20 before an here is the patch that I was using and the dmesg output.
> As you can see there is non delay of two hours.
> 
> I don't know, why 4.1 is so different to 3.18.12.

If you follow the porting guide, you will find out. Since you are
using an unsupported processor, no effort has been made when porting
the I-pipe git from 3.18 to 4.1 to preserve anything about the
processor you use. If you want to avoid that, follow the porting
guide, them submit a patch to the I-pipe git for supporting the
processor you us, then, when your patch is merged, attempts will be
made to avoid breaking support for this processor in later versions.

-- 
					    Gilles.
https://click-hack.org


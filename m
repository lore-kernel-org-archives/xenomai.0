Date: Mon, 30 Jun 2014 18:06:25 +0200
From: Arnaud Degroote <arnaud.degroote@isae.fr>
Message-ID: <20140630160625.GA5126@dmia-degroote.isae.fr>
References: <53B126EE.6020306@xenomai.org>
 <20140630091310.GA4019@dmia-degroote.isae.fr>
 <53B13914.2010706@xenomai.org>
 <20140630120135.GA4552@dmia-degroote.isae.fr>
 <53B1531F.4040504@xenomai.org>
 <20140630123704.GA32240@dmia-degroote.isae.fr>
 <20140630151836.GA14444@dmia-degroote.isae.fr>
 <53B1819F.10108@xenomai.org>
 <20140630154543.GA30922@dmia-degroote.isae.fr>
 <53B186B0.7030108@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53B186B0.7030108@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Support of Beagleboard xm rev C on 3.14-ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 30/Jun - 17:48, Gilles Chanteperdrix wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 06/30/2014 05:45 PM, Arnaud Degroote wrote:
> > On 30/Jun - 17:26, Gilles Chanteperdrix wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >> 
> >> On 06/30/2014 05:18 PM, Arnaud Degroote wrote:
> >>> On 30/Jun - 14:37, Arnaud Degroote wrote: [snip]
> >>>>> Have you checked that the exact same kernel configuration, 
> >>>>> only without CONFIG_IPIPE and CONFIG_XENOMAI runs
> >>>>> correctly under load?
> >>>> 
> >>>> The system seems to hang even without CONFIG_IPIPE. The 
> >>>> linux-yocto kernel seems to work properly (it looks like a 
> >>>> 3.14rc8), I will check precisely against linux kernel v3.14.
> >>> 
> >>> Some additional information
> >>> 
> >>> linux mainstream kernel on tag v3.14 runs fine on the
> >>> platform. The system hangs with ipipe branch ipipe-3.14
> >>> (without xenomai stuff, and without CONFIG_IPIPE).
> >> 
> >> In the two cases the configuration is exactly the same?
> >> 
> > Yes, there are no semantic difference. The only diff are
> > 
> > CONFIG_LOCALVERSION
> > 
> > and the ipipe kernel has the extra line
> > 
> > # CONFIG_IPIPE is not set
> > 
> If you have a rootfs without hardfp (based on the codesourcery
> toolchain for instance), could you try to boot without CONFIG_VFP?

I don't have such toolchain for the moment, but I can try to hack my
current yocto toolchain to test without hardfp. Still, I have compiled a
kernel without CONFIG_VFP but it still hangs in the same place, so I
don't think it is related to the current issue.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140630/ae030b96/attachment.sig>

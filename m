Date: Fri, 4 Jul 2014 09:19:39 +0200
From: Arnaud Degroote <arnaud.degroote@isae.fr>
Message-ID: <20140704071939.GA12028@dmia-degroote.isae.fr>
References: <7016-53b1af80-3d5-7f54e300@12077259>
 <53B1B529.9040106@xenomai.org>
 <20140701083910.GA28764@dmia-degroote.isae.fr>
 <53B27E5B.10507@xenomai.org>
 <20140701155123.GA5547@dmia-degroote.isae.fr>
 <53B30A78.40605@xenomai.org>
 <20140702114142.GA13439@dmia-degroote.isae.fr>
 <53B44879.5020203@xenomai.org>
 <20140703083807.GA10654@dmia-degroote.isae.fr>
 <53B54DEA.9020306@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53B54DEA.9020306@xenomai.org>
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

On 03/Jul - 14:34, Gilles Chanteperdrix wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 07/03/2014 10:38 AM, Arnaud Degroote wrote:
> > On 02/Jul - 19:59, Gilles Chanteperdrix wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >> 
> >> 
> >> Well, this sucks, posted writes increase the timer programming
> >> latency.
> >> 
> >> Does the latency test run correctly with this patch?
> > 
> > Yes, the latency test seems to work properly.
> 
> That is strange, because the Xenomai timer also uses non-posted writes.
> 
> > 
> > I need to investigate a bit more, because the kernel without the
> > patch seems to work properly with a different uboot (the one for my
> > gumstix) while it hangs with the uboot for my beagleboard.
> 
> Perhaps the u-boot which works implement some workaround for processor
> errata, which the u-boot which does not work does not implement?

I don't understand where the difference comes from. I tried with
several variants of u-boot, with the same patchlevel, and it always
works with 'omap_overo_config' and always hangs with
'omap_beagle_config'. I carefully read the two board code and make
several hack in beagle one to reduce diff with overo, but was not able
yet to reproduce the 'correct behaviour'.

Unfortunately,  I lack time to continue investigation, I will go for the
'posted' hack for the moment and will open an issue in my job
bugtracker. I may try also with uboot + dts.

Anyway, thanks a lot for your help Gilles. I will let you know if I make
significant progress on this issue.

Best regards,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140704/d8b39108/attachment.sig>

Message-ID: <530B4F14.8050400@xenomai.org>
Date: Mon, 24 Feb 2014 14:54:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1392798642.29863.YahooMailNeo@web163904.mail.gq1.yahoo.com>
 <201402191131.57684.paul_c@tuxcnc.org>
 <1392902695.25358.YahooMailNeo@web163905.mail.gq1.yahoo.com>
 <5306058A.7060107@xenomai.org>
 <1392906926.89759.YahooMailNeo@web163905.mail.gq1.yahoo.com>
 <53061485.6090500@xenomai.org>
 <1393246468.37730.YahooMailNeo@web163903.mail.gq1.yahoo.com>
In-Reply-To: <1393246468.37730.YahooMailNeo@web163903.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] armhf patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/24/2014 01:54 PM, Huub Van Niekerk wrote:
> On Thursday, February 20, 2014 3:44 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> On 02/20/2014 03:35 PM, Huub Van Niekerk wrote:
>  >
>  >
>  >
>  > On Thursday, February 20, 2014 2:39 PM, Gilles Chanteperdrix
>  > <gilles.chanteperdrix@xenomai.org
> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
>  > On 02/20/2014 02:24 PM, Huub Van Niekerk wrote:
>  >
>  >  >
>  >  >
>  >  > On Wednesday, February 19, 2014 12:32 PM, Paul <paul_c@tuxcnc.org
> <mailto:paul_c@tuxcnc.org>
>  > <mailto:paul_c@tuxcnc.org <mailto:paul_c@tuxcnc.org>>>
>  >  > wrote:
>  >  >
>  >  > On Wednesday 19 February 2014, Huub Van Niekerk wrote:
>  >  >
>  >  >> The patch you created for the armhf architecture, will it work
>  >  >> with older Linux kernels such as 2.6.x and 3.2.x as well ?
>  >  >
>  >  >> Just to clarify, the patch that I submitted is for the Broadcom
>  >  >> BCM2835 SoC (an ARMv6K core) - armhf covers a variety of ARM
>  >  >> flavours.
>  >  >
>  >  >> If you can find a 2.6.xx kernel that has support for the BCM2835
>  >  >> AND includes the DWC-OTG drivers, there is no reason why the
>  >  >> Raspberry Pi patch couldn't be adapted.
>  >  >
>  >  >> The 3.2.x kernel reportedly had a few serious bugs - I don't know
>  >  >> if these bugs impacted on the BCM2835 or the operation of Xenomai.
>  >  >> If you are looking at using a 3.x.x series kernel, it would be
>  >  >> advisable to get the latest stable release that has a corresponding
>  >  >> Xenomai patch.
>  >  >
>  >  > I just tried to build xenomai-2.6.2 on armhf (after applying your
>  >  > patch) using debuild -us -uc. This fails with an error I had before:
>  >  > fatal error at line 1350: dpkg-buildpackage -rfakeroot -B -us -uc
>  >  > failed. Does this mean that your patch is not suitable for v. 2.6.2
>  >
>  >  > ?
>  >
>  >  >Please do not use 2.6.2, it was so buggy that 2.6.2.1 was released just
>  >  >a little time after. And in fact, there is no reason not to use 2.6.3,
>  >  >it is ABI compatible with 2.6.2 and 2.6.2.1.
>  >
>  > OK. The reason I tried 2.6.2 is that this version has a patch for kernel
>  > 3.2, which 2.6.3 has not, as far as I can see.
>
>  >Bad reason:
>  >- the patch for 3.2 is broken, as has been said several times on this
>  >mailing list, including in the very first answer you received in this
>  >same discussion thread;
>  >- the latest version of Xenomai should be compatible with all the past
>  >patches (though it only has been well tested with the latest patch it
>  >provides).
>
> Out of curiosity: has this patch actually been tested on an armhf board
> prior to releasing to me or stock ?

I do not known what patch you are talking about. But the I-pipe patches 
are tested on omap3 and omap4, with armhf compilers before each release.

Now, if you are talking about the generation of Debian packages, 2.6.2 
was released with a broken debian/rules, which was the main reason for 
releasing 2.6.2.1. Now, I have to admit that I do not generate debian 
packages, I let others do it.

I consider that validating Xenomai with armhf compiler proves that it 
can work.

-- 
					    Gilles.


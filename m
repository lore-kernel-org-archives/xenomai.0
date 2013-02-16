From: Paul <paul_c@tuxcnc.org>
Date: Sat, 16 Feb 2013 00:20:53 +0000
References: <201302141227.05428.paul_c@tuxcnc.org>
	<511D3F8F.8090501@xenomai.org>
	<201302151150.44164.paul_c@tuxcnc.org>
In-Reply-To: <201302151150.44164.paul_c@tuxcnc.org>
MIME-Version: 1.0
Message-Id: <201302160020.53324.paul_c@tuxcnc.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai, Raspberry Pi, 3.5.7 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Friday 15 February 2013, Paul wrote:
> On Thursday 14 February 2013, Gilles Chanteperdrix wrote:
> > On 02/14/2013 01:27 PM, Paul wrote:
> > > Attached, a patch set aimed at providing support for the Broadcom
> > > BCM2835 SoC as used in the Raspberry Pi[1].
> >
> > In the meantime, we can put it in a raspberry subdirectory in
> > Xenomai sources. Would you mind making a single patch? Or do you
> > prefer the patches to be kept separated?
>
> A single patch would be preferable for most people - The multi-patch
> set was mainly for the benefit of the guys who had a working kernel
> but were sturggling with the GPIO problem (patch No.4 should apply on
> a 3.2.2x kernel).
>
> I'll rename the defconfig and add some recent changes made to
> the "official" Raspberry kernel. Expect a single patch in a day or
> two.

Attached, a single patch against ipipe-core-3.5.7. This assumes the 
appropriate arm patch has already been applied to a virgin stable 3.5.7 
tree as per standard instructions.

The raspberry-post.patch provides support for the BCM2835 SoC backported 
from the rpi-3.6.y branch[1] up to, and including commit 871eef1b84. A 
minimal config is provided (bcmrpi_xenomai_defconfig) in place of the 
usual bcmrpi_*_defconfigs.

Credit for the original 3.2.21 Xenomai support should go to ian-cim as 
noted in earlier emails - My efforts are limited to backporting and 
hacks to the gpio interrupts.


Regards, Paul.


[1] git://github.com/raspberrypi/linux.git


-------------- next part --------------
A non-text attachment was scrubbed...
Name: ipipe-core-3.5.7-raspberry-post.patch
Type: text/x-diff
Size: 2724091 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130216/4f487e30/attachment.patch>

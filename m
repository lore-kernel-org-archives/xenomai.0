From: Paul <paul_c@tuxcnc.org>
Date: Mon, 15 Apr 2013 11:52:09 +0100
References: <516BA4E9.3070201@xenomai.org>
In-Reply-To: <516BA4E9.3070201@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201304151152.09727.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] Raspberry and Beaglebone patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Stephan Kappertz <stephan.kappertz@kabelmail.de>, Xenomai <xenomai@xenomai.org>


Hi Gilles

On Monday 15 April 2013, Gilles Chanteperdrix wrote:
> we have a problem with the patches for Raspberry and BeagleBone: they
> are based on the 3.2.21 patch, which we know is broken. So, we can
> not really ship the next version of Xenomai with these patches.

The original Raspberry patch from Ian-cim consisted of adding ipipe 
timer support to the BSP sources in 3.2.21. My efforts concentrated on 
backporting some of the Raspberry specific support from their 3.6.y 
tree to Xenomai 3.5.7 - Any breakages in 3.2.xx shouldn't be an issue.

> There are two ways we could keep patches for these machines:
> - you could send patches for 3.4 or 3.5, or even 3.8

The Raspberry patch is already at 3.5.7, not sure what state the 
raspberry-3.8.y tree is in at the moment. Time allowing, I'll have a 
look at a 3.8 patch over the next few days.

> - we could backport the fixes to 3.2, but as already discussed on
> this list, this would cost some time to re-validate the 3.2 patch on
> all architectures. However, if you do the backport, validate it on
> your side, I could validate the result on my test boards, and we
> would release a new version of the patch for 3.2 only for the ARM
> architecture.

I feel my time would be better spent on updating to 3.8, so I'll give 
the backport a miss for now ;-)


Regards, Paul.



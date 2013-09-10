From: Paul <paul_c@tuxcnc.org>
Date: Wed, 11 Sep 2013 00:57:41 +0100
References: <E9605457112439448B6B3ED284E06533317AC337@mbx256-1.adm.swri.edu>
	<201305232352.24308.paul_c@tuxcnc.org>
	<522F68FD.9070009@xenomai.org>
In-Reply-To: <522F68FD.9070009@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201309110057.41709.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] Next Xenomai Release?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tuesday 10 September 2013, Gilles Chanteperdrix wrote:
> On 05/24/2013 12:52 AM, Paul wrote:
> > On Thursday 23 May 2013, Gilles Chanteperdrix wrote:
> >> On 05/23/2013 05:57 PM, Poole Jr, Donald R. wrote:
> >>> I guess I overlooked that post and response. Any clarifying
> >>> words/steps on what needs to be done to get the 3.8.x kernel
> >>> patched with Xenomai for running on the Beaglebone/Raspberry Pi
> >>> in the meantime?
> >>
> >> For beaglebone, it is integrated in the I-pipe tree for the ARM
> >> architecture (git://git.xenomai.org/ipipe-gch.git, branch
> >> for-core-3.8), which is currently based on 3.8.0 but will probably
> >> be rebased on a more recent version for the I-pipe 3.8 release,
> >> for the raspberry pi, you can try the patch which has been posted
> >> by Paul, but probably needs rebasing once the I-pipe for 3.8 is
> >> released.
> >
> > I have a set of patches ready for 3.8.8 based on the "official"
> > Raspberry Pi sources [1] - Need to reduce the current set of nine
> > down to a pre and post pair which I'll try to do over the weekend.
> > In the meantime, if anyone wants to take the set for a spin, drop
> > me a note and I'll send them over.
>
> Hi Paul,
>
> I have at last pushed the final version of the I-pipe patch for Linux
> 3.8.13, it is available both in the xenomai git as a patch and in the
> I-pipe git.
>
> Could you rebase the pre- and post- patches for Raspberry so that I
> can put them in the Xenomai sources too?

Will do, although it will have to wait until the weekend.

> Also note that the I-pipe patch for 3.10.0 is available, but it is
> probably not yet the final version.

Looks like BCM2835 support is making its way in to the mainline kernel, 
so I'll also take a look at 3.10.y and report back.

> Thanks in advance.
> Regards.




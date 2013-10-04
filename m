From: Paul <paul_c@tuxcnc.org>
Date: Fri, 4 Oct 2013 13:36:32 +0100
References: <CAK4EZFSLBBOs174xP+JAsqgJgG-MJ5UxMsj_FD5Pzjh1BHz7gw@mail.gmail.com>
	<52435E3D.7020202@xenomai.org>
	<201309261032.30542.paul_c@tuxcnc.org>
In-Reply-To: <201309261032.30542.paul_c@tuxcnc.org>
MIME-Version: 1.0
Message-Id: <201310041336.33020.paul_c@tuxcnc.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Raspberry Pi patch issue?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Thursday 26 September 2013, Paul wrote:
> On Wednesday 25 September 2013, Gilles Chanteperdrix wrote:
> > On 09/24/2013 02:00 PM, Paul wrote:
> > > On Tuesday 24 September 2013, Adam Vaughan wrote:
> > >> I'm trying to build with the most recent xenomai-head in git for
> > >> the Raspberry Pi, and I'm encountering an issue (see below) when
> > >> I try to run prepare-kernel.sh . =A0I'm very new to this whole
> > >> process (so it definitely could be user error), but it would
> > >> seem that there's a problem with the patch.
> > >
> > > I'll have a look at it this evening and report back after making
> > > a few checks.
> >
> > any news? Maybe I committed the wrong versions?
>
> My fault entirely - I used the wrong ipipe-core patch in preparing
> the pre patch. Will have another look over the next couple of days
> (trying to fit it in around work commitments).

Apologies for the delay in looking at this. Please find updated patches.

1) Checkout kernel sources from git://github.com/raspberrypi/linux.git =

and use the rpi-3.8.y branch - d996a1b is the SHA-1 hash used, but =

later revisions should work.
2) Apply ipipe-core-3.8.13-raspberry-pre-2.patch
3) Apply ipipe-core-3.8.13-arm-2 patch
4) Apply ipipe-core-3.8.13-raspberry-post-2.patch
5) Resume generic installation instructions.


Regards, Paul.





-------------- next part --------------
A non-text attachment was scrubbed...
Name: ipipe-core-3.8.13-raspberry-post-2.patch
Type: text/x-diff
Size: 7296 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131004/60573d3=
c/attachment.patch>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ipipe-core-3.8.13-raspberry-pre-2.patch
Type: text/x-diff
Size: 652 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131004/60573d3=
c/attachment-0001.patch>

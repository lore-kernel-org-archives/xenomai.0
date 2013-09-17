From: Paul <paul_c@tuxcnc.org>
Date: Tue, 17 Sep 2013 16:26:07 +0100
References: <E9605457112439448B6B3ED284E06533317AC337@mbx256-1.adm.swri.edu>
	<201305232352.24308.paul_c@tuxcnc.org>
	<522F68FD.9070009@xenomai.org>
In-Reply-To: <522F68FD.9070009@xenomai.org>
MIME-Version: 1.0
Message-Id: <201309171626.08100.paul_c@tuxcnc.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
> I have at last pushed the final version of the I-pipe patch for Linux
> 3.8.13, it is available both in the xenomai git as a patch and in the
> I-pipe git.
>
> Could you rebase the pre- and post- patches for Raspberry so that I
> can put them in the Xenomai sources too?

Attached, two patches. Instructions for use:

1) Checkout kernel sources from git://github.com/raspberrypi/linux.git 
and use the rpi-3.8.y branch - d996a1b is the SHA-1 hash used, but 
later revisions should work.
2) Apply ipipe-core-3.8.13-raspberry-pre.patch
3) Apply ipipe-core-3.8.13-arm patch
4) Apply ipipe-core-3.8.13-raspberry-post.patch


Regards, Paul.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: ipipe-core-3.8.13-raspberry-post.patch
Type: text/x-diff
Size: 12108 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130917/586ff21e/attachment.patch>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ipipe-core-3.8.13-raspberry-pre.patch
Type: text/x-diff
Size: 5292 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130917/586ff21e/attachment-0001.patch>

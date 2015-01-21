Date: Wed, 21 Jan 2015 18:20:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150121172006.GF16075@hermes.click-hack.org>
References: <1421852743-21535-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1421852743-21535-1-git-send-email-sr@denx.de>
Subject: Re: [Xenomai] [PATCH] hal/arm: Add Zynq v3.14.17 patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stefan Roese <sr@denx.de>
Cc: xenomai@xenomai.org

On Wed, Jan 21, 2015 at 04:05:43PM +0100, Stefan Roese wrote:
> Xilinx Zynq is already supported in the mainline Xenomai git repository.
> This patch adds support for the v3.14.17 Linux Kernel with the latest
> arm-6 i-pipe patch additionally to the already present v3.5 and v3.8
> support.

It would be nice if Zynq support could be integrated into the
mainline I-pipe git, is Zynq support still experimental, do people
still need to use a fork ?

> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
> Please note that the arm-6 patch that is referenced in the README

One (the only?) interest of -pre and -post patches is to be able to
update the I-pipe patch without updating the pre and post patches.
So, I believe the README should not mention a particular version of
the I-pipe patch. I would rather say: apply
ipipe-core-3.1.4.17-arm-*.patch
Maybe you could say that it has been tested with that version, so
that people realize that it may be broken if they use a later I-pipe
release, but not mention this particular version in the README.

Otherwise, looking at the patches themselves: the pre patch reverts
smp.c and git.c to the mainline version, and the post patch does not
update them. It means you revert the changes made to these files by
the fork you use. Is it OK for you ?

-- 
					    Gilles.


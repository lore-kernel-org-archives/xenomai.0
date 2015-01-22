Message-ID: <54C0AD98.2080900@denx.de>
Date: Thu, 22 Jan 2015 08:58:16 +0100
From: Stefan Roese <sr@denx.de>
MIME-Version: 1.0
References: <1421852743-21535-1-git-send-email-sr@denx.de>
 <20150121172006.GF16075@hermes.click-hack.org>
In-Reply-To: <20150121172006.GF16075@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] hal/arm: Add Zynq v3.14.17 patches
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

On 21.01.2015 18:20, Gilles Chanteperdrix wrote:
> On Wed, Jan 21, 2015 at 04:05:43PM +0100, Stefan Roese wrote:
>> Xilinx Zynq is already supported in the mainline Xenomai git repository.
>> This patch adds support for the v3.14.17 Linux Kernel with the latest
>> arm-6 i-pipe patch additionally to the already present v3.5 and v3.8
>> support.
>
> It would be nice if Zynq support could be integrated into the
> mainline I-pipe git, is Zynq support still experimental, do people
> still need to use a fork ?

At least for v3.14 it might make sense. The Xilinx git repository has 
quite a lot of patches on top of the kernel.org releases (e.g. v3.14). 
For even newer kernel versions this is most likely not necessary.

>> Signed-off-by: Stefan Roese <sr@denx.de>
>> ---
>> Please note that the arm-6 patch that is referenced in the README
>
> One (the only?) interest of -pre and -post patches is to be able to
> update the I-pipe patch without updating the pre and post patches.
> So, I believe the README should not mention a particular version of
> the I-pipe patch. I would rather say: apply
> ipipe-core-3.1.4.17-arm-*.patch

I was just trying to make things clear here. And also following the 
other examples in the README. I can surely send a v2 patch with your 
recommendation to use the ipipe-core-3.1.4.17-arm-*.patch.

> Maybe you could say that it has been tested with that version, so
> that people realize that it may be broken if they use a later I-pipe
> release, but not mention this particular version in the README.

Okay. I'll send a v2 later today.

> Otherwise, looking at the patches themselves: the pre patch reverts
> smp.c and git.c to the mainline version, and the post patch does not
> update them. It means you revert the changes made to these files by
> the fork you use. Is it OK for you ?

Yes. This is similar to the v3.8 pre and post patches.

Thanks,
Stefan



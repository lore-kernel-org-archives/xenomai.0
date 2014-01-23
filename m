Message-ID: <52E17786.2070008@xenomai.org>
Date: Thu, 23 Jan 2014 21:11:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1390318566-3704-1-git-send-email-sr@denx.de>
In-Reply-To: <1390318566-3704-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v3] hal/arm: Add Zynq v3.5.7 patches
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

On 01/21/2014 04:36 PM, Stefan Roese wrote:
> Xilinx Zynq is already supported in the mainline Xenomai git repository.
> This patch adds support for the v3.5.7 Linux Kernel with the latest
> arm-6 i-pipe patch additionally to the already present v3.8 support.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
> v3:
> - Removed all non-ipipe related patches from post- patch
> - Only EXPORT_SYMBOL_GPL(init_mm) is now removed
> 
> v2:
> - Base pre-patch on top of a different git reopsitory based on v3.5.7
> - Remove defconfig and other board specific stuff from post-patch
> - All this leads to minimal pre- and post- patches as requested
>   by Gilles
> 
>  ksrc/arch/arm/patches/README                       |  11 +-
>  .../patches/zynq/ipipe-core-3.5.7-zynq-post.patch  | 271 +++++++++++++++++++++
>  .../patches/zynq/ipipe-core-3.5.7-zynq-pre.patch   |  28 +++
>  3 files changed, 309 insertions(+), 1 deletion(-)
>  create mode 100644 ksrc/arch/arm/patches/zynq/ipipe-core-3.5.7-zynq-post.patch
>  create mode 100644 ksrc/arch/arm/patches/zynq/ipipe-core-3.5.7-zynq-pre.patch

Merged, thanks.


-- 
                                                                Gilles.


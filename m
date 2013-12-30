Message-ID: <52C1EA3B.2030009@xenomai.org>
Date: Mon, 30 Dec 2013 22:48:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1388416530-5865-1-git-send-email-sr@denx.de>
In-Reply-To: <1388416530-5865-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] hal/arm: Add Zynq v3.5.7 patches
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

On 12/30/2013 04:15 PM, Stefan Roese wrote:
> Xilinx Zynq is already supported in the mainline Xenomai git repository.
> This patch adds support for the v3.5.7 Linux Kernel with the latest
> arm-6 i-pipe patch additionally to the already present v3.8 support.

Sorry, I can not take these patches:
- they contain changes in the I-pipe core not related to the Zynq
architecture, these should be submitted separately as patches to the
I-pipe git itself;
- they contain changes in the Linux code, not related to Zynq either,
probably due to a mismatch between the stable revision you are using. In
order to use a more recent revision, please post a patch modifying the
I-pipe git to use that more recent stable revision;
- they contain a defconfig file, if you want to make that file
available, please put it to some ftp or http server somewhere and put
the URL in the readme;

Really, the pre and post patches should be short, here they are enormous.



-- 
                                                                Gilles.


Message-ID: <5528EAF4.4000500@xenomai.org>
Date: Sat, 11 Apr 2015 11:35:48 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1427256943-8654-1-git-send-email-sr@denx.de>
In-Reply-To: <1427256943-8654-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] ipipe: drivers/irqchip/irq-vic.c: Fix
 problems with ipipe in VIC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stefan Roese <sr@denx.de>, xenomai@xenomai.org

On 03/25/2015 05:15 AM, Stefan Roese wrote:
> These changes are needed to enable the VIC interrupt handler for I-pipe usage.
> This patch version is for the "ipipe-3.18" branch in Philippes "ipipe" git
> respository. But a quick search reveals that such a fix very likely is needed
> for kernel version from v3.10 onward.
> 
> Tested on SPEAr600 based board with v3.18.
> 

Merged, thanks.

-- 
Philippe.


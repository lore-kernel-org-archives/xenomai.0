Message-ID: <51D6FC56.9000504@xenomai.org>
Date: Fri, 05 Jul 2013 19:03:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201307051538.58306.marex@denx.de>
In-Reply-To: <201307051538.58306.marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on i.MX28 failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, xenomai@xenomai.org

On 07/05/2013 03:38 PM, Marek Vasut wrote:

> Hello,
>
> I attempted to use xenomai on i.MX28-based board, but unfortunatelly failed so
> far. I use mainline Linux 3.8.2 on the board with no additional patches,
> therefore I did:
>
>    git clone git://git.xenomai.org/xenomai-2.6.git
>
> To retrieve xenomai-2.6/master . Then I went on to patch the Linux kernel
> source:
>
> ./scripts/prepare-kernel.sh --linux=../linux-stable --
> ipipe=ksrc/arch/arm/patches/ipipe-core-3.8-arm-1.patch --arch=arm
>
> Next I ran "make oldconfig" in the kernel tree. I enabled XENOMAI and left the
> newly added configuration options at their default values.
>
> After compiling the kernel, the kernel does not boot on the board anymore, while
> the kernel did boot before patching without problems.
>
> Can you please give me any pointers or ideas on how to progress ?


Try:
http://xenomai.org/index.php/I-pipe-core:ArmPorting

-- 
                                                                 Gilles.


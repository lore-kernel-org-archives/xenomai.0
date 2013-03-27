Message-ID: <51535BCB.3060503@xenomai.org>
Date: Wed, 27 Mar 2013 21:51:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOE4DFVVtMzJT94a3YDa_wpxCkRH4-AR_PO54eEBM7AjMnSLnw@mail.gmail.com>
In-Reply-To: <CAOE4DFVVtMzJT94a3YDa_wpxCkRH4-AR_PO54eEBM7AjMnSLnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] (no subject)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mohammadreza Babaee <mrezababaee@gmail.com>
Cc: xenomai@xenomai.org

On 03/27/2013 05:23 PM, Mohammadreza Babaee wrote:

> Dear Xenomai,
> 
> 
> I have applied the xenomai to kernel of Freescale (Version 3.0.15) but in
> compiling got this error
> 
> arch/arm/mach-mx6/clock.c: In function '_clk_gpt_get_rate':
> arch/arm/mach-mx6/clock.c:1857:2: error: implicit declaration of function
> 'mx6_timer_rate' [-Werror=implicit-function-declaration]


Hi,

Please do not send mails without subject.

You probably applied the patch to the wrong kernel version. See
ksrc/arch/arm/patches/README in Xenomai kernel sources for the exact git
commit to which you should apply the patch.

Alternatively, you can use the ipipe-3.0-imx6q branch in ipipe-gch git tree:
http://git.xenomai.org/?p=ipipe-gch.git;a=shortlog;h=refs/heads/ipipe-3.0-imx6q

Regards.

-- 
                                                                Gilles.


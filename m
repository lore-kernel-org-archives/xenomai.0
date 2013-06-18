Message-ID: <444d9db3c3f7aa888b7a0136c58a4567.squirrel@www.xenomai.org>
In-Reply-To: <A46EF8CF1BBB8E4B8A27B73E177C4664F7578B@MAIL-SINTERS-01.sinters-int.fr>
References: <A46EF8CF1BBB8E4B8A27B73E177C4664F7578B@MAIL-SINTERS-01.sinters-int.fr>
Date: Tue, 18 Jun 2013 17:51:04 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] No Rootfs after installing Xenomai !
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Younes CHALABI <y.chalabi@sinters.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Younes CHALABI wrote:
> Hi,
>
> I want to install xenomai on the i.MX6Q Sabre Lite board, for this I
> followed differents strategies but still not able to have xenomai on the
> target.
>
>
>      1- linux-3.5.7 vs xenomai-2.6.2.1 vs ipipe-core-3.5.7-arm-3.patch :
>           Using the installation procedure for ARM from :
> www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/
>                The problem with this strategy is that I hadn't a rootfs to
> boot the target, so I took a different strategy.
>                     HOW CAN I HAVE A ROOTFS TO BOOT THE TARGET WITH THE
> COMPILED SOURCES ?

Hi Younes,

Sorry for the first empty answer.

As I already told you in a private mail, the answer to this question has
nothing to do with Xenomai. You can use any tool you want to generate a
root filesystem. snapgear, buildroot, openwrt, ptxdist, openembedded,
multiple solutions exist.

Regards.

-- 
                    Gilles.



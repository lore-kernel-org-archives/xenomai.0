Date: Tue, 24 May 2016 20:02:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160524180256.GM13609@hermes.click-hack.org>
References: <0abe0634dbf999057bf8529e0cc0ecd8@stud.hs-heilbronn.de>
 <20160523075954.GJ13609@hermes.click-hack.org>
 <674a5761ce5e9da1774b90b499a2e3d6@stud.hs-heilbronn.de>
 <20160524135324.GA11602@hermes.click-hack.org>
 <48747eda7ad827e2f69dd3d159a606bc@stud.hs-heilbronn.de>
 <b19757cdceb6cde95fb69b49a99f1361@stud.hs-heilbronn.de>
 <0ffacf8b2a8fe70df9e590c2964e3639@stud.hs-heilbronn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ffacf8b2a8fe70df9e590c2964e3639@stud.hs-heilbronn.de>
Subject: Re: [Xenomai] Xenomai on Udoo Neo
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mfinkbei <mfinkbei@stud.hs-heilbronn.de>
Cc: xenomai@xenomai.org

On Tue, May 24, 2016 at 07:47:23PM +0200, mfinkbei wrote:
> On Tue, May 24, 2016 at 05:48:48PM +0200, mfinkbei wrote:
> > I adapted the I-pipe patch 3.14.44 to the kernel 3.14.56.
> 
> There is more than one version of the I-pipe patch for 3.14.44,
> actually there are 7. Which one of the 7 are you using?
> You can find the history of I-pipe patches for 3.14.44 here:
> https://xenomai.org//downloads/ipipe/v3.x/arm/older/
> 
> > The files,
> > which will be changed in the patch for kernel 3.14.44 have just little
> > differences.
> 
> My point is: the I-pipe patch, provided that you are using
> the last version, patches some device tree files, but these may not
> be the device tree files you use with your kernel fork.
> 
> To be completely specific I am referring to the following hunk:
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi 
> b/arch/arm/boot/dts/imx6qdl.dtsi
> index fb28b2e..bf84723 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -106,6 +106,13 @@
>   			clocks = <&clks 15>;
>   		};
> 
> +		timer@00a00200 {
> +			compatible = "arm,cortex-a9-global-timer";
> +			reg = <0x00a00200 0x20>;
> +			interrupts = <1 11 0xf01>;
> +			clocks = <&clks 15>;
> +		};
> +
> 
> Does the device tree file you use include this file?
> 
> -- 
> 					    Gilles.
> https://click-hack.org

When you answer a mail, it is customary to strip the signature. Most
civilized mail user agent do this for you. In fact, it is even
customary to only keep the part of the mails which are relevant for
your answer (but very few people do that nowadays).


> 
> I  used the ipipe-core-3.14.44-arm-16.patch.
> The hunk that you reffering to was defined as followed:
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi 
> b/arch/arm/boot/dts/imx6qdl.dtsi
> index fb28b2e..bf84723 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -132,6 +132,13 @@
>   			clocks = <&clks IMX6QDL_CLK_TWD>;
>   		};
> 
> +		timer@00a00200 {
> +			compatible = "arm,cortex-a9-global-timer";
> +			reg = <0x00a00200 0x20>;
> +			interrupts = <1 11 0xf01>;
> +			clocks = <&clks IMX6QDL_CLK_TWD>;
> +		};
> +
>   		L2: l2-cache@00a02000 {
>   			compatible = "arm,pl310-cache";
>   			reg = <0x00a02000 0x1000>;

No, the file
https://xenomai.org//downloads/ipipe/v3.x/arm/older/ipipe-core-3.14.44-arm-16.patch
does not contain this hunk. So, if the patch you are using contains
this hunk, you are not using ipipe-core-3.14.44-arm-16.patch.

Anyway, I can find the hunk a patch contains, downloading the patch
from the server. This is not what I am asking you. The question I
have been trying to ask three times and to which I can not find the
answer because I do not have the sources you use is: does the device
tree file you use include imx6ql.dtsi?

When you do not understand a question, I prefer you to tell me,
rather than giving a random answer. This is very irritating.

-- 
					    Gilles.
https://click-hack.org


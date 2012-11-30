Message-ID: <50B8BEAA.607@xenomai.org>
Date: Fri, 30 Nov 2012 15:11:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E715748DB106B94DAE5D77B7F3D1DC4101BB100291@CIPL-MAIL.in.canon-asia.com>
In-Reply-To: <E715748DB106B94DAE5D77B7F3D1DC4101BB100291@CIPL-MAIL.in.canon-asia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem with bringing up Xenomai User Space
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dharma R Bhushan <Dharma.Bhushan@sdc.canon.co.in>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/30/2012 03:04 PM, Dharma R Bhushan wrote:
> Hello Community Members,
> 
> I am trying to run test cases present in xenomai-2.5.6 test suite. We are getting the "Segmentation fault".
> 
> Environment is as follows
> 
>  Board:                         Bagle-board XM rev C
>  Kernel:                      2.6.35.14(2.6.35 from kernel.org+patch-2.6.35.10+linaro-2.6.35.10 patch+ patch-2.6.35.11+ patch-2.6.35.12+patch-2.6.35.13+ patch-2.6.35.14)
>  I-Pipe patch:          adeos-ipipe-2.6.35.9-arm-1.18-03.patch(slightly modified to apply the above kernel)
>  Tool chain:                  arm-none-linux-gnueabi-

If the toolchain is a linaro toolchain (all toolchains have been called
arm-none-linux-gnueabi- for a few years now, so the information you give
us is essentially a non-information) with a thumb glibc, you absolutely
need CONFIG_ARM_ERRATA_430973 enabled in the kernel configuration, even
and especially if xenomai is configured in arm mode (which is required
with xenomai 2.5.6 anyway).

Other than that, I urge you to update to xenomai 2.6.1.

-- 
					    Gilles.


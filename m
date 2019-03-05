Subject: Re: [PATCH 7/7] travis: append v5.0 to the matrix
References: <20190305144521.2567-1-roman.stratiienko@globallogic.com>
 <20190305144521.2567-7-roman.stratiienko@globallogic.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0a6780c1-d0c8-66a3-9930-6012c491aebc@siemens.com>
Date: Tue, 5 Mar 2019 19:24:22 +0100
MIME-Version: 1.0
In-Reply-To: <20190305144521.2567-7-roman.stratiienko@globallogic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: roman.stratiienko@globallogic.com, xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On 05.03.19 15:45, roman.stratiienko--- via Xenomai wrote:
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> ---
>   .travis.yml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 0807760f4..ab23b745d 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -46,6 +46,11 @@ script:
>   
>   matrix:
>     include:
> +    - env:
> +      - ARCH: arm
> +        KERNEL_VERSION: 5.0
> +        KERNEL_DEFCONFIG: multi_v7_defconfig
> +        IPIPE_URL: https://github.com/devel-opi/linux-ipipe-arm-porting/releases/download/v5.0-draft1/ipipe-arm-v5.0-draft.patch
>       - env:
>         - ARCH: arm
>           KERNEL_VERSION: 4.20.7
> 

OK, looking at this and also the full matrix, I think we need to discuss what 
variation we want to test and from which sources.

It is generally useful to have the patch application process tested as well, but 
I think the primary, more easily maintainable source for CI would be git 
branches that reflect the latest version of the patch and the kernel series. So, 
one for 4.4, one for 4.14, one for tip, and all that multiplied by supported arch.

I'm not maintaining I-pipe on ARM - Philippe can better comment on how to ensure 
best that your effort is integrated smoothly into mainline. But I would prefer 
to pull your contributions from the I-pipe kernel tree for CI.

Thanks a lot for your patches! They are very valuable contributions.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


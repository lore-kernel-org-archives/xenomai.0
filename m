MIME-Version: 1.0
References: <a5fc19bc-df67-ba55-7546-fd361ac3fe0d@siemens.com>
In-Reply-To: <a5fc19bc-df67-ba55-7546-fd361ac3fe0d@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 5 Feb 2021 09:50:59 -0500
Message-ID: <CALLqZ8Q+pfcJDvLtpGAhXsppDr50kignkkKOp7isN_jA1YDNJg@mail.gmail.com>
Subject: Re: [PATCH] ci: Add 5.4 release builds for arm and arm64
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Fri, Feb 5, 2021 at 9:48 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Greg, should we also drop a kernel version from CI for arm and arm64?
> The 4.14ers?
>
>  .gitlab-ci.yml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 87532a3376..19c24dc88a 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -165,6 +165,14 @@ variables:
>      paths:
>        - .ccache
>
> +arm-5.4-release:
> +  extends: .build
> +  variables:
> +    ARCH: arm
> +    IPIPE_REV: ipipe-core-5.4..*-arm-.*
> +    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm.git
> +    KERNEL_DEFCONFIG: multi_v7_defconfig
> +
>  arm-4.19-release:
>    extends: .build
>    variables:
> @@ -189,6 +197,14 @@ arm-4.4-cip-head:
>      IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe.git
>      KERNEL_DEFCONFIG: multi_v7_defconfig
>
> +arm64-5.4-release:
> +  extends: .build
> +  variables:
> +    ARCH: arm64
> +    IPIPE_REV: ipipe-core-5.4..*-arm64-.*
> +    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm64.git
> +    KERNEL_DEFCONFIG: defconfig
> +
>  arm64-4.19-release:
>    extends: .build
>    variables:
> --
> 2.26.2


Please drop the 4.14 kernels. I=E2=80=99ll have a new 4.19 for both arm and=
 arm64
by the end of the weekend.

-Greg

>
>

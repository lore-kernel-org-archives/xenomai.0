Subject: Re: [xenomai-images][PATCH] Fix linux repo for 5.10 ARM
References: <0bf0a241-624c-0d9e-7dc8-25eaa69de85e@qmul.ac.uk>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bfd72055-a5e3-76dd-532a-600331501f30@siemens.com>
Date: Tue, 9 Feb 2021 20:17:47 +0100
MIME-Version: 1.0
In-Reply-To: <0bf0a241-624c-0d9e-7dc8-25eaa69de85e@qmul.ac.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, Giulio Moro via Xenomai <xenomai@xenomai.org>

On 09.02.21 18:49, Giulio Moro wrote:
> From: Giulio Moro <giuliomoro@yahoo.it>
> 
> Signed-off-by: Giulio Moro <giuliomoro@yahoo.it>
> ---
>  recipes-kernel/linux/linux-xenomai_latest.bb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb
> b/recipes-kernel/linux/linux-xenomai_latest.bb
> index bbec6b0..e6834fd 100644
> --- a/recipes-kernel/linux/linux-xenomai_latest.bb
> +++ b/recipes-kernel/linux/linux-xenomai_latest.bb
> @@ -25,7 +25,7 @@ def is_kernel(d, ver):
>  GIT_REPO_amd64 = "${@'git://github.com/xenomai-ci/ipipe.git' if
> is_xeno_3_0(d) else 'git://git.evlproject.org/linux-evl.git' if
> is_kernel(d, '5.10') else 'git://github.com/xenomai-ci/ipipe-x86.git'}"
>  GIT_BRANCH_amd64 = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else
> 'dovetail/master' if is_kernel(d, '5.10') else 'ipipe-x86-5.4.y' if
> is_kernel(d, '5.4') else 'ipipe-x86-4.19.y-cip'}"
> 
> -GIT_REPO_armhf = "${@'git://github.com/xenomai-ci/ipipe.git' if
> is_xeno_3_0(d) else 'git://github.com/xenomai-ci/ipipe-arm.git'}"
> +GIT_REPO_armhf = "${@'git://github.com/xenomai-ci/ipipe.git' if
> is_xeno_3_0(d) else 'git://git.evlproject.org/linux-evl.git' if
> is_kernel(d, '5.10') else 'git://github.com/xenomai-ci/ipipe-arm.git'}"
>  GIT_BRANCH_armhf = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else
> 'dovetail/master' if is_kernel(d, '5.10') else 'ipipe/5.4.y' if
> is_kernel(d, '5.4') else 'ipipe/4.19-y-cip'}"
> 
>  GIT_REPO_arm64 = "git://github.com/xenomai-ci/ipipe-arm64.git"
> -- 
> 2.17.1

Thanks, noticed that as well and pushed a force-update to wip/dovetail
earlier.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


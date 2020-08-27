Subject: Re: [xenomai-images][PATCH] ci: set default to no-artifacts
References: <20200827142430.24355-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0b443ad9-1e6e-1cfb-5a44-54fc8445ff42@siemens.com>
Date: Thu, 27 Aug 2020 17:39:02 +0200
MIME-Version: 1.0
In-Reply-To: <20200827142430.24355-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8
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
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 27.08.20 16:24, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If the ci system with artifacts is execute on a system without
> the necessary infrastructure the gitlab-ci.yml is invalid.
> Fix this by setting the default build to ci/no-artifacts.yml
> and remove the dependency to USE_GITLAB_ARTIFACTS.
> 
> Add option to build with artifacts
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci-artifacts.yml | 12 ++++++++++++
>  .gitlab-ci.yml           |  2 +-
>  ci/artifacts.yml         |  3 ---
>  tests/README.md          |  2 +-
>  4 files changed, 14 insertions(+), 5 deletions(-)
>  create mode 100644 .gitlab-ci-artifacts.yml
> 
> diff --git a/.gitlab-ci-artifacts.yml b/.gitlab-ci-artifacts.yml
> new file mode 100644
> index 0000000..e6576dc
> --- /dev/null
> +++ b/.gitlab-ci-artifacts.yml
> @@ -0,0 +1,12 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2019 - 2020
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +include:
> +  - local: '/ci/artifacts.yml'
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index e6576dc..0e547f0 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -9,4 +9,4 @@
>  # SPDX-License-Identifier: MIT
>  #
>  include:
> -  - local: '/ci/artifacts.yml'
> +  - local: '/ci/no-artifacts.yml'
> diff --git a/ci/artifacts.yml b/ci/artifacts.yml
> index 3d20323..510f903 100644
> --- a/ci/artifacts.yml
> +++ b/ci/artifacts.yml
> @@ -17,8 +17,5 @@
>      paths:
>      - build/tmp/deploy/images/${TARGET}/
>      expire_in: 1 week
> -  only:
> -    variables:
> -      - $USE_GITLAB_ARTIFACTS
>  include:
>    - local: '/ci/gitlab-ci-base.yml'
> diff --git a/tests/README.md b/tests/README.md
> index 119f90f..e0d50a9 100644
> --- a/tests/README.md
> +++ b/tests/README.md
> @@ -122,9 +122,9 @@ The following variables are used and set by the ci system:
>  - General build settings
>    - `BUILD_OPTIONS` : optional parameter. Used for triggers. Overwrite to build the newest ipipe together with xenomai or other combinations.
>    - `DEPLOY_DIR_EXTENSION`: Extension path to store artifacts for the same target
> -  - `USE_GITLAB_ARTIFACTS`: If set this changes the deploy url to a gitlab api URL
>    - `JOB_TEMPLATE_PATH`: Path to the test templates - Default tests/jobs/xenomai
>    - `TARGET_EXTENSION`: Extension of the build job name
> +
>  ## LAVA Template variable
>  
>  - `TARGET`: Name of the target in the LAVA Lab
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


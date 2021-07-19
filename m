Subject: Re: [xenomai-images][PATCH 1/3] ci: Remove artifact deployment
References: <20210719142947.3034-1-Quirin.Gylstorff@siemens.com>
 <20210719142947.3034-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <65aedf49-73e3-2e83-d400-6a1a9bc0e54f@siemens.com>
Date: Mon, 19 Jul 2021 16:47:52 +0200
MIME-Version: 1.0
In-Reply-To: <20210719142947.3034-2-Quirin.Gylstorff@siemens.com>
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

On 19.07.21 16:29, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> We will use AWS S3 deployment for LAVA CI Artifacts. Therefore
> remove the Deployment via gitlab artifacts as the LAVA Lab is now public
> available.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci-artifacts.yml            | 13 -----------
>  .gitlab-ci.yml                      | 20 ++++++++++++++++-
>  ci/artifacts.yml                    | 20 -----------------
>  ci/child_pipelines_artifacts.yml    | 34 -----------------------------
>  ci/child_pipelines_no_artifacts.yml | 34 -----------------------------
>  ci/gitlab-ci-base.yml               |  5 ++---
>  ci/no-artifacts.yml                 | 13 -----------
>  scripts/get-build-id.sh             | 34 -----------------------------
>  scripts/run-lava-tests.sh           |  8 ++-----
>  9 files changed, 23 insertions(+), 158 deletions(-)
>  delete mode 100644 .gitlab-ci-artifacts.yml
>  delete mode 100644 ci/artifacts.yml
>  delete mode 100644 ci/child_pipelines_artifacts.yml
>  delete mode 100644 ci/child_pipelines_no_artifacts.yml
>  delete mode 100644 ci/no-artifacts.yml
>  delete mode 100755 scripts/get-build-id.sh
> 
> diff --git a/.gitlab-ci-artifacts.yml b/.gitlab-ci-artifacts.yml
> deleted file mode 100644
> index 85345b8..0000000
> --- a/.gitlab-ci-artifacts.yml
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -#
> -# Xenomai Real-Time System
> -#
> -# Copyright (c) Siemens AG, 2019 - 2021
> -#
> -# Authors:
> -#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -
> -include:
> -  - local: '/ci/child_pipelines_artifacts.yml'
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index a808859..b5a3a35 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -10,4 +10,22 @@
>  #
>  
>  include:
> -  - local: '/ci/child_pipelines_no_artifacts.yml'
> +  - local: '/ci/child_pipelines_common.yml'

Is common still needed? Or should this be migrated here as well?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


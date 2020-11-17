Subject: Re: [xenomai-images][PATCH v2 1/4] ci: Split build and add 5.4 builds
References: <20201106145632.2951-1-Quirin.Gylstorff@siemens.com>
 <20201106145632.2951-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <40958a8a-1cf2-ba31-9a6d-8beb2e021ae7@siemens.com>
Date: Tue, 17 Nov 2020 13:01:16 +0100
MIME-Version: 1.0
In-Reply-To: <20201106145632.2951-2-Quirin.Gylstorff@siemens.com>
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
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org, "Bezdeka, Florian (DF FA PMA DH ERL-3)" <florian.bezdeka@siemens.com>

On 06.11.20 15:56, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Split the ci build description in 4.4(xenomai-3.0.x), 4.19 and 5.4.
> This allows the reuse of build descriptions and simplifies the adding
> of new builds.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  ci/4_19_builds.yml                           |  82 +++++++++++++
>  ci/5_4_builds.yml                            |  38 ++++++
>  ci/artifacts.yml                             |   1 +
>  ci/default-builds.yml                        |  76 ++++++++++++
>  ci/gitlab-ci-base.yml                        | 116 ++-----------------
>  ci/xenomai_3_0_x.yml                         |  36 ++++++
>  opt-linux-4.19.yml                           |  17 +++
>  opt-linux-latest-5.4.yml                     |  18 +++
>  opt-linux-latest.yml                         |   1 +
>  recipes-kernel/linux/linux-xenomai_latest.bb |   6 +-
>  10 files changed, 282 insertions(+), 109 deletions(-)
>  create mode 100644 ci/4_19_builds.yml
>  create mode 100644 ci/5_4_builds.yml
>  create mode 100644 ci/default-builds.yml
>  create mode 100644 ci/xenomai_3_0_x.yml
>  create mode 100644 opt-linux-4.19.yml
>  create mode 100644 opt-linux-latest-5.4.yml
> 

...

> diff --git a/opt-linux-latest-5.4.yml b/opt-linux-latest-5.4.yml
> new file mode 100644
> index 0000000..6ce3a3b
> --- /dev/null
> +++ b/opt-linux-latest-5.4.yml
> @@ -0,0 +1,18 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2019
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 8
> +
> +local_conf_header:
> +  linux-xenomai-latest: |
> +    PREFERRED_VERSION_linux-xenomai = "9999-%"
> +    LATEST_GIT_BRANCH = "4.19"

This should have been 5.4 as Florian found out. Fixed up in next.

I also missed that unfortunately, and it actually papered over a bug in
ipipe-core-5.4.77-x86-1. Debugging that next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


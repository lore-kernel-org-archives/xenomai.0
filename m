Subject: Re: [xenomai-images][PATCH 3/4] ci: Split build and add 5.4 builds
References: <20201104161154.32366-1-Quirin.Gylstorff@siemens.com>
 <20201104161154.32366-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <26554d28-7219-f8d9-8739-e474d30a3f5a@siemens.com>
Date: Wed, 4 Nov 2020 19:28:21 +0100
MIME-Version: 1.0
In-Reply-To: <20201104161154.32366-4-Quirin.Gylstorff@siemens.com>
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
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 04.11.20 17:11, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Split the ci build description in 4.4(xenomai-3.0.x), 4.19 and 5.4.
> This allows the reuse of build descriptions and simplifies the adding
> of new builds.

Would be good the express that correlation between kernel version and 
Xenomai version somehow as well. Longer job names? Or is there some 
better way?

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   ci/4_19_builds.yml                           |  58 ++++++++++
>   ci/5_4_builds.yml                            |  30 +++++
>   ci/artifacts.yml                             |   4 +
>   ci/default-builds.yml                        |  76 +++++++++++++
>   ci/gitlab-ci-base.yml                        | 110 +------------------
>   ci/no-artifacts.yml                          |   4 +
>   ci/xenomai_3_0_x.yml                         |  36 ++++++
>   opt-linux-4.19.yml                           |  17 +++
>   opt-linux-latest.yml                         |   3 +
>   recipes-kernel/linux/linux-xenomai_latest.bb |   6 +-
>   scripts/get-build-id.sh                      |   2 +-
>   11 files changed, 237 insertions(+), 109 deletions(-)
>   create mode 100644 ci/4_19_builds.yml
>   create mode 100644 ci/5_4_builds.yml
>   create mode 100644 ci/default-builds.yml
>   create mode 100644 ci/xenomai_3_0_x.yml
>   create mode 100644 opt-linux-4.19.yml
> 
> diff --git a/ci/4_19_builds.yml b/ci/4_19_builds.yml
> new file mode 100644
> index 0000000..25be0c5
> --- /dev/null
> +++ b/ci/4_19_builds.yml
> @@ -0,0 +1,58 @@
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
> +variables:
> +  LATEST_GIT_BRANCH: "4.19"
> +  DEPLOY_DIR_EXTENSION: "4.19"
> +  BUILD_IDENTIFIER: "4.19"
> +
> +build-4.19:board-qemu-amd64:
> +  extends: .build:board-qemu-amd64
> +
> +lava-test-4.19:qemu-amd64:
> +  needs: [ "build-4.19:board-qemu-amd64" ]
> +  extends: .lava-test:qemu-amd64
> +
> +build-4.19:board-qemu-armhf:
> +  extends: .build:board-qemu-armhf
> +
> +lava-test-4.19:qemu-armhf:
> +  needs: [ "build-4.19:board-qemu-armhf" ]
> +  extends: .lava-test:qemu-armhf
> +
> +build-4.19:board-qemu-arm64:
> +  extends: .build:board-qemu-arm64
> +
> +lava-test-4.19:qemu-arm64:
> +  needs: [ "build-4.19:board-qemu-arm64" ]
> +  extends: .lava-test:qemu-arm64
> +
> +build-4.19:board-hikey:
> +  extends: .build:board-hikey
> +
> +lava-test-4.19:board-hikey:
> +  needs: [ "build-4.19:board-hikey" ]
> +  extends: .lava-test:board-hikey
> +
> +build-4.19:board-beagle-bone-black:
> +  extends: .build:board-beagle-bone-black
> +
> +lava-test-4.19:board-beagle-bone-black:
> +  needs: [ "build-4.19:board-beagle-bone-black" ]
> +  extends: .lava-test:board-beagle-bone-black
> +
> +build-4.19:board-x86-64-efi:
> +  extends: .build:board-x86-64-efi
> +
> +lava-test-4.19:board-x86-64-efi:
> +  needs: [ "build-4.19:board-x86-64-efi" ]
> +  extends: .lava-test:board-x86-64-efi
> +
> +
> diff --git a/ci/5_4_builds.yml b/ci/5_4_builds.yml
> new file mode 100644
> index 0000000..b5cfdb9
> --- /dev/null
> +++ b/ci/5_4_builds.yml
> @@ -0,0 +1,30 @@
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
> +variables:
> +  LATEST_GIT_BRANCH: "5.4"
> +  DEPLOY_DIR_EXTENSION: "5.4"
> +  BUILD_IDENTIFIER: "5.4"
> +
> +build-5.4:board-qemu-amd64:
> +  extends: .build:board-qemu-amd64
> +
> +lava-test-5.4:qemu-amd64:
> +  needs: [ "build-5.4:board-qemu-amd64" ]
> +  extends: .lava-test:qemu-amd64
> +
> +build-5.4:board-x86-64-efi:
> +  extends: .build:board-x86-64-efi
> +
> +lava-test-5.4:board-x86-64-efi:
> +  needs: [ "build-5.4:board-x86-64-efi" ]
> +  extends: .lava-test:board-x86-64-efi
> +
> +
> diff --git a/ci/artifacts.yml b/ci/artifacts.yml
> index 510f903..cc42274 100644
> --- a/ci/artifacts.yml
> +++ b/ci/artifacts.yml
> @@ -19,3 +19,7 @@
>       expire_in: 1 week
>   include:
>     - local: '/ci/gitlab-ci-base.yml'
> +  - local: '/ci/default-builds.yml'
> +  - local: '/ci/4_19_builds.yml'
> +  - local: '/ci/5_4_builds.yml'
> +  - local: '/ci/xenomai_3_0_x.yml'

Can we de-duplicate the common parts of ci/[no-]artifacts.yml, at least 
the includes?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


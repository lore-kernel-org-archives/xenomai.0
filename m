Subject: Re: [Xenomai-images PATCH 1/4] ci: Build and test from gitlab.com
References: <20200421083130.13437-1-Quirin.Gylstorff@siemens.com>
 <20200421083130.13437-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4663240e-8873-a24a-7d4a-7b2620c76e5a@siemens.com>
Date: Tue, 21 Apr 2020 11:09:36 +0200
MIME-Version: 1.0
In-Reply-To: <20200421083130.13437-2-Quirin.Gylstorff@siemens.com>
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

On 21.04.20 10:31, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Adapt scripts and gitlab-ci.yml to build on public available
> gitlab infrastructure.
> 
> As the internal gitlab system has no artifact storage and
> it is not possible to deactivate arifact upload with a variable
> split the gitlab-ci.yml. The .gitlab-ci.yml in the root points
> to .ci/gitlab-com.yml.

Why hidden ".ci/" and not just "ci/"?

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   .ci/gitlab-ci-base.yml                        | 153 ++++++++++++++++++
>   .ci/gitlab-com.yml                            |  26 +++
>   .ci/siemens-ci.yml                            |  22 +++
>   .gitlab-ci.yml                                | 145 +----------------
>   scripts/deploy_for_testing.sh                 |   4 +-
>   scripts/get-build-id.sh                       |  29 ++++
>   scripts/install-lavacli.sh                    |   5 +-
>   scripts/run-lava-tests.sh                     |   8 +-
>   ...bone.yml => xenomai-beagle-bone-black.yml} |   4 +-
>   tests/jobs/xenomai-hikey.yml                  |   4 +-
>   tests/jobs/xenomai-ipc227e.yml                |   6 +-
>   tests/jobs/xenomai-minnow.yml                 |   6 +-
>   tests/jobs/xenomai-qemu-amd64.yml             |   6 +-
>   tests/jobs/xenomai-qemu-arm64.yml             |   6 +-
>   tests/jobs/xenomai-qemu-armhf.yml             |   6 +-
>   ...omai-x86-64.yml => xenomai-x86-64-efi.yml} |   6 +-
>   16 files changed, 265 insertions(+), 171 deletions(-)
>   create mode 100644 .ci/gitlab-ci-base.yml
>   create mode 100644 .ci/gitlab-com.yml
>   create mode 100644 .ci/siemens-ci.yml
>   create mode 100755 scripts/get-build-id.sh
>   rename tests/jobs/{xenomai-beaglebone.yml => xenomai-beagle-bone-black.yml} (91%)
>   rename tests/jobs/{xenomai-x86-64.yml => xenomai-x86-64-efi.yml} (86%)
> 
> diff --git a/.ci/gitlab-ci-base.yml b/.ci/gitlab-ci-base.yml
> new file mode 100644
> index 0000000..e8d259f
> --- /dev/null
> +++ b/.ci/gitlab-ci-base.yml
> @@ -0,0 +1,153 @@
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
> +stages:
> +  - build
> +  - lava-test
> +
> +variables:
> +  GIT_STRATEGY: clone
> +  http_proxy: "$HTTP_PROXY"
> +  https_proxy: "$HTTPS_PROXY"
> +  ftp_proxy: "$FTP_PROXY"
> +  no_proxy: "$NO_PROXY"
> +  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
> +  LINUX_BUILD_OPTION: ":opt-linux-latest.yml"
> +  ISAR_IMAGE: demo-image
> +  ISAR_DISTRIBUTION: xenomai-demo
> +
> +default:
> +  image: kasproject/kas-isar:latest
> +
> +# add lavacli to the container and install the ssh keys
> +# for the test infrastructure
> +.add-lava-ssh-config:
> +  before_script:
> +    - mkdir -p -m=700 ~/.ssh
> +    - if [ -n "$https_proxy" ]; then echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config; fi;
> +    - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/lava_id_rsa && chmod 600 ~/.ssh/lava_id_rsa
> +    - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
> +
> +.test:
> +  extends: .add-lava-ssh-config
> +  stage: lava-test
> +  script:
> +    - scripts/install-lavacli.sh
> +    - export BUILD_JOB_ID=$(scripts/get-build-id.sh ${BUILD_JOB_NAME})
> +    - scripts/run-lava-tests.sh ${TARGET}
> +  variables:
> +    BUILD_JOB_NAME: "build:board-${TARGET}${TARGET_EXTENSION}"
> +  only:
> +    variables:
> +      - $LAVA_SSH_USER
> +
> +
> +build:board-qemu-amd64:
> +  extends: .build
> +  variables:
> +    TARGET: qemu-amd64
> +
> +lava-test:qemu-amd64:
> +  needs: [ "build:board-qemu-amd64" ]
> +  dependencies: [ "build:board-qemu-amd64" ]
> +  extends: .test
> +  variables:
> +    TARGET: qemu-amd64
> +
> +build:board-qemu-armhf:
> +  extends: .build
> +  variables:
> +    TARGET: qemu-armhf
> +
> +lava-test:qemu-armhf:
> +  needs: [ "build:board-qemu-armhf" ]
> +  extends: .test
> +  variables:
> +    TARGET: qemu-armhf
> +
> +build:board-qemu-arm64:
> +  extends: .build
> +  variables:
> +    TARGET: qemu-arm64
> +
> +lava-test:qemu-arm64:
> +  needs: [ "build:board-qemu-arm64" ]
> +  extends: .test
> +  variables:
> +    TARGET: qemu-arm64
> +
> +build:board-hikey:
> +  extends: .build
> +  variables:
> +    TARGET: hikey
> +    BUILD_OPTIONS: ":opt-lava-test.yml"
> +
> +lava-test:board-hikey:
> +  needs: [ "build:board-hikey" ]
> +  extends: .test
> +  variables:
> +    TARGET: hikey
> +
> +build:board-beagle-bone-black:
> +  extends: .build
> +  variables:
> +    TARGET: beagle-bone-black
> +    BUILD_OPTIONS: ":opt-lava-test.yml"
> +
> +lava-test:board-beagle-bone-black:
> +  needs: [ "build:board-beagle-bone-black" ]
> +  extends: .test
> +  variables:
> +    TARGET: beagle-bone-black
> +
> +build:board-x86-64-efi:
> +  extends: .build
> +  variables:
> +    TARGET: x86-64-efi
> +    BUILD_OPTIONS: ":opt-lava-test.yml"
> +
> +lava-test:board-x86-64-efi:
> +  needs: [ "build:board-x86-64-efi" ]
> +  extends: .test
> +  variables:
> +    TARGET: x86-64-efi
> +
> +build:board-beagle-bone-black:xenomai-3.0.x:
> +  extends: .build
> +  variables:
> +    TARGET: beagle-bone-black
> +    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
> +    BUILD_OPTIONS: ":opt-lava-test.yml"
> +    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
> +
> +lava-test:board-beagle-bone-black:xenomai-3.0.x:
> +  needs: [ "build:board-beagle-bone-black:xenomai-3.0.x" ]
> +  extends: .test
> +  variables:
> +    TARGET: beagle-bone-black
> +    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
> +    TARGET_EXTENSION: ":xenomai-3.0.x"
> +
> +build:board-x86-64-efi:xenomai-3.0.x:
> +  extends: .build
> +  variables:
> +    TARGET: x86-64-efi
> +    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
> +    BUILD_OPTIONS: ":opt-lava-test.yml"
> +    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
> +
> +lava-test:board-x86-64-efi:xenomai-3.0.x:
> +  needs: [ "build:board-x86-64-efi:xenomai-3.0.x" ]
> +  extends: .test
> +  variables:
> +    TARGET: x86-64-efi
> +    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
> +    TARGET_EXTENSION: ":xenomai-3.0.x"
> +
> diff --git a/.ci/gitlab-com.yml b/.ci/gitlab-com.yml
> new file mode 100644
> index 0000000..0abb3fb
> --- /dev/null
> +++ b/.ci/gitlab-com.yml
> @@ -0,0 +1,26 @@
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
> +.build:
> +  extends: .add-lava-ssh-config
> +  stage: build
> +  script:
> +    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
> +  artifacts:
> +    paths:
> +    - build/tmp/deploy/images/${TARGET}/

Can't we put that path completely into a variable and leave that empty 
for CI setups that do not support (large) artifacts?

Jan

> +    expire_in: 1 week
> +  only:
> +    variables:
> +      - $USE_GITLAB_ARTIFACTS
> +include:
> +  - local: '/.ci/gitlab-ci-base.yml'
> +
> +

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


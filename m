Subject: Re: [xenomai-images][PATCH 2/9] machine: Allow override of the image
 type
References: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
 <20190905154425.10007-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6d9d18f6-3336-423d-f411-534a250cba41@siemens.com>
Date: Tue, 10 Sep 2019 12:25:39 +0200
MIME-Version: 1.0
In-Reply-To: <20190905154425.10007-3-Quirin.Gylstorff@siemens.com>
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

On 05.09.19 17:44, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> For the NFS rootfs a tarball is used. This changes allows
> local.conf to set the IMAGE_TYPE from wic-img to targz-img.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   .gitlab-ci.yml               |  4 ++--
>   conf/machine/hikey.conf      |  2 +-
>   conf/machine/x86-64-efi.conf |  2 +-
>   xenomai-lava-test.yml        | 20 ++++++++++++++++++++
>   4 files changed, 24 insertions(+), 4 deletions(-)
>   create mode 100644 xenomai-lava-test.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index b78a0ac..ebc5cd5 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -64,7 +64,7 @@ build:board-beaglebone:
>     <<: *lava-ssh-key
>     stage: build
>     script:
> -    - kas build kas.yml:board-beagle-bone-black.yml
> +    - kas build kas.yml:board-beagle-bone-black.yml:xenomai-lava-test.yml
>       - scripts/deploy_for_testing.sh beagle-bone-black
>       - scripts/run-lava-tests.sh beaglebone
>   
> @@ -72,6 +72,6 @@ build:board-x86-64-efi:
>     <<: *lava-ssh-key
>     stage: build
>     script:
> -    - kas build kas.yml:board-x86-64-efi.yml
> +    - kas build kas.yml:board-x86-64-efi.yml:xenomai-lava-test.yml
>       - scripts/deploy_for_testing.sh x86-64-efi
>       - scripts/run-lava-tests.sh x86-64
> diff --git a/conf/machine/hikey.conf b/conf/machine/hikey.conf
> index 465e06e..3c93507 100644
> --- a/conf/machine/hikey.conf
> +++ b/conf/machine/hikey.conf
> @@ -11,7 +11,7 @@
>   
>   DISTRO_ARCH = "arm64"
>   
> -IMAGE_TYPE = "wic-img"
> +IMAGE_TYPE ?= "wic-img"
>   IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
>   
>   PREFERRED_VERSION_linux-xenomai = "4.14.%"
> diff --git a/conf/machine/x86-64-efi.conf b/conf/machine/x86-64-efi.conf
> index 0fd2ef1..02846ff 100644
> --- a/conf/machine/x86-64-efi.conf
> +++ b/conf/machine/x86-64-efi.conf
> @@ -11,5 +11,5 @@
>   
>   DISTRO_ARCH = "amd64"
>   
> -IMAGE_TYPE = "wic-img"
> +IMAGE_TYPE ?= "wic-img"
>   IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
> diff --git a/xenomai-lava-test.yml b/xenomai-lava-test.yml
> new file mode 100644
> index 0000000..206aea0
> --- /dev/null
> +++ b/xenomai-lava-test.yml
> @@ -0,0 +1,20 @@
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
> +# lava uses nfs to deploy the image. For this we need a tarball instead of
> +# full image
> +
> +local_conf_header:
> +  image-type: |
> +    IMAGE_TYPE = "targz-img"
> 

When reading $subject and the commit log, that new file and the CI changes look 
misplaced in this patch. Moreover, as this file is encoding an option, let's 
call it "opt-lava-test.yml".

Unrelated: we likely also want some "opt-latest.yml", to switch from the default 
"stable" by appending this to the kas command.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


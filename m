Subject: Re: [xenomai-images][PATCH] machine: Add beagle bone black as armhf
 example
References: <20190821120329.9722-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <38ca35fe-3f87-4d0e-5692-867bb4d852f4@siemens.com>
Date: Thu, 22 Aug 2019 17:03:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190821120329.9722-1-Quirin.Gylstorff@siemens.com>
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

On 21.08.19 14:03, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Build xenomai image for beagle bone black as an armhf example.
> This image uses the U-Boot Image am335x_boneblack from Debian 10(Buster)
> as boot loader.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   board-beagle-bone-black.yml         | 15 +++++++++++++++
>   conf/machine/beagle-bone-black.conf | 18 ++++++++++++++++++
>   wic/beagle-bone-black.wks           | 17 +++++++++++++++++
>   3 files changed, 50 insertions(+)
>   create mode 100644 board-beagle-bone-black.yml
>   create mode 100644 conf/machine/beagle-bone-black.conf
>   create mode 100644 wic/beagle-bone-black.wks
> 
> diff --git a/board-beagle-bone-black.yml b/board-beagle-bone-black.yml
> new file mode 100644
> index 0000000..e82d786
> --- /dev/null
> +++ b/board-beagle-bone-black.yml
> @@ -0,0 +1,15 @@
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
> +machine: beagle-bone-black
> diff --git a/conf/machine/beagle-bone-black.conf b/conf/machine/beagle-bone-black.conf
> new file mode 100644
> index 0000000..73abe12
> --- /dev/null
> +++ b/conf/machine/beagle-bone-black.conf
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
> +DISTRO_ARCH = "armhf"
> +
> +IMAGE_INSTALL += "u-boot-script"
> +
> +IMAGE_TYPE ?= "wic-img"
> +
> +IMAGER_INSTALL += "u-boot-omap"
> diff --git a/wic/beagle-bone-black.wks b/wic/beagle-bone-black.wks
> new file mode 100644
> index 0000000..902b67b
> --- /dev/null
> +++ b/wic/beagle-bone-black.wks
> @@ -0,0 +1,17 @@
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
> +part --source rawcopy --sourceparams "file=/usr/lib/u-boot/am335x_boneblack/MLO" --no-table --align 128
> +part u-boot --source rawcopy --sourceparams "file=/usr/lib/u-boot/am335x_boneblack/u-boot.img" --no-table --align 384
> +
> +part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --label platform --align 1024 --active
> +
> +bootloader --append "rw rootwait console=ttyO,115200"
> 

Thanks, applied.

Maybe interesting for you, Daniel.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


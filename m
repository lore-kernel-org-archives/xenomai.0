Subject: Re: [xenomai-images][PATCH] machine: Add simatic-ipc227e as x86
 example
References: <20190821120102.9329-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4b707d76-061e-8371-38a8-d3a1e7be45c1@siemens.com>
Date: Wed, 21 Aug 2019 14:04:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190821120102.9329-1-Quirin.Gylstorff@siemens.com>
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

On 21.08.19 14:01, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Use the simatic-ipc227e as example how to build a xenomai
> x86 image.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   board-simatic-ipc227e.yml         | 15 +++++++++++++++
>   conf/machine/simatic-ipc227e.conf | 15 +++++++++++++++
>   wic/simatic-ipc227e.wks           | 16 ++++++++++++++++
>   3 files changed, 46 insertions(+)
>   create mode 100644 board-simatic-ipc227e.yml
>   create mode 100644 conf/machine/simatic-ipc227e.conf
>   create mode 100644 wic/simatic-ipc227e.wks
> 
> diff --git a/board-simatic-ipc227e.yml b/board-simatic-ipc227e.yml
> new file mode 100644
> index 0000000..22f963d
> --- /dev/null
> +++ b/board-simatic-ipc227e.yml
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
> +machine: simatic-ipc227e
> diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
> new file mode 100644
> index 0000000..0fd2ef1
> --- /dev/null
> +++ b/conf/machine/simatic-ipc227e.conf
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
> +DISTRO_ARCH = "amd64"
> +
> +IMAGE_TYPE = "wic-img"
> +IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"

There isn't anything IPC227E-specific in this machine description. Maybe call is 
x86-64-efi or so?

> diff --git a/wic/simatic-ipc227e.wks b/wic/simatic-ipc227e.wks
> new file mode 100644
> index 0000000..107e119
> --- /dev/null
> +++ b/wic/simatic-ipc227e.wks
> @@ -0,0 +1,16 @@
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
> +part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --ondisk sda --label efi --part-type EF00 --align 1024
> +
> +part / --source rootfs --ondisk sda --fstype ext4 --label platform --align 1024 --use-uuid
> +
> +bootloader --ptable gpt --timeout=2 --append "rw rootwait console=ttyS0,115200"
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


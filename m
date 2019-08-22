Subject: Re: [PATCH v2] machine: Add x86-64-efi as x86 example
References: <4b707d76-061e-8371-38a8-d3a1e7be45c1@siemens.com>
 <20190821150952.15511-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fe199a16-3062-46fa-1647-338794785cbf@siemens.com>
Date: Thu, 22 Aug 2019 17:04:00 +0200
MIME-Version: 1.0
In-Reply-To: <20190821150952.15511-1-Quirin.Gylstorff@siemens.com>
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

On 21.08.19 17:09, Q. Gylstorff via Xenomai wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Use the x86-64-efi as example how to build a xenomai
> x86 image.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes:
>   V2:
>    - rename from simatic-ipc227e to x86-64-efi.
> 
> board-x86-64-efi.yml         | 15 +++++++++++++++
>   conf/machine/x86-64-efi.conf | 15 +++++++++++++++
>   wic/x86-64-efi.wks           | 16 ++++++++++++++++
>   3 files changed, 46 insertions(+)
>   create mode 100644 board-x86-64-efi.yml
>   create mode 100644 conf/machine/x86-64-efi.conf
>   create mode 100644 wic/x86-64-efi.wks
> 
> diff --git a/board-x86-64-efi.yml b/board-x86-64-efi.yml
> new file mode 100644
> index 0000000..e926d95
> --- /dev/null
> +++ b/board-x86-64-efi.yml
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
> +machine: x86-64-efi
> diff --git a/conf/machine/x86-64-efi.conf b/conf/machine/x86-64-efi.conf
> new file mode 100644
> index 0000000..0fd2ef1
> --- /dev/null
> +++ b/conf/machine/x86-64-efi.conf
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
> diff --git a/wic/x86-64-efi.wks b/wic/x86-64-efi.wks
> new file mode 100644
> index 0000000..107e119
> --- /dev/null
> +++ b/wic/x86-64-efi.wks
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

Thanks, applied.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


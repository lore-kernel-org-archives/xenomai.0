Subject: Re: [xenomai-images][PATCH] recipes-xenomai: Add recipes for all
 major branches
References: <20190812124647.26500-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e9b3624f-1823-a1fb-4057-e074c3e8fc18@siemens.com>
Date: Mon, 12 Aug 2019 14:57:55 +0200
MIME-Version: 1.0
In-Reply-To: <20190812124647.26500-1-Quirin.Gylstorff@siemens.com>
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

On 12.08.19 14:46, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> For testing it should be possible to switch between different
> xenomai versions. Select the version by adding the
> following line to kas.yml with:
>    xenomai-version: |
>      PREFERRED_VERSION_xenomai = "<version>"
>   e.g. the latest master branch with:
>    xenomai-version: |
>      PREFERRED_VERSION_xenomai = "master-AUTOINC"
> 
> The directory build/tmp must be deleted between versions.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   kas.yml                                   |  3 +++
>   recipes-xenomai/xenomai/xenomai_3.0.9.bb  | 32 +++++++++++++++++++++++
>   recipes-xenomai/xenomai/xenomai_master.bb | 26 ++++++++++++++++++
>   recipes-xenomai/xenomai/xenomai_next.bb   |  4 +--
>   recipes-xenomai/xenomai/xenomai_stable.bb | 31 ++++++++++++++++++++++
>   5 files changed, 94 insertions(+), 2 deletions(-)
>   create mode 100644 recipes-xenomai/xenomai/xenomai_3.0.9.bb
>   create mode 100644 recipes-xenomai/xenomai/xenomai_master.bb
>   create mode 100644 recipes-xenomai/xenomai/xenomai_stable.bb
> 
> diff --git a/kas.yml b/kas.yml
> index 3694bcc..506f1f4 100644
> --- a/kas.yml
> +++ b/kas.yml
> @@ -35,3 +35,6 @@ local_conf_header:
>       CONF_VERSION = "1"
>     cross: |
>       ISAR_CROSS_COMPILE = "1"
> +  xenomai-version: |
> +    PREFERRED_VERSION_xenomai = "stable-AUTOINC"
> +
> diff --git a/recipes-xenomai/xenomai/xenomai_3.0.9.bb b/recipes-xenomai/xenomai/xenomai_3.0.9.bb
> new file mode 100644
> index 0000000..2db26a1
> --- /dev/null
> +++ b/recipes-xenomai/xenomai/xenomai_3.0.9.bb
> @@ -0,0 +1,32 @@
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
> +require xenomai.inc
> +
> +SRC_URI = " \
> +    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=stable/v3.0.x;tag=v${PV}"
> +
> +S = "${WORKDIR}/git"
> +
> +do_prepare_build_append() {
> +# The xenomai-kernel-source package is supposed to contain the config
> +# directory. But the rules files does not copy the folder to /usr/src

Indention.

> +	sudo sed -i 's/cp -a kernel include scripts/cp -a config kernel include scripts/' ${S}/debian/rules

Including "debian: Add config folder to xenomai-kernel-source" into stable would 
do that as well?

BTW, what about "debian: Enable SMP in userspace package" for stable?

> +}
> +
> +dpkg_runbuild_prepend() {
> +    bbplain $(printf "xenomai-v${PV}: Building revision %.12s\n" \
> +                     $(cat ${S}/.git/refs/tags/v{PV}))
> +
> +
> +    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
> +        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
> +}

Can we put the common parts into xenomai.inc?

> diff --git a/recipes-xenomai/xenomai/xenomai_master.bb b/recipes-xenomai/xenomai/xenomai_master.bb
> new file mode 100644
> index 0000000..c058aa0
> --- /dev/null
> +++ b/recipes-xenomai/xenomai/xenomai_master.bb
> @@ -0,0 +1,26 @@
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
> +require xenomai.inc
> +
> +SRC_URI = " \
> +    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=master"
> +SRCREV = "${AUTOREV}"
> +PV = "master-${SRCREV}"
> +S = "${WORKDIR}/git"
> +
> +dpkg_runbuild_prepend() {
> +    bbplain $(printf "xenomai-master: Building revision %.12s\n" \
> +                     $(cat ${S}/.git/refs/heads/master))
> +
> +    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
> +        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
> +}
> diff --git a/recipes-xenomai/xenomai/xenomai_next.bb b/recipes-xenomai/xenomai/xenomai_next.bb
> index 72e5758..2efbd3f 100644
> --- a/recipes-xenomai/xenomai/xenomai_next.bb
> +++ b/recipes-xenomai/xenomai/xenomai_next.bb
> @@ -13,8 +13,8 @@ require xenomai.inc
>   
>   SRC_URI = " \
>       git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=next"
> -SRCREV = "next"
> -PV = "9999-next"
> +SRCREV = "${AUTOREV}"
> +PV = "next-${SRCREV}"
>   
>   S = "${WORKDIR}/git"
>   
> diff --git a/recipes-xenomai/xenomai/xenomai_stable.bb b/recipes-xenomai/xenomai/xenomai_stable.bb
> new file mode 100644
> index 0000000..3c408a3
> --- /dev/null
> +++ b/recipes-xenomai/xenomai/xenomai_stable.bb
> @@ -0,0 +1,31 @@
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
> +require xenomai.inc
> +
> +SRC_URI = " \
> +    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=stable/v3.0.x"
> +SRCREV = "${AUTOREV}"
> +PV = "stable-${SRCREV}"
> +S = "${WORKDIR}/git"
> +do_prepare_build_append() {
> +# The xenomai-kernel-source package is supposed to contain the config
> +# directory. But the rules files does not copy the folder to /usr/src
> +	sudo sed -i 's/cp -a kernel include scripts/cp -a config kernel include scripts/' ${S}/debian/rules
> +}
> +
> +dpkg_runbuild_prepend() {
> +    bbplain $(printf "xenomai-stable: Building revision %.12s\n" \
> +                     $(cat ${S}/.git/refs/heads/stable/v3.0.x))
> +
> +    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
> +        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
> +}
> 

Valuable enhancements!

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


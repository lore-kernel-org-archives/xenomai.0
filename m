Subject: Re: [xenomai-images][PATCH v2] recipes-xenomai: Add recipes for all
 major branches
References: <20190812124647.26500-1-Quirin.Gylstorff@siemens.com>
 <20190813114336.22561-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0f084ba0-dfaf-258f-ab1c-1b3ae3549900@siemens.com>
Date: Tue, 13 Aug 2019 16:29:27 +0200
MIME-Version: 1.0
In-Reply-To: <20190813114336.22561-1-Quirin.Gylstorff@siemens.com>
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

On 13.08.19 13:43, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> For testing it should be possible to switch between different
> xenomai versions. Select the version by adding the
> following line to kas.yml with:
>    xenomai-version: |
>      PREFERRED_VERSION_xenomai = "<version>"
>   e.g. the latest master branch with:
>    xenomai-version: |
>      PREFERRED_VERSION_xenomai = "master"
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes:
> v2:
>   - fix identation
>   - move functions to xenomai.inc
>   - use bitbake to get commitid
>   - add enable-smp to stable
>   - remove AUTOINC from version - feature is not yet available in ISAR
> 
>   kas.yml                                   |  2 ++
>   recipes-xenomai/xenomai/xenomai.inc       | 25 +++++++++++++++++++++++
>   recipes-xenomai/xenomai/xenomai_3.0.9.bb  | 20 ++++++++++++++++++
>   recipes-xenomai/xenomai/xenomai_master.bb | 19 +++++++++++++++++
>   recipes-xenomai/xenomai/xenomai_next.bb   | 10 ++-------
>   recipes-xenomai/xenomai/xenomai_stable.bb | 20 ++++++++++++++++++
>   6 files changed, 88 insertions(+), 8 deletions(-)
>   create mode 100644 recipes-xenomai/xenomai/xenomai_3.0.9.bb
>   create mode 100644 recipes-xenomai/xenomai/xenomai_master.bb
>   create mode 100644 recipes-xenomai/xenomai/xenomai_stable.bb
> 
> diff --git a/kas.yml b/kas.yml
> index 3694bcc..2bf62d4 100644
> --- a/kas.yml
> +++ b/kas.yml
> @@ -35,3 +35,5 @@ local_conf_header:
>       CONF_VERSION = "1"
>     cross: |
>       ISAR_CROSS_COMPILE = "1"
> +  xenomai-version: |
> +    PREFERRED_VERSION_xenomai = "stable"
> diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
> index 5559829..e7a2901 100644
> --- a/recipes-xenomai/xenomai/xenomai.inc
> +++ b/recipes-xenomai/xenomai/xenomai.inc
> @@ -13,6 +13,8 @@ inherit dpkg
>   
>   PROVIDES += "xenomai-kernel-source xenomai-runtime"
>   
> +# use bitbake get_srcrev to get the current commit id
> +COMMIT="${@bb.fetch2.get_srcrev(d).strip('AUTOINC+')}"
>   do_prepare_build() {
>   	# The xenomai-kernel-source package is supposed to be generic, but we
>   	# build it per architecture in Isar, and those packages happen to be
> @@ -20,3 +22,26 @@ do_prepare_build() {
>   	# target architecture to avoid conflicts.
>   	sudo sed -i 's/Architecture: all/Architecture: any/' ${S}/debian/control
>   }
> +
> +# this function is only necessary for stable as long as
> +# "debian: Add config folder to xenomai-kernel-source" and
> +# "debian: Enable SMP in userspace package"
> +# are not part of the stable branch
> +do_prepare_stable_for_build() {
> +    # Enable smp for userspace packages
> +    sudo sed -i \
> +    's/--with-testdir=\/usr\/lib\/xenomai\/testsuite/--with-testdir=\/usr\/lib\/xenomai\/testsuite \\\n\t    --enable-smp/' \
> +    ${S}/debian/rules
> +    # The xenomai-kernel-source package is supposed to contain the config
> +    # directory. But the rules files does not copy the folder to /usr/src
> +    sudo sed -i 's/cp -a kernel include scripts/cp -a config kernel include scripts/' ${S}/debian/rules
> +}

Why not carring the patch files instead? Both apply cleanly to stable. Will also 
push them soon.

> +
> +
> +dpkg_runbuild_prepend() {
> +    bbplain $(printf "xenomai-%s: Building revision %.20s\n" \
> +                     ${PV} ${COMMIT})
> +
> +    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
> +        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
> +}
> \ No newline at end of file

Would be nice to have. You can take one from...

> diff --git a/recipes-xenomai/xenomai/xenomai_3.0.9.bb b/recipes-xenomai/xenomai/xenomai_3.0.9.bb
> new file mode 100644
> index 0000000..6fb3ff8
> --- /dev/null
> +++ b/recipes-xenomai/xenomai/xenomai_3.0.9.bb
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
> +require xenomai.inc
> +SRC_URI = " \
> +    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=stable/v3.0.x;tag=v${PV} \
> +    "
> +S = "${WORKDIR}/git"
> +
> +addtask prepare_stable_for_build before do_prepare_build after do_patch
> +
> +

...here where there are enough at the end. ;)

> diff --git a/recipes-xenomai/xenomai/xenomai_master.bb b/recipes-xenomai/xenomai/xenomai_master.bb
> new file mode 100644
> index 0000000..d95ede6
> --- /dev/null
> +++ b/recipes-xenomai/xenomai/xenomai_master.bb
> @@ -0,0 +1,19 @@
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
> +PV = "master"
> +S = "${WORKDIR}/git"
> +
> diff --git a/recipes-xenomai/xenomai/xenomai_next.bb b/recipes-xenomai/xenomai/xenomai_next.bb
> index 72e5758..e216124 100644
> --- a/recipes-xenomai/xenomai/xenomai_next.bb
> +++ b/recipes-xenomai/xenomai/xenomai_next.bb
> @@ -13,15 +13,9 @@ require xenomai.inc
>   
>   SRC_URI = " \
>       git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=next"
> -SRCREV = "next"
> -PV = "9999-next"
> +SRCREV = "${AUTOREV}"
> +PV = "next"
>   
>   S = "${WORKDIR}/git"
>   
> -dpkg_runbuild_prepend() {
> -    bbplain $(printf "xenomai-next: Building revision %.12s\n" \
> -                     $(cat ${S}/.git/refs/heads/next))
>   
> -    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
> -        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
> -}
> diff --git a/recipes-xenomai/xenomai/xenomai_stable.bb b/recipes-xenomai/xenomai/xenomai_stable.bb
> new file mode 100644
> index 0000000..bb77ec9
> --- /dev/null
> +++ b/recipes-xenomai/xenomai/xenomai_stable.bb
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
> +require xenomai.inc
> +
> +SRC_URI = " \
> +    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=stable/v3.0.x"
> +SRCREV = "${AUTOREV}"
> +PV = "stable"
> +S = "${WORKDIR}/git"
> +
> +addtask prepare_stable_for_build before do_prepare_build after do_patch
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


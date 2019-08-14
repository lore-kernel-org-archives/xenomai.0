Subject: Re: [PATCH v3] recipes-xenomai: Add recipes for all major branches
References: <0f084ba0-dfaf-258f-ab1c-1b3ae3549900@siemens.com>
 <20190813152803.10191-1-Quirin.Gylstorff@siemens.com>
 <e8912cfb-d1cf-6b96-1c77-91bca4718e74@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <602f9447-cf5a-78d5-89d5-d7d2048dfd72@siemens.com>
Date: Wed, 14 Aug 2019 13:38:32 +0200
MIME-Version: 1.0
In-Reply-To: <e8912cfb-d1cf-6b96-1c77-91bca4718e74@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 14.08.19 13:21, Jan Kiszka via Xenomai wrote:
> On 13.08.19 17:28, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> For testing it should be possible to switch between different
>> xenomai versions. Select the version by adding the
>> following line to kas.yml with:
>>    xenomai-version: |
>>      PREFERRED_VERSION_xenomai = "<version>"
>>   e.g. the latest master branch with:
>>    xenomai-version: |
>>      PREFERRED_VERSION_xenomai = "master"
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes:
>> v3:
>>   - fix newlines
>>   - use patches instead of sed
>> v2:
>>   - fix identation
>>   - move functions to xenomai.inc
>>   - use bitbake to get commitid
>>   - add enable-smp to stable
>>   - remove AUTOINC from version - feature is not yet available in ISAR
>>
>>   kas.yml                                       |  2 ++
>>   ...nfig-folder-to-xenomai-kernel-source.patch | 29 +++++++++++++++++
>>   ...bian-Enable-SMP-in-userspace-package.patch | 31 +++++++++++++++++++
>>   recipes-xenomai/xenomai/xenomai.inc           | 10 ++++++
>>   recipes-xenomai/xenomai/xenomai_3.0.9.bb      | 18 +++++++++++
>>   recipes-xenomai/xenomai/xenomai_master.bb     | 19 ++++++++++++
>>   recipes-xenomai/xenomai/xenomai_next.bb       | 10 ++----
>>   recipes-xenomai/xenomai/xenomai_stable.bb     | 22 +++++++++++++
>>   8 files changed, 133 insertions(+), 8 deletions(-)
>>   create mode 100644 
>> recipes-xenomai/xenomai/files/0001-debian-Add-config-folder-to-xenomai-kernel-source.patch 
>>
>>   create mode 100644 
>> recipes-xenomai/xenomai/files/0001-debian-Enable-SMP-in-userspace-package.patch
>>   create mode 100644 recipes-xenomai/xenomai/xenomai_3.0.9.bb
>>   create mode 100644 recipes-xenomai/xenomai/xenomai_master.bb
>>   create mode 100644 recipes-xenomai/xenomai/xenomai_stable.bb
>>
>> diff --git a/kas.yml b/kas.yml
>> index 3694bcc..2bf62d4 100644
>> --- a/kas.yml
>> +++ b/kas.yml
>> @@ -35,3 +35,5 @@ local_conf_header:
>>       CONF_VERSION = "1"
>>     cross: |
>>       ISAR_CROSS_COMPILE = "1"
>> +  xenomai-version: |
>> +    PREFERRED_VERSION_xenomai = "stable"
>> diff --git 
>> a/recipes-xenomai/xenomai/files/0001-debian-Add-config-folder-to-xenomai-kernel-source.patch 
>> b/recipes-xenomai/xenomai/files/0001-debian-Add-config-folder-to-xenomai-kernel-source.patch 
>>
>> new file mode 100644
>> index 0000000..3be4fb3
>> --- /dev/null
>> +++ 
>> b/recipes-xenomai/xenomai/files/0001-debian-Add-config-folder-to-xenomai-kernel-source.patch 
>>
>> @@ -0,0 +1,29 @@
>> +From 07d87b9b2ca45f81024056720b28f6cdbcb3b9c7 Mon Sep 17 00:00:00 2001
>> +From: Jan Kiszka <jan.kiszka@siemens.com>
>> +Date: Tue, 6 Nov 2018 13:37:21 +0100
>> +Subject: [PATCH] debian: Add config folder to xenomai-kernel-source
>> +
>> +Meanwhile required for prepare-kernel.sh.
>> +
>> +Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +---
>> + debian/rules | 2 +-
>> + 1 file changed, 1 insertion(+), 1 deletion(-)
>> +
>> +diff --git a/debian/rules b/debian/rules
>> +index 8b871a488..99ed8982c 100755
>> +--- a/debian/rules
>> ++++ b/debian/rules
>> +@@ -73,7 +73,7 @@ install: build
>> +     cp debian/libxenomai1.lintian 
>> $(CURDIR)/debian/libxenomai1/usr/share/lintian/overrides/libxenomai1
>> +     cp debian/libxenomai-dev.lintian 
>> $(CURDIR)/debian/libxenomai-dev/usr/share/lintian/overrides/libxenomai-dev
>> +     mkdir -p 
>> $(CURDIR)/debian/xenomai-kernel-source/usr/src/xenomai-kernel-source 
>> $(CURDIR)/debian/xenomai-kernel-source/usr/share/doc/xenomai-kernel-source
>> +-    cp -a kernel include scripts 
>> $(CURDIR)/debian/xenomai-kernel-source/usr/src/xenomai-kernel-source
>> ++    cp -a config kernel include scripts 
>> $(CURDIR)/debian/xenomai-kernel-source/usr/src/xenomai-kernel-source
>> +
>> + # Build architecture-independent files here.
>> + binary-indep: build install
>> +--
>> +2.20.1
>> +
>> diff --git 
>> a/recipes-xenomai/xenomai/files/0001-debian-Enable-SMP-in-userspace-package.patch 
>> b/recipes-xenomai/xenomai/files/0001-debian-Enable-SMP-in-userspace-package.patch
>> new file mode 100644
>> index 0000000..6a63a92
>> --- /dev/null
>> +++ 
>> b/recipes-xenomai/xenomai/files/0001-debian-Enable-SMP-in-userspace-package.patch
>> @@ -0,0 +1,31 @@
>> +From a4ec3f654a4be50aaf268c3a540e8b110ad2ded3 Mon Sep 17 00:00:00 2001
>> +From: Jan Kiszka <jan.kiszka@siemens.com>
>> +Date: Tue, 6 Nov 2018 18:59:47 +0100
>> +Subject: [PATCH] debian: Enable SMP in userspace package
>> +
>> +Hard to find a UP target these days, and we definitely want to be
>> +generic with Debian packages.
>> +
>> +Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +---
>> + debian/rules | 3 ++-
>> + 1 file changed, 2 insertions(+), 1 deletion(-)
>> +
>> +diff --git a/debian/rules b/debian/rules
>> +index 99ed8982c..883ae3ed8 100755
>> +--- a/debian/rules
>> ++++ b/debian/rules
>> +@@ -16,7 +16,8 @@ DEB_BUILD_GNU_TYPE=$(shell dpkg-architecture 
>> -qDEB_BUILD_GNU_TYPE)
>> + CONFIG_OPTS = --prefix=/usr \
>> +             --includedir=/usr/include/xenomai \
>> +             --mandir=/usr/share/man \
>> +-        --with-testdir=/usr/lib/xenomai/testsuite
>> ++            --with-testdir=/usr/lib/xenomai/testsuite \
>> ++            --enable-smp
>> +
>> + ifneq ($(DEB_HOST_GNU_TYPE),$(DEB_BUILD_GNU_TYPE))
>> +     CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE) --host $(DEB_HOST_GNU_TYPE)
>> +--
>> +2.20.1
>> +
>> diff --git a/recipes-xenomai/xenomai/xenomai.inc 
>> b/recipes-xenomai/xenomai/xenomai.inc
>> index 5559829..aa53e57 100644
>> --- a/recipes-xenomai/xenomai/xenomai.inc
>> +++ b/recipes-xenomai/xenomai/xenomai.inc
>> @@ -13,6 +13,8 @@ inherit dpkg
>>   PROVIDES += "xenomai-kernel-source xenomai-runtime"
>> +# use bitbake get_srcrev to get the current commit id
>> +COMMIT="${@bb.fetch2.get_srcrev(d).strip('AUTOINC+')}"
>>   do_prepare_build() {
>>       # The xenomai-kernel-source package is supposed to be generic, but we
>>       # build it per architecture in Isar, and those packages happen to be
>> @@ -20,3 +22,11 @@ do_prepare_build() {
>>       # target architecture to avoid conflicts.
>>       sudo sed -i 's/Architecture: all/Architecture: any/' ${S}/debian/control
>>   }
>> +
>> +dpkg_runbuild_prepend() {
>> +    bbplain $(printf "xenomai-%s: Building revision %.20s\n" \
>> +                     ${PV} ${COMMIT})
>> +
>> +    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
>> +        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
>> +}
>> diff --git a/recipes-xenomai/xenomai/xenomai_3.0.9.bb 
>> b/recipes-xenomai/xenomai/xenomai_3.0.9.bb
>> new file mode 100644
>> index 0000000..4f42020
>> --- /dev/null
>> +++ b/recipes-xenomai/xenomai/xenomai_3.0.9.bb
>> @@ -0,0 +1,18 @@
>> +#
>> +# Xenomai Real-Time System
>> +#
>> +# Copyright (c) Siemens AG, 2019
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require xenomai.inc
>> +SRC_URI = " \
>> +    
>> git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=stable/v3.0.x;tag=v${PV} 
>> \
>> +file://0001-debian-Add-config-folder-to-xenomai-kernel-source.patch \
>> +file://0001-debian-Enable-SMP-in-userspace-package.patch \
>> +    "
>> +S = "${WORKDIR}/git"
>> diff --git a/recipes-xenomai/xenomai/xenomai_master.bb 
>> b/recipes-xenomai/xenomai/xenomai_master.bb
>> new file mode 100644
>> index 0000000..d95ede6
>> --- /dev/null
>> +++ b/recipes-xenomai/xenomai/xenomai_master.bb
>> @@ -0,0 +1,19 @@
>> +#
>> +# Xenomai Real-Time System
>> +#
>> +# Copyright (c) Siemens AG, 2019
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require xenomai.inc
>> +
>> +SRC_URI = " \
>> +    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=master"
>> +SRCREV = "${AUTOREV}"
>> +PV = "master"
>> +S = "${WORKDIR}/git"
>> +
>> diff --git a/recipes-xenomai/xenomai/xenomai_next.bb 
>> b/recipes-xenomai/xenomai/xenomai_next.bb
>> index 72e5758..e216124 100644
>> --- a/recipes-xenomai/xenomai/xenomai_next.bb
>> +++ b/recipes-xenomai/xenomai/xenomai_next.bb
>> @@ -13,15 +13,9 @@ require xenomai.inc
>>   SRC_URI = " \
>>       git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=next"
>> -SRCREV = "next"
>> -PV = "9999-next"
>> +SRCREV = "${AUTOREV}"
>> +PV = "next"
>>   S = "${WORKDIR}/git"
>> -dpkg_runbuild_prepend() {
>> -    bbplain $(printf "xenomai-next: Building revision %.12s\n" \
>> -                     $(cat ${S}/.git/refs/heads/next))
>> -    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
>> -        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
>> -}
>> diff --git a/recipes-xenomai/xenomai/xenomai_stable.bb 
>> b/recipes-xenomai/xenomai/xenomai_stable.bb
>> new file mode 100644
>> index 0000000..28e99bb
>> --- /dev/null
>> +++ b/recipes-xenomai/xenomai/xenomai_stable.bb
>> @@ -0,0 +1,22 @@
>> +#
>> +# Xenomai Real-Time System
>> +#
>> +# Copyright (c) Siemens AG, 2019
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require xenomai.inc
>> +
>> +SRC_URI = " \
>> +    
>> git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=stable/v3.0.x \
>> +file://0001-debian-Add-config-folder-to-xenomai-kernel-source.patch \
>> +file://0001-debian-Enable-SMP-in-userspace-package.patch \
>> +"
>> +SRCREV = "${AUTOREV}"
>> +PV = "stable"
>> +S = "${WORKDIR}/git"
>> +
>>
> 
> Thanks, applied.
> 
> Jan
> 

Oops, just pushed the two patches to stable/v3.0.x, so this no longer builds. 
Fixed up on merge.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


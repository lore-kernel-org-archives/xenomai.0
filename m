Subject: Re: [xenomai-images][PATCH] recipes-xenomai: Add recipes for all
 major branches
References: <20190812124647.26500-1-Quirin.Gylstorff@siemens.com>
 <e9b3624f-1823-a1fb-4057-e074c3e8fc18@siemens.com>
 <c9f02ed5-5635-3f84-f445-412030045f8f@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <100428be-93a6-3506-42da-da09d917c2ef@siemens.com>
Date: Mon, 12 Aug 2019 15:44:40 +0200
MIME-Version: 1.0
In-Reply-To: <c9f02ed5-5635-3f84-f445-412030045f8f@siemens.com>
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
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>, xenomai@xenomai.org

On 12.08.19 15:32, Quirin Gylstorff wrote:
> 
> 
> On 8/12/19 2:57 PM, Jan Kiszka wrote:
>> On 12.08.19 14:46, Q. Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> For testing it should be possible to switch between different
>>> xenomai versions. Select the version by adding the
>>> following line to kas.yml with:
>>>    xenomai-version: |
>>>      PREFERRED_VERSION_xenomai = "<version>"
>>>   e.g. the latest master branch with:
>>>    xenomai-version: |
>>>      PREFERRED_VERSION_xenomai = "master-AUTOINC"
>>>
>>> The directory build/tmp must be deleted between versions.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>>   kas.yml                                   |  3 +++
>>>   recipes-xenomai/xenomai/xenomai_3.0.9.bb  | 32 +++++++++++++++++++++++
>>>   recipes-xenomai/xenomai/xenomai_master.bb | 26 ++++++++++++++++++
>>>   recipes-xenomai/xenomai/xenomai_next.bb   |  4 +--
>>>   recipes-xenomai/xenomai/xenomai_stable.bb | 31 ++++++++++++++++++++++
>>>   5 files changed, 94 insertions(+), 2 deletions(-)
>>>   create mode 100644 recipes-xenomai/xenomai/xenomai_3.0.9.bb
>>>   create mode 100644 recipes-xenomai/xenomai/xenomai_master.bb
>>>   create mode 100644 recipes-xenomai/xenomai/xenomai_stable.bb
>>>
>>> diff --git a/kas.yml b/kas.yml
>>> index 3694bcc..506f1f4 100644
>>> --- a/kas.yml
>>> +++ b/kas.yml
>>> @@ -35,3 +35,6 @@ local_conf_header:
>>>       CONF_VERSION = "1"
>>>     cross: |
>>>       ISAR_CROSS_COMPILE = "1"
>>> +  xenomai-version: |
>>> +    PREFERRED_VERSION_xenomai = "stable-AUTOINC"
>>> +
>>> diff --git a/recipes-xenomai/xenomai/xenomai_3.0.9.bb 
>>> b/recipes-xenomai/xenomai/xenomai_3.0.9.bb
>>> new file mode 100644
>>> index 0000000..2db26a1
>>> --- /dev/null
>>> +++ b/recipes-xenomai/xenomai/xenomai_3.0.9.bb
>>> @@ -0,0 +1,32 @@
>>> +#
>>> +# Xenomai Real-Time System
>>> +#
>>> +# Copyright (c) Siemens AG, 2019
>>> +#
>>> +# Authors:
>>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +require xenomai.inc
>>> +
>>> +SRC_URI = " \
>>> + 
>>> git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=stable/v3.0.x;tag=v${PV}" 
>>>
>>> +
>>> +S = "${WORKDIR}/git"
>>> +
>>> +do_prepare_build_append() {
>>> +# The xenomai-kernel-source package is supposed to contain the config
>>> +# directory. But the rules files does not copy the folder to /usr/src
>>
>> Indention.
>>
> 
> Will fix it.
> 
>>> +    sudo sed -i 's/cp -a kernel include scripts/cp -a config kernel include 
>>> scripts/' ${S}/debian/rules
>>
>> Including "debian: Add config folder to xenomai-kernel-source" into stable 
>> would do that as well?
> 
> Yes, the patch would be sufficient in stable to compile it with ISAR.

Then let's carry the patch for 3.0.9, and I will merge it for the next 3.0 release.

> 
>>
>> BTW, what about "debian: Enable SMP in userspace package" for stable?
> 
> For building it would be not necessary, but for future testing it would be nice 
> to have SMP available.

Try running a non-smp userland on an SMP system, e.g. via start-qemu.sh...

> 
>>
>>> +}
>>> +
>>> +dpkg_runbuild_prepend() {
>>> +    bbplain $(printf "xenomai-v${PV}: Building revision %.12s\n" \
>>> +                     $(cat ${S}/.git/refs/tags/v{PV}))
>>> +
>>> +
>>> +    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
>>> +        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
>>> +}
>>
>> Can we put the common parts into xenomai.inc?
> 
> 
> For the builds which are building the latest of each branch, yes for a tagged 
> version another reference is used or I will add git rev-parse HEAD.
> 

I'm sure even that could be abstracted away by a variable.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


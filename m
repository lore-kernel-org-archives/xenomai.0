Subject: Re: [xenomai-images][PATCH] ci: use script to install lavacli.
References: <20190920084629.10936-1-Quirin.Gylstorff@siemens.com>
 <e49e2fb1-9c63-36d5-32ef-51a4deab4ac0@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Message-ID: <7e30afb1-f980-6421-c7f5-6d1aaf02d869@siemens.com>
Date: Fri, 20 Sep 2019 16:05:37 +0200
MIME-Version: 1.0
In-Reply-To: <e49e2fb1-9c63-36d5-32ef-51a4deab4ac0@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org



On 9/20/19 3:56 PM, Jan Kiszka wrote:
> On 20.09.19 10:46, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> lavacli is not part of the used image and need to be installed.
>> Due to changes in the lavacli dependencies it is not possible
>> to connect to the master installed via apt, therefore use
>> the pip3 version in case of Debian stretch. If Image release
>> is Debian 10 or newer use apt else use pip3.
>>
>> This patch fixes a regression after the kasproject
>> downgraded the docker base image from Debian 10 to Debian 9.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .gitlab-ci.yml             | 14 ++++++++++----
>>   scripts/install-lavacli.sh | 21 +++++++++++++++++++++
>>   2 files changed, 31 insertions(+), 4 deletions(-)
>>   create mode 100755 scripts/install-lavacli.sh
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 0e1d21a..9bb8b1a 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -25,8 +25,6 @@ default:
>>   # for the test infrastructure
>>   .add-lava-ssh-config: &lava-ssh-key
>>     before_script:
>> -    - sudo apt update
>> -    - sudo apt install lavacli -y
>>       - mkdir -p -m=700 ~/.ssh
>>       - echo "$LAVA_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/id_rsa && chmod 
>> 600 ~/.ssh/id_rsa
>>       - echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 
>> 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 
>> 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config
>> @@ -43,13 +41,15 @@ lava-test:qemu-amd64:
>>     <<: *lava-ssh-key
>>     stage: lava-test
>>     script:
>> -     - scripts/run-lava-tests.sh qemu-amd64
>> +    - scripts/install-lavacli.sh
>> +    - scripts/run-lava-tests.sh qemu-amd64
>>     needs: [ "build:qemu-amd64" ]
>>     only:
>>       variables:
>>         - $LAVA_USER
>>   build:qemu-armhf:
>> +  <<: *lava-ssh-key
>>     stage: build
>>     script:
>>       - kas build kas.yml:board-qemu-armhf.yml
>> @@ -59,6 +59,7 @@ lava-test:qemu-armhf:
>>     <<: *lava-ssh-key
>>     stage: lava-test
>>     script:
>> +    - scripts/install-lavacli.sh
>>       - scripts/run-lava-tests.sh qemu-armhf
>>     needs: [ "build:qemu-armhf" ]
>>     only:
>> @@ -76,6 +77,7 @@ lava-test:qemu-arm64:
>>     <<: *lava-ssh-key
>>     stage: lava-test
>>     script:
>> +    - scripts/install-lavacli.sh
>>       - scripts/run-lava-tests.sh qemu-arm64
>>     needs: [ "build:qemu-arm64" ]
>>     only:
>> @@ -83,9 +85,11 @@ lava-test:qemu-arm64:
>>         - $LAVA_USER
>>   build:board-hikey:
>> +  <<: *lava-ssh-key
>>     stage: build
>>     script:
>> -    - kas build kas.yml:board-hikey.yml:opt-latest.yml
>> +    - kas build kas.yml:board-hikey.yml:opt-latest.yml:opt-lava-test.yml
>> +    - scripts/deploy_for_testing.sh hikey
>>   # hikey is currently not part of the testlab
>>   build:board-beaglebone:
>> @@ -99,6 +103,7 @@ lava-test:board-beaglebone:
>>     <<: *lava-ssh-key
>>     stage: lava-test
>>     script:
>> +    - scripts/install-lavacli.sh
>>       - scripts/run-lava-tests.sh beaglebone
>>     needs: [ "build:board-beaglebone" ]
>>     only:
>> @@ -116,6 +121,7 @@ lava-test:board-x86-64-efi:
>>     <<: *lava-ssh-key
>>     stage: lava-test
>>     script:
>> +    - scripts/install-lavacli.sh
>>       - scripts/run-lava-tests.sh x86-64
>>     needs: [ "build:board-x86-64-efi" ]
>>     only:
>> diff --git a/scripts/install-lavacli.sh b/scripts/install-lavacli.sh
>> new file mode 100755
>> index 0000000..66600f2
>> --- /dev/null
>> +++ b/scripts/install-lavacli.sh
>> @@ -0,0 +1,21 @@
>> +#!/bin/sh
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
>> +# check if Debian 10 or later. If not use the pip version
>> +# of lavacli. The apt version from stretch-backports cannot communicate
>> +# with the lava master on Debian 10.
>> +os_version_id=$(sed -nr 's/VERSION_ID="([0-9]+)"/\1/p' /etc/os-release)
>> +if [ "${os_version_id}" -ge "10" ]; then
>> +    sudo apt update
>> +    sudo apt install -y lavacli
>> +else
>> +    sudo pip3 install lavacli
>> +fi
>>
> 
> Thanks, applied.
> 
> But what spoke against always using pip?

Personal preferences, if there is a working Debian package i don't want
to have something out of apt control.

Also, I want to avoid having the same problem again in the future if 
there is a change in the dependencies change of the packages from pip.

> 
> Jan
> 
Quirin


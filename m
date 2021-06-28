Subject: Re: [xenomai-images 2/2] tests: restrict realtime cpu for x86 and
 qemu type of devices
References: <20210628062624.2244-1-hongzhan.chen@intel.com>
 <20210628062624.2244-2-hongzhan.chen@intel.com>
 <a93a52c0-0913-bb2a-952b-91ab11b33b01@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7b93c0ce-8013-c6d2-2a02-07480112d7ce@siemens.com>
Date: Mon, 28 Jun 2021 12:21:25 +0200
MIME-Version: 1.0
In-Reply-To: <a93a52c0-0913-bb2a-952b-91ab11b33b01@siemens.com>
Content-Type: text/plain; charset=utf-8
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 28.06.21 09:08, Jan Kiszka via Xenomai wrote:
> On 28.06.21 08:26, Hongzhan Chen wrote:
>> If there is no CPU restriction on the bootargs, smokey cpu_affinity
>> test would be skipped reporting with "no kernel support" for those
>> without non-RT cpu.
>>
>> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>>
>> diff --git a/tests/jobs/xenomai-ipc227e.yml b/tests/jobs/xenomai-ipc227e.yml
>> index a5a181c..209c5d4 100644
>> --- a/tests/jobs/xenomai-ipc227e.yml
>> +++ b/tests/jobs/xenomai-ipc227e.yml
>> @@ -72,3 +72,5 @@ actions:
>>        from: inline
>>        path: inline/xenomai-test-suite.yaml
>>        name: xenomai-test-suite
>> +context:
>> +  extra_kernel_args: xenomai.supported_cpus=7
>> diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
>> index c335292..e42f6ec 100644
>> --- a/tests/jobs/xenomai-qemu-amd64.yml
>> +++ b/tests/jobs/xenomai-qemu-amd64.yml
>> @@ -46,7 +46,7 @@ actions:
>>      to: tmpfs
>>      images:
>>        kernel:
>> -        image_arg: -kernel {kernel} -append "root=/dev/sdb console=ttyS0,115200 console=tty0"
>> +        image_arg: -kernel {kernel} -append "root=/dev/sdb console=ttyS0,115200 console=tty0 xenomai.supported_cpus=1"
>>          url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
>>        initrd:
>>          image_arg: -initrd {initrd}
>> diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
>> index 88fb880..cc60564 100644
>> --- a/tests/jobs/xenomai-qemu-arm64.yml
>> +++ b/tests/jobs/xenomai-qemu-arm64.yml
>> @@ -50,7 +50,7 @@ actions:
>>      to: tmpfs
>>      images:
>>        kernel:
>> -        image_arg: -kernel {kernel} -append "root=/dev/vda"
>> +        image_arg: -kernel {kernel} -append "root=/dev/vda xenomai.supported_cpus=1"
>>          url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
>>        initrd:
>>          image_arg: -initrd {initrd}
>> diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
>> index 3e3a8ab..2afe250 100644
>> --- a/tests/jobs/xenomai-qemu-armhf.yml
>> +++ b/tests/jobs/xenomai-qemu-armhf.yml
>> @@ -46,7 +46,7 @@ actions:
>>      to: tmpfs
>>      images:
>>        kernel:
>> -        image_arg: -kernel {kernel} -append "root=/dev/vdb"
>> +        image_arg: -kernel {kernel} -append "root=/dev/vdb xenomai.supported_cpus=1"
>>          url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
>>        initrd:
>>          image_arg: -initrd {initrd}
>> diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
>> index bc71b75..d1418c1 100644
>> --- a/tests/jobs/xenomai-x86-64-efi.yml
>> +++ b/tests/jobs/xenomai-x86-64-efi.yml
>> @@ -72,3 +72,5 @@ actions:
>>        from: inline
>>        path: inline/xenomai-test-suite.yaml
>>        name: xenomai-test-suite
>> +context:
>> +  extra_kernel_args: xenomai.supported_cpus=7
>>
> 
> Thanks, both applied, just formatting the masks as hex.
> 

Seems as if this triggers an issue with dovetail/5.10:
https://source.denx.de/Xenomai/xenomai-images/-/jobs/283341

Let's see how the corresponding QEMU behaves...

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


Subject: Re: [xenomai-images 2/2] tests: restrict realtime cpu for x86 and
 qemu type of devices
References: <20210628062624.2244-1-hongzhan.chen@intel.com>
 <20210628062624.2244-2-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8856d07f-517d-1e4f-1236-04b3533535db@siemens.com>
Date: Wed, 30 Jun 2021 11:20:59 +0200
MIME-Version: 1.0
In-Reply-To: <20210628062624.2244-2-hongzhan.chen@intel.com>
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org, Quirin Gylstorff <quirin.gylstorff@siemens.com>

On 28.06.21 08:26, Hongzhan Chen wrote:
> If there is no CPU restriction on the bootargs, smokey cpu_affinity
> test would be skipped reporting with "no kernel support" for those
> without non-RT cpu.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/tests/jobs/xenomai-ipc227e.yml b/tests/jobs/xenomai-ipc227e.yml
> index a5a181c..209c5d4 100644
> --- a/tests/jobs/xenomai-ipc227e.yml
> +++ b/tests/jobs/xenomai-ipc227e.yml
> @@ -72,3 +72,5 @@ actions:
>        from: inline
>        path: inline/xenomai-test-suite.yaml
>        name: xenomai-test-suite
> +context:
> +  extra_kernel_args: xenomai.supported_cpus=7
> diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
> index c335292..e42f6ec 100644
> --- a/tests/jobs/xenomai-qemu-amd64.yml
> +++ b/tests/jobs/xenomai-qemu-amd64.yml
> @@ -46,7 +46,7 @@ actions:
>      to: tmpfs
>      images:
>        kernel:
> -        image_arg: -kernel {kernel} -append "root=/dev/sdb console=ttyS0,115200 console=tty0"
> +        image_arg: -kernel {kernel} -append "root=/dev/sdb console=ttyS0,115200 console=tty0 xenomai.supported_cpus=1"

We should use 4 cores in QEMU instances, like in the start-qemu script,
and then 0x7 as mask here as well. Quirin, I suppose you limited all
qemu instances to 2 cores because of the host having only 2, right?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


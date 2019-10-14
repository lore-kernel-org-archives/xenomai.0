Subject: Re: [PATCH] test/jobs: Adapt job timeouts
References: <20191014071743.31386-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <877b521d-6503-c1b0-bde0-1efc121f4a72@siemens.com>
Date: Mon, 14 Oct 2019 09:52:02 +0200
MIME-Version: 1.0
In-Reply-To: <20191014071743.31386-1-Quirin.Gylstorff@siemens.com>
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
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 14.10.19 09:17, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If the job timeout of a LAVA job is less than the sum of the single
> action timeouts the job timeout is used. This leads to a warning in the LAVA
> UI `Action timeout is larger than job timeout @ data['actions']['2']`.
> This fixes the failing qemu tests.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  tests/jobs/xenomai-qemu-amd64.yml | 4 ++--
>  tests/jobs/xenomai-qemu-arm64.yml | 4 ++--
>  tests/jobs/xenomai-qemu-armhf.yml | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
> index 9520e16..33ff1b2 100644
> --- a/tests/jobs/xenomai-qemu-amd64.yml
> +++ b/tests/jobs/xenomai-qemu-amd64.yml
> @@ -13,7 +13,7 @@ job_name: QEMU pipeline, xenomai-images-qemu-amd64
>  
>  timeouts:
>    job:
> -    minutes: 15
> +    minutes: 45
>    action:
>      minutes: 5
>    connection:
> @@ -28,7 +28,7 @@ context:
>    arch: amd64
>    extra_options:
>    - -smp
> -  -  4
> +  -  2
>    - -nographic
>    - -enable-kvm
>    - -machine q35
> diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
> index bcc3d81..2a98889 100644
> --- a/tests/jobs/xenomai-qemu-arm64.yml
> +++ b/tests/jobs/xenomai-qemu-arm64.yml
> @@ -13,7 +13,7 @@ job_name: QEMU pipeline, xenomai-images-qemu-arm64
>  
>  timeouts:
>    job:
> -    minutes: 15
> +    minutes: 45
>    action:
>      minutes: 5
>    connection:
> @@ -74,7 +74,7 @@ actions:
>  
>  - test:
>      timeout:
> -      minutes: 45
> +      minutes: 30
>      definitions:
>      - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
>        from: git
> diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
> index 1c5cb2e..2949cd2 100644
> --- a/tests/jobs/xenomai-qemu-armhf.yml
> +++ b/tests/jobs/xenomai-qemu-armhf.yml
> @@ -13,7 +13,7 @@ job_name: QEMU pipeline, xenomai-images-qemu-armhf
>  
>  timeouts:
>    job:
> -    minutes: 15
> +    minutes: 45
>    action:
>      minutes: 5
>    connection:
> @@ -26,7 +26,7 @@ context:
>    arch: arm
>    cpu: cortex-a15
>    extra_options:
> -  - -smp 4
> +  - -smp 2
>    - -device virtio-serial-device
>    - -device virtconsole,chardev=con
>    - -chardev vc,id=con
> @@ -35,7 +35,7 @@ context:
>    guestfs_interface: none
>  metadata:
>    # please change these fields when modifying this job for your own tests.
> -  docs-source: xenomai-qemu-armhf
> +  docs-source: xenomai-qemuarmhf
>    docs-filename: qemu-pipeline-xenomai-armhf
>  
>  # ACTION_BLOCK
> 

Queued up in next - let's see if we get through with a full test run now...

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


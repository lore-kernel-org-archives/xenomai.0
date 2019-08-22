Subject: Re: [xenomai-images][PATCH] ci: Add ci build
References: <20190822123450.11589-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bd90c6f8-c3a9-3d28-03ac-f8b6e9d9a938@siemens.com>
Date: Thu, 22 Aug 2019 16:00:43 +0200
MIME-Version: 1.0
In-Reply-To: <20190822123450.11589-1-Quirin.Gylstorff@siemens.com>
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

On 22.08.19 14:34, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add jobs for all existing targets to execute the builds in
> gitlab ci. For manual testing or testing without gitlab add
> README entry for local runner.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   .gitlab-ci.yml | 27 +++++++++++++++++++++++++++
>   README.md      | 12 ++++++++++++
>   2 files changed, 39 insertions(+)
>   create mode 100644 .gitlab-ci.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> new file mode 100644
> index 0000000..89d2b29
> --- /dev/null
> +++ b/.gitlab-ci.yml
> @@ -0,0 +1,27 @@
> +variables:
> +  GIT_STRATEGY: clone
> +variables:
> +  http_proxy: "$HTTP_PROXY"
> +  https_proxy: "$HTTPS_PROXY"
> +  ftp_proxy: "$FTP_PROXY"
> +  no_proxy: "$NO_PROXY"
> +build:amd64:
> +  stage: build
> +  image: kasproject/kas-isar:latest
> +  script:
> +    - kas build kas.yml:board-qemu-amd64.yml
> +build:armhf:
> +  stage: build
> +  image: kasproject/kas-isar:latest
> +  script:
> +    - kas build kas.yml:board-qemu-armhf.yml
> +build:arm64:
> +  stage: build
> +  image: kasproject/kas-isar:latest
> +  script:
> +    - kas build kas.yml:board-qemu-arm64.yml
> +build:hikey:
> +  stage: build
> +  image: kasproject/kas-isar:latest
> +  script:
> +    - kas build kas.yml:board-hikey.yml
> diff --git a/README.md b/README.md
> index b2a99db..576f357 100644
> --- a/README.md
> +++ b/README.md
> @@ -36,6 +36,18 @@ Physical targets will generate ready-to-boot images under
>       dd if=build/tmp/deploy/images/hikey/demo-image-hikey-xenomai-demo-hikey.wic.img \
>          of=/dev/<medium-device> bs=1M status=progress
>   
> +## CI Build
> +
> +The CI build can be executed locally by
> +[installing the gitlab-runner](https://docs.gitlab.com/runner/install/).
> +
> +To execute the CI build use:
> +```
> +gitlab-runner exec docker --docker-privileged \
> +  --env "HTTP_PROXY=$HTTP_PROXY" --env "HTTPS_PROXY=$HTTPS_PROXY" \
> +  --env "NO_PROXY=$NO_PROXY" build:armhf
> +```
> +
>   ## Community Resources
>   
>   See [Xenomai project](https://www.xenomai.org/).
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


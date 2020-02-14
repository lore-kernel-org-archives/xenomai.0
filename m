Subject: Re: [xenomai-images PATCH 07/11] ci: Remove proxy settings
References: <20200214073259.1769-1-Quirin.Gylstorff@siemens.com>
 <20200214073259.1769-8-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <959fd91e-88a5-bec5-bbda-87b3844291a9@siemens.com>
Date: Fri, 14 Feb 2020 09:47:32 +0100
MIME-Version: 1.0
In-Reply-To: <20200214073259.1769-8-Quirin.Gylstorff@siemens.com>
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

On 14.02.20 08:32, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   .gitlab-ci.yml | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index b8dbbc5..54542b1 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -14,10 +14,6 @@ stages:
>   
>   variables:
>     GIT_STRATEGY: clone
> -  http_proxy: "$HTTP_PROXY"
> -  https_proxy: "$HTTPS_PROXY"
> -  ftp_proxy: "$FTP_PROXY"
> -  no_proxy: "$NO_PROXY"

Even if we no longer need it, let's keep this as pattern

>     XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
>     LINUX_BUILD_OPTION: ":opt-linux-latest.yml"
>     ISAR_IMAGE: demo-image
> @@ -31,13 +27,13 @@ default:
>   .add-lava-ssh-config:
>     before_script:
>       - mkdir -p -m=700 ~/.ssh
> -    - echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config

This should likely be fixed to take empty proxies into account. Then it 
can stay.

>       - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/lava_id_rsa && chmod 600 ~/.ssh/lava_id_rsa
>       - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
>   
>   .build:
>     extends: .add-lava-ssh-config
>     stage: build
> +  image: kasproject/kas-isar:latest

Unrelated - and incorrect - change.

>     script:
>       - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
>       - scripts/deploy_for_testing.sh ${TARGET}
> @@ -92,6 +88,7 @@ build:board-hikey:
>     variables:
>       TARGET: hikey
>       BUILD_OPTIONS: ":opt-lava-test.yml"
> +
>   lava-test:board-hikey:
>     needs: [ "build:board-hikey" ]
>     extends: .test
> @@ -104,7 +101,6 @@ build:board-beaglebone:
>       TARGET: beagle-bone-black
>       BUILD_OPTIONS: ":opt-lava-test.yml"
>   
> -
>   lava-test:board-beaglebone:
>     needs: [ "build:board-beaglebone" ]
>     extends: .test
> 

Unrelated changes.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


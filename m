Subject: Re: [xenomai-images PATCH 08/11] ci: add new build options
References: <20200214073259.1769-1-Quirin.Gylstorff@siemens.com>
 <20200214073259.1769-9-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b5c2503b-e08e-9214-3546-feb03c5f74ea@siemens.com>
Date: Fri, 14 Feb 2020 09:48:41 +0100
MIME-Version: 1.0
In-Reply-To: <20200214073259.1769-9-Quirin.Gylstorff@siemens.com>
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
>   .gitlab-ci.yml | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 54542b1..608d5db 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -147,3 +147,33 @@ lava-test:board-x86-64-efi:linux-4.4:
>     variables:
>       TARGET: x86-64
>       DEPLOY_DIR_EXTENSION: "4.4"
> +
> +build:board-beaglebone:xenomai-3.0.x:
> +  extends: .build
> +  variables:
> +    TARGET: beagle-bone-black
> +    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
> +    BUILD_OPTIONS: ":opt-lava-test.yml"
> +    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
> +
> +lava-test:board-beaglebone:xenomai-3.0.x:
> +  needs: [ "build:board-beaglebone:xenomai-3.0.x" ]
> +  extends: .test
> +  variables:
> +    TARGET: beaglebone
> +    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
> +
> +build:board-x86-64-efi:xenomai-3.0.x:
> +  extends: .build
> +  variables:
> +    TARGET: x86-64-efi
> +    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
> +    BUILD_OPTIONS: ":opt-lava-test.yml"
> +    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
> +
> +lava-test:board-x86-64-efi:xenomai-3.0.x:
> +  needs: [ "build:board-x86-64-efi:xenomai-3.0.x" ]
> +  extends: .test
> +  variables:
> +    TARGET: x86-64
> +    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
> 

See my comment on the other patch: A set of xenomai-3.0.x/linux-latest 
for x86 and arm would be good enough for now

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


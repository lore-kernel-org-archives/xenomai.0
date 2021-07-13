Subject: Re: [xenomai-images][PATCH 1/4] scripts/deploy_to_aws: Correct upload
 of dtb
References: <20210713145142.16025-1-Quirin.Gylstorff@siemens.com>
 <20210713145142.16025-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ceb1d34c-b49f-e410-6764-278c0be5ce09@siemens.com>
Date: Tue, 13 Jul 2021 17:02:05 +0200
MIME-Version: 1.0
In-Reply-To: <20210713145142.16025-2-Quirin.Gylstorff@siemens.com>
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

On 13.07.21 16:51, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If a dtb exists it was not uploaded correctly.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  scripts/deploy_to_aws.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
> index 814aec7..02f7aeb 100755
> --- a/scripts/deploy_to_aws.sh
> +++ b/scripts/deploy_to_aws.sh
> @@ -40,7 +40,7 @@ fi
>  image=$(ls "${images_dir}/${target}/${isar_base_name}".*.gz)
>  aws s3 cp "${aws_args}" "${image}" "${deploy_dir}/$(basename "${image}")"
>  # DTB
> -dtb="$(ls "${images_dir}/${target}/*.dtb" 2> /dev/null)"

Wasn't that quoting the actual issue? The old pattern of setting dtb
first was better than running ls twice.

Jan

> -if [ -n "${dtb}" ] ; then
> +if ls "${images_dir}/${target}/"*.dtb ; then
> +    dtb=$(ls "${images_dir}/${target}/"*.dtb )
>      aws s3 cp "${aws_args}" "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
>  fi
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


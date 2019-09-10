Subject: Re: [xenomai-images][PATCH 5/9] kas: Use next as target
References: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
 <20190905154425.10007-6-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b681b134-3a30-cdea-19f5-73e28fc52a2f@siemens.com>
Date: Tue, 10 Sep 2019 12:26:25 +0200
MIME-Version: 1.0
In-Reply-To: <20190905154425.10007-6-Quirin.Gylstorff@siemens.com>
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

On 05.09.19 17:44, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> For CI testing of the next branch.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   kas.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas.yml b/kas.yml
> index 260eb36..ee7b589 100644
> --- a/kas.yml
> +++ b/kas.yml
> @@ -36,4 +36,4 @@ local_conf_header:
>     cross: |
>       ISAR_CROSS_COMPILE = "1"
>     xenomai-version: |
> -    PREFERRED_VERSION_xenomai ?= "stable"
> +    PREFERRED_VERSION_xenomai ?= "next"
> 

See my comment on patch 2.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


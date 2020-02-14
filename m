Subject: Re: [xenomai-images PATCH 10/11] recipes-xenomai/xenomai.inc: add
 exception handling
References: <20200214082826.23337-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6c6df433-fcd4-02d8-82ca-0606c20d1064@siemens.com>
Date: Fri, 14 Feb 2020 09:50:02 +0100
MIME-Version: 1.0
In-Reply-To: <20200214082826.23337-1-Quirin.Gylstorff@siemens.com>
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

On 14.02.20 09:28, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If SRCREV is not available for given DISTRO_ARCH and xenomai version
> get_srcrev raise a FetchError exception. Avoid a build error be
> catching the exception.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   recipes-xenomai/xenomai/xenomai.inc | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
> index 3df635c..0a082a4 100644
> --- a/recipes-xenomai/xenomai/xenomai.inc
> +++ b/recipes-xenomai/xenomai/xenomai.inc
> @@ -13,7 +13,13 @@ inherit dpkg
>   
>   PROVIDES += "xenomai-kernel-source xenomai-runtime xenomai-runtime-dbgsym libxenomai1 libxenomai-dev libxenomai1-dbgsym"
>   # use bitbake get_srcrev to get the current commit id
> -COMMIT="${@bb.fetch2.get_srcrev(d).strip('AUTOINC+')}"
> +def get_commit(d):
> +    try:
> +        return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
> +    except bb.fetch2.FetchError:
> +        return ""
> +
> +COMMIT="${@get_commit(d)}"
>   do_prepare_build() {
>   	# The xenomai-kernel-source package is supposed to be generic, but we
>   	# build it per architecture in Isar, and those packages happen to be
> 

We have the same pattern in the linux-latest recipe. Should it be 
adjusted as well?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


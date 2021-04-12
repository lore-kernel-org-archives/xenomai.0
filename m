Subject: Re: [PATCH] ci: Increase default of CCACHE_MAXSIZE to 1 gigabyte
References: <20210412173721.13600-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f7ebcb51-7585-227e-f552-beb57325bfd7@siemens.com>
Date: Mon, 12 Apr 2021 21:57:52 +0200
MIME-Version: 1.0
In-Reply-To: <20210412173721.13600-1-Quirin.Gylstorff@siemens.com>
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

On 12.04.21 19:37, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The 5.4-arm64 build[1] needs a cache size greater than 400M.
> 
> [1]: https://gitlab.com/Xenomai/xenomai-hacker-space/-/jobs/1171197811
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index e04df30d1..d8dc67f68 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -18,7 +18,7 @@ variables:
>    GIT_STRATEGY: clone
>    KDIR: "/tmp/kernel"
>    USE_CCACHE: "1"
> -  CCACHE_MAXSIZE: "400M"
> +  CCACHE_MAXSIZE: "1G"
>    IPIPE_MIRROR_URL: "https://source.denx.de/Xenomai"
>    PACKAGES: "gcc-8 u-boot-tools git make bc bison libelf-dev autotools-dev \
>               autoconf autogen libtool pkg-config ccache flex libssl-dev"
> 

Thanks for analyzing and fixing this! Applied to next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


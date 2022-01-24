Message-ID: <ee4355cf-d62c-74a5-7ef3-e104f6e4f099@siemens.com>
Date: Mon, 24 Jan 2022 18:54:15 +0100
MIME-Version: 1.0
Subject: Re: [xenomai-images] [PATCH v2 1/2] xenomai: remove bootstrap task
 from dpkg_runbuild_prepend
Content-Language: en-US
References: <20220118105128.3007-1-ubely@ilbers.de>
 <20220118105128.3007-2-ubely@ilbers.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220118105128.3007-2-ubely@ilbers.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Uladzimir Bely <ubely@ilbers.de>, xenomai@xenomai.org

On 18.01.22 11:51, Uladzimir Bely via Xenomai wrote:
> This looks unneeded while bootstrapping is done in the same way
> in debian/rules file before the build.
> 
> Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
> ---
>   recipes-xenomai/xenomai/xenomai.inc | 17 -----------------
>   1 file changed, 17 deletions(-)
> 
> diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
> index fe84883..b8ec5bd 100644
> --- a/recipes-xenomai/xenomai/xenomai.inc
> +++ b/recipes-xenomai/xenomai/xenomai.inc
> @@ -13,15 +13,6 @@ inherit dpkg
>   
>   PROVIDES += "xenomai-kernel-source xenomai-runtime xenomai-runtime-dbgsym libxenomai1 libxenomai-dev libxenomai1-dbgsym"
>   
> -# use bitbake get_srcrev to get the current commit id
> -def get_commit(d):
> -    try:
> -        return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
> -    except bb.fetch2.FetchError:
> -        return ""
> -
> -COMMIT="${@get_commit(d)}"
> -
>   do_prepare_build() {
>       # Xenomai currently does not maintain its changelog, plus we want the
>       # actual package version in there.
> @@ -31,11 +22,3 @@ do_prepare_build() {
>       # package version more freely.
>       rm -f ${S}/debian/source/format
>   }
> -
> -dpkg_runbuild_prepend() {
> -    bbplain $(printf "xenomai-%s: Building revision %.20s\n" \
> -                     ${PV} ${COMMIT})

This is unrelated and must not be removed. It provides information about 
the actually built revision when using "latest" as version.

> -
> -    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
> -        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
> -}

Ah, that was obsolete by [1], fortunately in all stable branches as 
well. So this is fine indeed.

Jan

[1] 
https://gitlab.com/Xenomai/xenomai-hacker-space/-/commit/951739291eb208076b638a06351ff9aa23c524c2

-- 
Siemens AG, Technology
Competence Center Embedded Linux


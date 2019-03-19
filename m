Subject: Re: [PATCH] travis: add checkpatch analysis
References: <20190319142822.31027-1-roman.stratiienko@globallogic.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bec61ef6-33ff-7caf-2af5-114c4b7c4c18@siemens.com>
Date: Tue, 19 Mar 2019 15:45:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190319142822.31027-1-roman.stratiienko@globallogic.com>
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
To: roman.stratiienko@globallogic.com, xenomai@xenomai.org

On 19.03.19 15:28, roman.stratiienko--- via Xenomai wrote:
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> Check last 10 commits with checkpatch.pl before build
> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> ---
>   .travis.yml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 0cd9e571f..6fb604bf2 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -78,6 +78,7 @@ before_script:
>     - popd
>   
>   script:
> +  - ${KDIR}/scripts/checkpatch.pl --git HEAD~10..HEAD
>     - scripts/prepare-kernel.sh --ipipe=/tmp/ipipe.patch --arch=${ARCH} --linux=${KDIR}
>     - pushd ${KDIR}
>     - make -j $(nproc) olddefconfig
> 

Hmm, not convinced about enforced checking. That will fail the build, even if 
there might be a legitimate reason for some exception, no?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


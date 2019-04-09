MIME-Version: 1.0
References: <417b55d7-464c-9bb9-3742-b9e3edf8369f@siemens.com>
In-Reply-To: <417b55d7-464c-9bb9-3742-b9e3edf8369f@siemens.com>
From: Roman Stratiienko <roman.stratiienko@globallogic.com>
Date: Tue, 9 Apr 2019 23:47:39 +0300
Message-ID: <CAODwZ7uB1sNXZaNPWvgGDG+Egpg=eVNfyS8V+QFL_XeQ=sHVLw@mail.gmail.com>
Subject: Re: [PATCH] ci: Tune config
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

I have similar issue some time ago on another project, but due to lack of
time and low priority it was unsolved.
And you've found the root cause and it is great, thanks!.

I did some measurements of ccache size, and results is following:
- 4.14 arm64 - cache size - 232.7 MB
- 4.19 arm - cache size - 246.4 MB
- Others are even less.

So I suggest to left it 400MB, thus not to use too much disk space of
travis's servers.



On Tue, Apr 9, 2019 at 10:37 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> - disable DEBUG_INFO which bloats the build out and, thus, the ccache
> - grant more size to the ccache, specifically for arm64
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .travis.yml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 2139e499e4..32ae8d2b1c 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -14,7 +14,7 @@ env:
>    global:
>      - KDIR=/tmp/kernel
>      - USE_CCACHE=1
> -    - CCACHE_MAXSIZE=400M
> +    - CCACHE_MAXSIZE=1G
>
>  install:
>    - git clone --depth 1 --branch ${IPIPE_REV} ${IPIPE_KERNEL} ${KDIR}
> @@ -40,6 +40,11 @@ before_script:
>    - export PATH=~/ccache:$PATH
>    - pushd ${KDIR}
>    - make -j $(nproc) ${KERNEL_DEFCONFIG}
> +
> +  # Generic settings
> +  - ./scripts/config -d DEBUG_INFO
> +
> +  # I-pipe and Xenomai settings
>    - ./scripts/config -e IPIPE
>    - ./scripts/config -e XENOMAI
>    - ./scripts/config -e XENO_OPT_SCHED_CLASSES
> @@ -135,6 +140,7 @@ script:
>    - scripts/bootstrap
>    - ./configure --enable-smp ${CONFIGURE_OPTS}
>    - make -j $(nproc)
> +
>    - ccache -s
>
>  matrix:
> --
> 2.16.4
>


-- 
Best regards,
Roman Stratiienko
Global Logic
ADIT Team

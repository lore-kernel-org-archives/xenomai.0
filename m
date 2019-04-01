Subject: Re: [PATCH] travis: use ccache
References: <20190320160146.4224-1-roman.stratiienko@globallogic.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <4d885178-b10e-b70e-01d7-dd0f8ed823d1@web.de>
Date: Mon, 1 Apr 2019 20:02:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190320160146.4224-1-roman.stratiienko@globallogic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: roman.stratiienko@globallogic.com, xenomai@xenomai.org

On 20.03.19 17:01, roman.stratiienko--- via Xenomai wrote:
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
>
> This speeds-up travis build
>
> Measurement results (build with ipipe-core-4.14.85-arm-6)
>   - Without ccache: 26 min 7 sec
>   - With ccache (1st run): 31 min 21 sec
>   - With ccache (every next run): 4 min 23 sec
>
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> ---
>   .travis.yml | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index c5a9026aa..e40cec51d 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -1,5 +1,6 @@
>   language: c
>   dist: xenial
> +cache: ccache
>
>   addons:
>     apt:
> @@ -15,6 +16,8 @@ addons:
>   env:
>     global:
>       - KDIR=3D/tmp/kernel
> +    - USE_CCACHE=3D1
> +    - CCACHE_MAXSIZE=3D400M
>
>   install:
>     - if [[ "${KERNEL_VERSION}" =3D=3D *-rc* ]]; then
> @@ -40,6 +43,10 @@ before_script:
>             export CONFIGURE_OPTS=3D"--enable-dlopen-libs --enable-lazy-=
setsched"
>             ;;
>       esac
> +  - mkdir ~/ccache
> +  - ln -s /usr/bin/ccache ~/ccache/aarch64-linux-gnu-gcc
> +  - ln -s /usr/bin/ccache ~/ccache/arm-linux-gnueabihf-gcc
> +  - export PATH=3D~/ccache:$PATH
>     - pushd ${KDIR}
>     - make -j $(nproc) ${KERNEL_DEFCONFIG}
>     - ./scripts/config -e IPIPE
> @@ -88,6 +95,7 @@ script:
>     - scripts/bootstrap
>     - ./configure --enable-smp ${CONFIGURE_OPTS}
>     - make -j $(nproc)
> +  - ccache -s
>
>   matrix:
>     include:
>

Nice! Applied to next.

Jan


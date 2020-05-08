Subject: Re: [xenomai-images ][ PATCH v2 0/4] ci: Add configuration to run on
 gitlab.com
References: <20200507120333.31550-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <81f284e1-bd4d-756d-4f23-f2395aa8d955@siemens.com>
Date: Fri, 8 May 2020 12:51:09 +0200
MIME-Version: 1.0
In-Reply-To: <20200507120333.31550-1-Quirin.Gylstorff@siemens.com>
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

On 07.05.20 14:03, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add the configration to run the ci builds on gitlab.com or on-premise setups with
> gitlab artifacts enabled. Each completed pipeline creates around 1.5 GB aritfacts.
> An active pipeline can be seen at https://gitlab.com/Quirin.Gy/xenomai-images-test/pipelines.
> 
> Changes V2:
>   - rename .ci to ci
>   - rename files
>   - add .gitlab-ci-no-artifacts.yml to repository root
> 
> Quirin Gylstorff (4):
>    ci: Build and test from gitlab.com
>    ci: Add option to compress ext4-images.
>    test/README: Update
>    scripts/run-lava-tests: Add LAVA_MASTER_URL
> 
>   .gitlab-ci.yml                                | 145 +---------------
>   ci/artifacts.yml                              |  26 +++
>   ci/gitlab-ci-base.yml                         | 156 ++++++++++++++++++
>   ci/no-artifacts.yml                           |  22 +++
>   .../0001-classes-ext4.img-Compress.patch      |  31 ++++
>   opt-ext4-gz.yml                               |  24 +++
>   scripts/deploy_for_testing.sh                 |   4 +-
>   scripts/get-build-id.sh                       |  29 ++++
>   scripts/install-lavacli.sh                    |   5 +-
>   scripts/run-lava-tests.sh                     |  10 +-
>   tests/README.md                               |  60 +++++--
>   ...bone.yml => xenomai-beagle-bone-black.yml} |   4 +-
>   tests/jobs/xenomai-hikey.yml                  |   4 +-
>   tests/jobs/xenomai-ipc227e.yml                |   6 +-
>   tests/jobs/xenomai-minnow.yml                 |   6 +-
>   tests/jobs/xenomai-qemu-amd64.yml             |   6 +-
>   tests/jobs/xenomai-qemu-arm64.yml             |   6 +-
>   tests/jobs/xenomai-qemu-armhf.yml             |   6 +-
>   ...omai-x86-64.yml => xenomai-x86-64-efi.yml} |   6 +-
>   19 files changed, 369 insertions(+), 187 deletions(-)
>   create mode 100644 ci/artifacts.yml
>   create mode 100644 ci/gitlab-ci-base.yml
>   create mode 100644 ci/no-artifacts.yml
>   create mode 100644 isar-patches/0001-classes-ext4.img-Compress.patch
>   create mode 100644 opt-ext4-gz.yml
>   create mode 100755 scripts/get-build-id.sh
>   rename tests/jobs/{xenomai-beaglebone.yml => xenomai-beagle-bone-black.yml} (91%)
>   rename tests/jobs/{xenomai-x86-64.yml => xenomai-x86-64-efi.yml} (86%)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


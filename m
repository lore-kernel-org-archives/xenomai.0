Subject: Re: [xenomai-images][PATCH v2 0/4] ci improvements
References: <20191001125203.10757-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d6a36628-53ef-fa26-4ee6-f2cda3e36d13@siemens.com>
Date: Tue, 8 Oct 2019 12:12:56 +0200
MIME-Version: 1.0
In-Reply-To: <20191001125203.10757-1-Quirin.Gylstorff@siemens.com>
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

On 01.10.19 14:51, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Improve the ci by:
> 
> - Adding  option --vm to successfully execute qemu tests.
> - Fixing beaglebone tests after lava update.
> - Compress rootfs to speed up the deployment
> - use pipeline id to differ between test runs.
> 
> Changes:
> V2:
> - cleanup
> 
> Quirin Gylstorff (4):
>   ci: Use unique test ids
>   ci: Use compression for rootfs
>   ci: Run qemu tests with --vm option
>   xenomai-beaglebone: remove context after update
> 
>  scripts/deploy_for_testing.sh     |  7 ++++++-
>  scripts/run-lava-tests.sh         | 13 ++++++++++++-
>  tests/jobs/xenomai-beaglebone.yml |  9 +++------
>  tests/jobs/xenomai-minnow.yml     |  6 +++---
>  tests/jobs/xenomai-qemu-amd64.yml | 12 +++++++-----
>  tests/jobs/xenomai-qemu-arm64.yml | 12 +++++++-----
>  tests/jobs/xenomai-qemu-armhf.yml | 12 +++++++-----
>  tests/jobs/xenomai-x86-64.yml     |  6 +++---
>  8 files changed, 48 insertions(+), 29 deletions(-)
> 

Thanks, pushed all to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


Subject: Re: [xenomai-images][PATCH v2 0/4] Incorporate Comments and fix AWS
 upload
References: <20210714074155.2625-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fc8f8ca1-5f79-2c65-db65-219a8f12edf0@siemens.com>
Date: Wed, 14 Jul 2021 10:07:31 +0200
MIME-Version: 1.0
In-Reply-To: <20210714074155.2625-1-Quirin.Gylstorff@siemens.com>
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

On 14.07.21 09:41, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
>  Incorporate the comments from patchset[1] set by uploading a test-report.xml
>  to gitlab artifacts[2] and replace sed commands with envsubst[3].
> 
> 
> Changes V2:
>  - use gitlab reports to display a test summary,  e.g. [4]
>  - simplify if dtb exists check
> 
> [1]: https://xenomai.org/pipermail/xenomai/2021-July/045823.html
> [2]: https://xenomai.org/pipermail/xenomai/2021-July/045833.html
> [3]: https://xenomai.org/pipermail/xenomai/2021-July/045830.html
> [4]: https://gitlab.com/Quirin.Gy/xenomai-images-test/-/pipelines/336323070/test_report
> 
> Quirin Gylstorff (4):
>   scripts/deploy_to_aws: Correct upload of dtb
>   scripts/run-lava-tests: upload lava test report
>   scripts/run-lava-tests: replace sed with envsubst
>   scripts/run-lava-tests: parse test-report for errors
> 
>  ci/gitlab-ci-base.yml     |  6 ++++++
>  scripts/deploy_to_aws.sh  |  2 +-
>  scripts/run-lava-tests.sh | 23 +++++++++++++++--------
>  3 files changed, 22 insertions(+), 9 deletions(-)
> 

Thanks, all applied to next. Let's see if we can get the new lab setup
started...

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


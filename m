Subject: Re: [xenomai-images][PATCH 0/4] Prepare xenomai-images for public
 LAVA Server
References: <20210708150301.24083-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e87744e6-b0ae-62c6-bf3b-d6a62233e354@siemens.com>
Date: Thu, 8 Jul 2021 17:43:46 +0200
MIME-Version: 1.0
In-Reply-To: <20210708150301.24083-1-Quirin.Gylstorff@siemens.com>
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

On 08.07.21 17:02, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add option to upload the image under test to AWS.
> Add option to use AWS as image download source and use
> [1] as default LAVA server.
> 
> After this patchset is merged the private lava lab
> can be migrated.
> 
> [1]: https://lava.xenomai.org
> 
> Quirin Gylstorff (4):
>   ci: Add option to upload artifacts to aws bucket
>   ci: adapt to public lava-server
>   scripts/run_lava_tests.sh: cleanup shellcheck warnings
>   README: Add information about LAVA Lab
> 
>  README.md                 | 14 ++++++
>  ci/gitlab-ci-base.yml     |  6 ++-
>  scripts/deploy_to_aws.sh  | 46 ++++++++++++++++++++
>  scripts/run-lava-tests.sh | 90 +++++++++++++++++++++++----------------
>  4 files changed, 117 insertions(+), 39 deletions(-)
>  create mode 100755 scripts/deploy_to_aws.sh
> 
> - '- 
> 2.20.1
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


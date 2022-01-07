Message-ID: <e3f03234-ec10-f901-2455-e90e3b752f05@siemens.com>
Date: Fri, 7 Jan 2022 14:41:35 +0100
MIME-Version: 1.0
Subject: Re: [xenomai-images][PATCH v3 2/5] ci: Refactor inclusions
Content-Language: en-US
References: <cover.1641556862.git.jan.kiszka@siemens.com>
 <ae2031500a2efb199421d138cba5cfd65f50dfff.1641556862.git.jan.kiszka@siemens.com>
 <8e52d9e1-c40b-25f6-df6e-30fe4019024d@siemens.com>
 <01c5f582-8c0e-bbea-5c93-d051d3fa6660@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <01c5f582-8c0e-bbea-5c93-d051d3fa6660@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org



On 1/7/22 14:40, Jan Kiszka wrote:
> On 07.01.22 14:36, Gylstorff Quirin wrote:
>>
>>
>> On 1/7/22 13:00, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This makes the inclusion structure more regular and reduces duplications
>>> by re-using the kernel_<version>.yml files for 3.1 and next. The trick
>>> is that we pull common variables to additional top-level 'variables:'
>>> blocks and only set what differes in the job-specific 'variables:'.
>>>
>>> DEPLOY_DIR_EXTENSION is now identical to BUILD_IDENTIFIER, and the
>>> latter is derived from the XENOMAI_VERSION and KERNEL_VERSION. Only
>>> those version variables are set at xenomai_<version>.yml and kernel-
>>> specific job level, respectively.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>    ci/gitlab-ci-base.yml                         |  3 +-
>>>    ..._4_19_xenomai_next.yml => kernel_4_19.yml} | 32 +++----
>>>    ..._5_10_xenomai_next.yml => kernel_5_10.yml} | 32 +++----
>>>    ...el_5_4_xenomai_next.yml => kernel_5_4.yml} | 32 +++----
>>>    ci/xenomai_3_0_x.yml                          | 23 ++---
>>>    ci/xenomai_3_1_x.yml                          | 91 ++-----------------
>>>    ci/xenomai_next.yml                           | 13 ++-
>>>    7 files changed, 64 insertions(+), 162 deletions(-)
>>>    rename ci/{kernel_4_19_xenomai_next.yml => kernel_4_19.yml} (71%)
>>>    rename ci/{kernel_5_10_xenomai_next.yml => kernel_5_10.yml} (71%)
>>>    rename ci/{kernel_5_4_xenomai_next.yml => kernel_5_4.yml} (71%)
>>>
>>> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
>>> index 367085d..27271ce 100644
>>> --- a/ci/gitlab-ci-base.yml
>>> +++ b/ci/gitlab-ci-base.yml
>>> @@ -18,10 +18,11 @@ variables:
>>>      https_proxy: "$HTTPS_PROXY"
>>>      ftp_proxy: "$FTP_PROXY"
>>>      no_proxy: "$NO_PROXY"
>>> -  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
>>>      ISAR_IMAGE: demo-image
>>>      ISAR_DISTRIBUTION: xenomai-demo
>>>      LAVA_TESTS_ENABLED: "true"
>>> +  DEPLOY_DIR_EXTENSION: "${BUILD_IDENTIFIER}"
>>> +  BUILD_IDENTIFIER:
>>> "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>>
>> The variable DEPLOY_DIR_EXTENSIONS is no longer necessary. We could
>> replace it in the scripts `deploy_to_aws.sh` and `run-lava-tests.sh`
>> with BUILD_IDENTIFIER.
>>
> 
> DEPLOY_DIR_EXTENSION was mentioned somewhere in the README, so I didn't
> dare to touch it. How should tests/README.md adjusted best then?
> 

It can be removed.


> Jan
> 
Quirin


Subject: Re: [xenomai-images][PATCH 2/4] scripts/run-lava-tests: upload lava
 test report
References: <20210713145142.16025-1-Quirin.Gylstorff@siemens.com>
 <20210713145142.16025-3-Quirin.Gylstorff@siemens.com>
 <7ec754a5c95cb772b3508eff329bf2b771e4a124.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <174d83af-eecd-e070-043d-9765ae8627b8@siemens.com>
Date: Tue, 13 Jul 2021 17:04:09 +0200
MIME-Version: 1.0
In-Reply-To: <7ec754a5c95cb772b3508eff329bf2b771e4a124.camel@siemens.com>
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "Gylstorff, Quirin (T RDA IOT SES-DE)" <quirin.gylstorff@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 13.07.21 16:58, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> On Tue, 2021-07-13 at 16:51 +0200, Q. Gylstorff via Xenomai wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> upload a test report to gitlab to increase tracing of build
>> errors.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  ci/gitlab-ci-base.yml     |  5 +++++
>>  scripts/run-lava-tests.sh | 12 ++++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
>> index 96b9c2c..e14cef5 100644
>> --- a/ci/gitlab-ci-base.yml
>> +++ b/ci/gitlab-ci-base.yml
>> @@ -57,6 +57,11 @@ default:
>>      - scripts/run-lava-tests.sh ${TARGET}
>>    variables:
>>      BUILD_JOB_NAME: "build-${BUILD_IDENTIFIER}:${TARGET}${TARGET_EXTENSION}"
>> +  artifacts:
>> +    when: always
>> +    paths:
>> +    - test-report.xml
> 
> Marking this file as junit test report should simplify the test result
> integration in gitlab, but I'm not 100% sure this is still necessary.
> 
> artifacts:
>   reports:
>     junit: test-report.xml
> 
> ^^ Something like that should do it.
> 

That's what the docu suggests as well:
https://docs.gitlab.com/ee/ci/unit_test_reports.html

Jan

>> +    expire_in: 1 week
>>    only:
>>      variables:
>>        - $LAVA_TESTS_ENABLED == "true"
>> diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
>> index 72138c3..a69bd87 100755
>> --- a/scripts/run-lava-tests.sh
>> +++ b/scripts/run-lava-tests.sh
>> @@ -9,6 +9,7 @@
>>  #
>>  # SPDX-License-Identifier: MIT
>>  #
>> +
>>  TARGET=$1
>>  if [ -z "${TARGET}" ]; then
>>      echo "no target was given"
>> @@ -72,10 +73,21 @@ sed -i "s|\${ISAR_DISTRIBUTION}|${ISAR_DISTRIBUTION}|g" "$template"
>>  echo "submit lava job"
>>
>>
>>
>>
>>  test_id=$(lavacli jobs submit "${template}")
>> +
>> +echo "get logs from  lava job ${test_id}"
>>  lavacli jobs logs "${test_id}"
>>  lavacli results "${test_id}"
>> +
>> +# add test report download
>> +api="${lava_master_uri}/api/v0.2/jobs/${test_id}/junit"
>> +auth="?token=${LAVA_MASTER_TOKEN}"
>> +url="${api}/${auth}"
>> +
>> +curl --silent "${url}" -o test-report.xml
>> +
>>  # change return code to generate a error in gitlab-ci if a test is failed
>>  number_of_fails="$(lavacli results "${test_id}" | grep -c fail )"
>> +
>>  if [ -n "${ssh_pid}" ];then
>>     kill "${ssh_pid}"
>>  fi
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


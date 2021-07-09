Subject: Re: [xenomai-images][PATCH 3/4] scripts/run_lava_tests.sh: cleanup
 shellcheck warnings
References: <20210708150301.24083-1-Quirin.Gylstorff@siemens.com>
 <20210708150301.24083-4-Quirin.Gylstorff@siemens.com>
 <d1a0cbbffe252f7ceba3110da22ad734974d23b1.camel@siemens.com>
 <66104a5d-3773-77d4-f8fc-f01586ef404f@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <31c4ae0d-89dd-2201-f74c-672d8378e8fd@siemens.com>
Date: Fri, 9 Jul 2021 13:48:29 +0200
MIME-Version: 1.0
In-Reply-To: <66104a5d-3773-77d4-f8fc-f01586ef404f@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>, "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09.07.21 13:40, Gylstorff Quirin wrote:
> 
> 
> On 7/8/21 5:50 PM, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
>> On Thu, 2021-07-08 at 17:03 +0200, Q. Gylstorff via Xenomai wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Add missing quotes and simplify statements.
>>> Also add messages to indicate progress.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>>   scripts/run-lava-tests.sh | 37 ++++++++++++++++++++++---------------
>>>   1 file changed, 22 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
>>> index e8c7377..72138c3 100755
>>> --- a/scripts/run-lava-tests.sh
>>> +++ b/scripts/run-lava-tests.sh
>>> @@ -9,11 +9,10 @@
>>>   #
>>>   # SPDX-License-Identifier: MIT
>>>   #
>>> -set -e
>>>   TARGET=$1
>>>   if [ -z "${TARGET}" ]; then
>>>       echo "no target was given"
>>> -    exit -1
>>> +    exit 1
>>>   fi
>>>
>>>
>>>
>>>
>>>   if [ -n "${LAVA_SSH_HOST}" ]; then
>>> @@ -24,7 +23,7 @@ if [ -n "${LAVA_SSH_HOST}" ]; then
>>>       lava_identity="-i ${LAVA_SSH_KEY_PATH:-~/.ssh/lava_id_rsa}"
>>>       lava_ssh_destination="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
>>>       # open connection for ssh port forwarding
>>> -    ssh -N "${lava_ssh_port}" "${lava_identity}" -o 'LocalForward
>>> localhost:'"${lava_master_port}"' localhost:80'
>>> "${lava_ssh_destination}" &
>>> +    ssh -N ${lava_ssh_port} ${lava_identity} -o 'LocalForward
>>> localhost:'${lava_master_port}' localhost:80' ${lava_ssh_destination} &
>>>       ssh_pid="$!"
>>>       # wait for connection
>>>       interval=1
>>> @@ -47,28 +46,36 @@ else
>>>      
>>> lava_master_uri="${LAVA_MASTER_URL:-https://lava.xenomai.org/}"
>>>
>>>   fi
>>>
>>>
>>>
>>>
>>> +echo "connect to lava server: ${lava_master_uri}"
>>> +
>>>   # connect to lava master
>>> -lavacli identities add --token ${LAVA_MASTER_TOKEN} --uri
>>> ${lava_master_uri} --username ${LAVA_MASTER_ACCOUNT} default
>>> +lavacli identities add --token "${LAVA_MASTER_TOKEN}" --uri
>>> "${lava_master_uri}" --username "${LAVA_MASTER_ACCOUNT}" default
>>>   #generate lava job description from template
>>>   if [ -n "${USE_GITLAB_ARTIFACTS}" ]; then
>>>      
>>> DEPLOY_URL="${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/jobs/${BUILD_JOB_ID}/artifacts/build/tmp/deploy/images/${TARGET}"
>>>
>>>   else
>>>      
>>> DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
>>>   fi
>>> +
>>> +echo "Deploy artifacts from '${artifact_url}'"
>>> +
>>>   job_template_path="${JOB_TEMPLATE_PATH:-tests/jobs/xenomai}"
>>>   tmp_dir=$(mktemp -d)
>>> -template=${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml
>>> -cp ${job_template_path}-${TARGET}.yml ${template}
>>> -sed -i "s|\${TARGET}|${TARGET}|g" $template
>>> -sed -i "s|\${BUILD_ARCH}|${BUILD_ARCH}|g" $template
>>> -sed -i "s|\${DEPLOY_URL}|${DEPLOY_URL}|g" $template
>>> -sed -i "s|\${ISAR_IMAGE}|${ISAR_IMAGE}|g" $template
>>> -sed -i "s|\${ISAR_DISTRIBUTION}|${ISAR_DISTRIBUTION}|g" $template
>>> -test_id=$(lavacli jobs submit ${template})
>>> -lavacli jobs logs ${test_id}
>>> -lavacli results ${test_id}
>>> +template="${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml"
>>> +cp "${job_template_path}-${TARGET}.yml" "${template}"
>>> +sed -i "s|\${TARGET}|${TARGET}|g" "$template"
>>> +sed -i "s|\${BUILD_ARCH}|${BUILD_ARCH}|g" "$template"
>>> +sed -i "s|\${DEPLOY_URL}|${DEPLOY_URL}|g" "$template"
>>> +sed -i "s|\${ISAR_IMAGE}|${ISAR_IMAGE}|g" "$template"
>>> +sed -i "s|\${ISAR_DISTRIBUTION}|${ISAR_DISTRIBUTION}|g" "$template"
>>> +
>>> +echo "submit lava job"
>>> +
>>> +test_id=$(lavacli jobs submit "${template}")
>>> +lavacli jobs logs "${test_id}"
>>> +lavacli results "${test_id}"
>>>   # change return code to generate a error in gitlab-ci if a test is
>>> failed
>>> -number_of_fails=$(lavacli results ${test_id} | grep fail | wc -l )
>>> +number_of_fails="$(lavacli results "${test_id}" | grep -c fail )"
>>
>> In addition to fetching the number of failed tests it would be possible
>> to download a junit test report from the lava master.
>>
>> Something like the following could do it:
>>
>> api="${lava_master_uri}/api/v0.2/jobs/${test_id}/junit"
>> auth="?token=${LAVA_MASTER_TOKEN}"
>> url="${api}/${auth}"
>> curl "${url}" -o test-report.xml
>>
>> This xml can be integrated as artifact into gitlab, so we can see
>> details about test duration, state, ..., in gitlab directly. No need to
>> visit the LAVA instance for details.
> 
> Do we have artifacts on https://source.denx.de? If not we can use AWS
> for storage.
> 

I don't see anything that should prevent storing a few small files along
the usual logs. Not sure how long the latter are kept, but those test
reports should probably have a similar lifetime.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


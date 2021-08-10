Subject: Re: [xenomai-images][RFC][PATCH] ci: Switch to Google nameserver
References: <b8d43c93-6780-6087-4a7b-cce4fc815f22@siemens.com>
 <3bbba763-c423-e206-aea1-037b47395da3@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <85adff9b-6821-a217-4776-8e3a882a474e@siemens.com>
Date: Tue, 10 Aug 2021 18:44:56 +0200
MIME-Version: 1.0
In-Reply-To: <3bbba763-c423-e206-aea1-037b47395da3@siemens.com>
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
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 06.08.21 10:50, Jan Kiszka via Xenomai wrote:
> On 02.08.21 17:43, Jan Kiszka via Xenomai wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This is a temporary hack: Our AWS runners see a lot of DNS errors for
>> deb.debian.org. Let's see if they are less with this server.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Seems to work, though only one run passed so far. Go this way for now?
>>
>>  ci/gitlab-ci-base.yml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
>> index 2638dec..ce9c800 100644
>> --- a/ci/gitlab-ci-base.yml
>> +++ b/ci/gitlab-ci-base.yml
>> @@ -39,6 +39,7 @@ default:
>>    extends: .add-proxy-config
>>    stage: build
>>    script:
>> +    - sudo sh -c "echo 'nameserver 8.8.8.8' > /etc/resolv.conf"
>>      - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-debug.yml"
>>      - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-debug.yml
>>      - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
>>
> 
> Seems you found the reason in our AWS setup. I'm dropping this from next
> again to confirm that we are safe.
> 

Back and forth: As the issue reoccurred with this removed (only the one
before the image runs was apparently resolved), this is back into next
again. So far, it looks good.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


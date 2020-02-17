Subject: Re: [xenomai-images PATCH v2 2/9] ci: Use gitlab extends instead of
 YAML Anchors
References: <20200214122703.7947-1-Quirin.Gylstorff@siemens.com>
 <20200214122703.7947-3-Quirin.Gylstorff@siemens.com>
 <483ac0b8-3d0d-e4cb-2215-ee036efd1fa3@siemens.com>
 <a70111fc-4961-3f2a-d30d-bf62bbee8069@siemens.com>
 <9f43afd8-45f7-3a8f-82bd-6a422bacd7b0@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d18a6d66-c0d0-10ad-c4f0-c589e9cd24f2@siemens.com>
Date: Mon, 17 Feb 2020 17:50:03 +0100
MIME-Version: 1.0
In-Reply-To: <9f43afd8-45f7-3a8f-82bd-6a422bacd7b0@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>, xenomai@xenomai.org

On 17.02.20 17:12, Gylstorff Quirin wrote:
> 
> 
> On 2/17/20 12:45 PM, Jan Kiszka wrote:
>> On 17.02.20 12:43, Jan Kiszka via Xenomai wrote:
>>> On 14.02.20 13:26, Q. Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> Gitlab uses extends as an alternative to YAML Anchors since 11.3.
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>>   .gitlab-ci.yml | 35 ++++++++++++++++++-----------------
>>>>   1 file changed, 18 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>>> index e5dd3c1..4b3f970 100644
>>>> --- a/.gitlab-ci.yml
>>>> +++ b/.gitlab-ci.yml
>>>> @@ -25,22 +25,23 @@ default:
>>>>   # add lavacli to the container and install the ssh keys
>>>>   # for the test infrastructure
>>>> -.add-lava-ssh-config: &lava-ssh-key
>>>> +.add-lava-ssh-config:
>>>>     before_script:
>>>>       - mkdir -p -m=700 ~/.ssh
>>>>       - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/id_rsa && 
>>>> chmod 600 ~/.ssh/id_rsa
>>>>       - echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 
>>>> 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 
>>>> 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config
>>>>       - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 
>>>> 644 ~/.ssh/known_hosts
>>>> -.build: &build-job
>>>> -  <<: *lava-ssh-key
>>>> +.build:
>>>> +  extends: .add-lava-ssh-config
>>>>     stage: build
>>>>     script:
>>>>       - kas build 
>>>> kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS} 
>>>>
>>>>       - scripts/deploy_for_testing.sh ${TARGET}
>>>> -.test: &test-job
>>>> -  <<: *lava-ssh-key
>>>> +.test:
>>>> +  extends: .add-lava-ssh-config
>>>> +  image: kasproject/kas-isar:latest
>>>
>>> This image is new (or I missed it in v1). Intentional?
>>
>> BTW, changing to kas-isar:2.0 might be good so that we do not run into 
>> surprises with CI.
> 
> I can do that in a v3.

No need for v3, but I'd take a patch on top.

>>
>> Jan
>>
>>>
>>> Jan
> 
> 
> This was added by my for local testing - if you execute the gitlab ci 
> runner on your own machine it does not read the default settings and
> each test needs to addd its own image. This entry can be removed.

OK, done so while merging the series.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


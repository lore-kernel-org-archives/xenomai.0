Subject: Re: [PATCH 1/1] gitlab-ci: add cache to decrease build times
References: <20200930105146.19902-1-Quirin.Gylstorff@siemens.com>
 <8108a4a6-674b-6813-4342-e81b30ffbb51@siemens.com>
 <2fa58248-e1a0-1a23-3147-a49e1a5b0a00@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Message-ID: <94100773-8d7e-6467-38b6-1ece06290139@siemens.com>
Date: Tue, 13 Oct 2020 11:35:19 +0200
MIME-Version: 1.0
In-Reply-To: <2fa58248-e1a0-1a23-3147-a49e1a5b0a00@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org



On 10/12/20 12:36 PM, Jan Kiszka wrote:
> On 07.10.20 10:10, Gylstorff Quirin wrote:
>> Hi,
>>
>> Here is some data to the caching.
>>
>> during my test it reduced the build times from around 45min to around
>> 25min.
> 
> In travis, a warm rebuild was ~10 min. in the endGood to know. I will look into the runner config.

> 
>> The size of the cache is for each build is around 500k.
> 
> 500K? It used to be 200-300 MB in travis. Sounds a bit inconsistent.

Here is a log from ccache

https://gitlab.com/Quirin.Gy/xenomai/-/jobs/765078542.

Config change due to the switch to Debian.

Ignore the build time. This runner has only half a core for building.

Quirin

> 
> Jan
> 
>>
>> Quirin
>>
>> On 9/30/20 12:51 PM, Q. Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Add the variable CCACHE_DIR to the build to move the ccache from
>>> ~/.ccache
>>> to the current directory and upload the cache from each build.
>>>
>>> Each job uses a separate cache.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>>    .gitlab-ci.yml | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index 59bd1d355..fa0795acd 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -18,6 +18,7 @@ variables:
>>>      GIT_STRATEGY: clone
>>>      KDIR: "/tmp/kernel"
>>>      USE_CCACHE: "1"
>>> +  CCACHE_DIR: "./.ccache"
>>>      CCACHE_MAXSIZE: "400M"
>>>      IPIPE_MIRROR_URL: "https://gitlab.denx.de/Xenomai"
>>>      PACKAGES: "gcc-8 gcc-8-aarch64-linux-gnu libc6-dev-arm64-cross \
>>> @@ -162,7 +163,10 @@ variables:
>>>        - ./configure --enable-smp ${CONFIGURE_OPTS}
>>>        - make -j $(nproc)
>>>        - ccache -s
>>> -
>>> +  cache:
>>> +    key: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
>>> +    paths:
>>> +      - $CCACHE_DIR
>>>      arm-4.19-release:
>>>      extends: .build
>>>
>>
> 
> 

-- 
With best regards,
Quirin Gylstorff

Siemens AG
T RDA IOT SES-DE
Otto-Hahn-Ring 6
81739 Muenchen, Germany
Mobile: +49 173 3746683
mailto:quirin.gylstorff@siemens.com
www.siemens.com

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim 
Hagemann Snabe; Managing Board: Joe Kaeser, Chairman, President and 
Chief Executive Officer; Roland Busch, Klaus Helmrich, Cedrik Neike, 
Matthias Rebellius, Ralf P. Thomas, Judith Wiese; Registered offices: 
Berlin and Munich, Germany; Commercial registries: 
Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 
23691322

Important notice: This e-mail and any attachment thereof contain 
corporate proprietary information. If you have received it by mistake, 
please notify us immediately by reply e-mail and delete this e-mail and 
its attachments from your system. Thank you.


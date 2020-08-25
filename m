Subject: Re: [xenomai-images][ PATCH v2 0/4] ci: Add configuration to run on
 gitlab.com
References: <20200824112527.4616-1-Quirin.Gylstorff@siemens.com>
 <a292b9e6-c9f5-af0d-3032-44c2d6ed4b1c@siemens.com>
 <979d4c5d-7733-3e83-7770-d2d7f6662685@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2919eb70-6026-ac4c-4308-30c903510504@siemens.com>
Date: Tue, 25 Aug 2020 07:28:37 +0200
MIME-Version: 1.0
In-Reply-To: <979d4c5d-7733-3e83-7770-d2d7f6662685@siemens.com>
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
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>, xenomai@xenomai.org

On 24.08.20 18:15, Gylstorff Quirin wrote:
> 
> 
> On 8/24/20 1:30 PM, Jan Kiszka wrote:
>> On 24.08.20 13:25, Q. Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>>
>>> Add the configration to run the ci builds on gitlab.com or on-premise
>>> setups with
>>> gitlab artifacts enabled. Each completed pipeline creates around 1.5
>>> GB aritfacts.
>>
>> Are those artifacts pushed around, to/from the gitlab instance? Our
>> on-premise won't support that, others may not like it either.
> The build uses the artifacts command to push them to the gitlab instance.
> It is possible to use .gitlab-ci-no-artifacts.yml to avoid pushing
> around the artifacts. This is the behaviour for our on-premise builds.
> 
> If most people don't want to use the artifacts I can switch the default
> to the old behavior.

Given the size, I'm inclined to make gitlab-native artifacts an opt-in
and rather look for providing a pattern that allows storing them in S3,
e.g., in case you have a cloud runner.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


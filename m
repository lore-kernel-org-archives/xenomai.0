Subject: Re: Public xenomai testing infrastructure
References: <06aa62dc-b2da-9330-2ecc-e358c35f27cf@siemens.com>
 <c298eafc-c2e9-a576-9905-cc22427302e6@siemens.com>
 <e79de6ef-14d8-20e8-0530-5e49592f048f@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Message-ID: <23ec95b6-263b-503e-8202-7abacac1ea94@siemens.com>
Date: Fri, 17 Apr 2020 09:41:52 +0200
MIME-Version: 1.0
In-Reply-To: <e79de6ef-14d8-20e8-0530-5e49592f048f@siemens.com>
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
To: xenomai@xenomai.org

Hi all,

I had some time at hand and this how a public run of the xenomai test 
infrastructure could look like:

https://gitlab.com/Quirin.Gy/xenomai-images-test/pipelines/136863923

Best regards
Quirin

On 3/6/20 2:05 PM, Gylstorff Quirin via Xenomai wrote:
> 
> 
> On 3/5/20 2:51 PM, Jan Kiszka wrote:
>> On 05.03.20 14:41, Gylstorff Quirin wrote:
>>> Hi all,
>>>
>>> As Jan mentioned in some post we have a CI infrastructure[1]
>>> - currently only internal available - based on gitlab & LAVA[2].
>>>   We plan to create a public version of this infrastructure.
>>>
>>> The setup will similar to the testing in CIP project[3]. The results
>>> of a build are transferred via a public LAVA master to private 
>>> instances of LAVA workers to the device-under-test and executed and 
>>> the result displayed on the LAVA master.
>>>
>>> We intend to use xenomai-images to build  kernel,root file system and 
>>> xenomai.
>>>
>>> The CI infrastructure will have the following components:
>>> - Public/Private Builds with gitlab, travis or similar
>>> - Public Lava Master (scheduling of test and display of results)
>>> - Private Lava worker connect to Hardware targets
>>>
>>> Current open topics for the CI Infrastructure
>>> - where to execute the public builds?
>>>    - gitlab oss program[4]
>>>      - can we run builds of xenomai-image
>>>    - travis
>>         (then paid, we won't scale as free project)
>>
>>       - AWS, like we do in the CIP project via
>>         https://gitlab.com/cip-project/cip-testing/gitlab-cloud-ci
>>
>>>    - somewhere else
>>> - Where to store the build artifacts?
>>>    - AWS buckets
>>>    - locally on the Master
>>
>> You mean the Lava Master, I suppose.
>>
>>> - How long to store the build artifacts?
>>>    - 1 week
>>
>> - until overwritten by a newer version - unfortunately not a feature of
>>    gitlab artifacts
>>
>>> - Where to run the public Lava Master?
>>>    - AWS or similar instance
>>>      - Payment of the instance
>>>    - Physical Server
>>>      - Who can host the server
>>>
>>>
>>> [1]: 
>>> https://gitlab.denx.de/Xenomai/xenomai-images/blob/master/tests/README.md#test-architecture 
>>>
>>> [2]: https://lavasoftware.org/
>>> [3]: 
>>> https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/centalisedtesting 
>>>
>>> [4]: 
>>> https://about.gitlab.com/handbook/marketing/community-relations/opensource-program/ 
>>>
>>>
> 
> I tested xenomai-images with in my gitlab account and it work  - slowly ;-)
> 
> You can check out the build:
> https://gitlab.com/Quirin.Gy/xenomai-images-test/pipelines/123917771
> 
> Next test would be to store the results as artifacts.
> 
> Quirin
> 
> 
> 
> 

-- 
Quirin Gylstorff

Siemens AG
Corporate Technology
Research in Digitalization and Automation
Smart Embedded Systems
CT RDA IOT SES-DE
Otto-Hahn-Ring 6
81739 Muenchen, Germany
Mobile: +49 173 3746683
mailto:quirin.gylstorff@siemens.com
www.siemens.com/ingenuityforlife

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim 
Hagemann Snabe; Managing Board: Joe Kaeser, Chairman, President and 
Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, 
Cedrik Neike, Michael Sen, Ralf P. Thomas; Registered offices: Berlin 
and Munich, Germany; Commercial registries: Berlin Charlottenburg, HRB 
12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322

Important notice: This e-mail and any attachment thereof contain 
corporate proprietary information. If you have received it by mistake, 
please notify us immediately by reply e-mail and delete this e-mail and 
its attachments from your system. Thank you.


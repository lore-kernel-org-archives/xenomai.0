Subject: Re: [xenomai-images][PATCH 0/9] LAVA Setup
References: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
 <1d91b2ba-6ca6-c760-bef0-7f484f9e4fd9@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Message-ID: <8264be7f-5b01-efc9-43ce-2979a9fe02d8@siemens.com>
Date: Fri, 6 Sep 2019 16:08:34 +0200
MIME-Version: 1.0
In-Reply-To: <1d91b2ba-6ca6-c760-bef0-7f484f9e4fd9@siemens.com>
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



On 9/6/19 12:29 PM, Jan Kiszka wrote:
> On 05.09.19 17:44, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This patchset adapts xenomai-images for the execution of tests
>> on  Linaro Automated Validation Architecture.
>>
> 
> Could you provide a rough overview oaf the architecture behind this? 
> Where we are already, what more will be coming? Specifically as the 
> community does not know what we discussed already.

I posted the rough architecture as PATCH 10/9.
Next steps are:
- adding a arm64 hardware target
- documentation how to setup a own lab with lava-docker
- discussion for a public LAVA master
- split the test and deployment from the build step in .gitlab-ci
- Add a own repository for the test description instead using 
inline-testcase

Quirin

> 
> Thanks,
> Jan
> 


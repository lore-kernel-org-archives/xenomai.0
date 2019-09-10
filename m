Subject: Re: [xenomai-images][PATCH 1/9] ci: Add LAVA jobs for targets
References: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
 <20190905154425.10007-2-Quirin.Gylstorff@siemens.com>
 <c04ece77-0937-a01f-a1c2-c9dd73f84c62@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Message-ID: <83d112c0-1fe9-370e-bcf2-954059f3beb4@siemens.com>
Date: Tue, 10 Sep 2019 12:17:31 +0200
MIME-Version: 1.0
In-Reply-To: <c04ece77-0937-a01f-a1c2-c9dd73f84c62@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org



On 9/10/19 11:56 AM, Jan Kiszka wrote:
> On 05.09.19 17:44, Q. Gylstorff via Xenomai wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Set up a LAVA Lab and add jobs for each target. These job descriptions
>> deploy the build image to the target and run the LAVA basic smoketest
>> suite for each target. Add lsb-release for smoke-test
>>
> 
> If someone wants to reuse CI but does not have a LAVA instance: Could we 
> easily make the deployment and test step depend on, say, the LAVA 
> environment variables being non-empty?

I will look into it. It would work with [1]. But that feature is alpha 
according to gitlab-ci[2]. It would also be part of the split the test 
and deployment from the build step in .gitlab-ci I mentioned in the outlook.

[1]: https://docs.gitlab.com/ee/ci/yaml/#onlyvariablesexceptvariables
[2]: https://docs.gitlab.com/ee/ci/yaml/#onlyexcept-advanced

Quirin
> 
> Jan
> 


Subject: Re: [PATCH v2 0/1] Add gitlab-ci to Xenomai
References: <20200904103248.31899-1-Quirin.Gylstorff@siemens.com>
 <4f7b2d8f-70e1-9a56-3dae-c84fa433c478@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Message-ID: <9e2264eb-88d5-e5b7-ff2b-d4d6567c19fb@siemens.com>
Date: Wed, 9 Sep 2020 12:00:34 +0200
MIME-Version: 1.0
In-Reply-To: <4f7b2d8f-70e1-9a56-3dae-c84fa433c478@siemens.com>
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



On 9/4/20 12:37 PM, Jan Kiszka wrote:
> On 04.09.20 12:32, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>>
>> This patch adds a gitlab-ci.yml to support ci builds on gitlab. The
>> build is derived from .travis.yml.
>>
>> An executed pipeline can be found at [1].
>>
>> Changes V2:
>>   - adapt git remote ls syntax to git version 2.20 from 2.17
>>
>> I also look into using the same base for .travis-ci.yml and gitlab-ci.yml.
>> What we can do is moving the script and before_script parts into a
>> shell script or something similar. The job description syntax is
>> not compatible (env instead variables, jobs are under the element
>> jobs/matrix instead of root). IMHO we need some generator to
>> use the same job description for Travis and gitlab-ci.
>>
>> [1]: https://gitlab.com/Quirin.Gy/xenomai/-/pipelines/185711450
>>
> 
> Then go for plan B: Test gitlab-ci for a while, and if it works, drop
> travis.
> 
> Is this job also compatible with the free runners on gitlab.com?

Yeah the Job is compatible the link I sent was executed on the free
runners.
Quirin
> 
> Jan
> 


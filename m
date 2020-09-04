Subject: Re: [PATCH v2 0/1] Add gitlab-ci to Xenomai
References: <20200904103248.31899-1-Quirin.Gylstorff@siemens.com>
 <4f7b2d8f-70e1-9a56-3dae-c84fa433c478@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c81c52ec-75cf-3fb8-870e-9cec852a0c20@siemens.com>
Date: Fri, 4 Sep 2020 13:23:50 +0200
MIME-Version: 1.0
In-Reply-To: <4f7b2d8f-70e1-9a56-3dae-c84fa433c478@siemens.com>
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
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 04.09.20 12:37, Jan Kiszka via Xenomai wrote:
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
>>  - adapt git remote ls syntax to git version 2.20 from 2.17
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
> 

Building is fine,
https://gitlab.denx.de/Xenomai/xenomai/-/pipelines/4581, but I suppose
we lost the ccache, right? Can this be restored with gitlab means? Would
be up to 400MB to save/restore per job, practically more between 200 and
250 MB.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


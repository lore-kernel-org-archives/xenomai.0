Message-ID: <f1820385-31df-7e26-fa33-201b298e22b9@siemens.com>
Date: Thu, 3 Mar 2022 07:39:25 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] Add --with-kernelshark option
Content-Language: en-US
References: <20220302025721.9354-1-hongzhan.chen@intel.com>
 <20220302025721.9354-2-hongzhan.chen@intel.com>
 <6e6af75b-dc2e-ca94-3fba-d5c3785edf7e@siemens.com>
 <MN2PR11MB428578EBDC156D45F80AC814F2049@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB428578EBDC156D45F80AC814F2049@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03.03.22 07:30, Chen, Hongzhan wrote:
> 
> 
> 
>>> +	tracing/Makefile \
>>> +	tracing/kernelshark/Makefile \
>>>  	lib/Makefile \
>>>  	lib/boilerplate/Makefile \
>>>  	lib/boilerplate/init/Makefile \
>>> diff --git a/tracing/Makefile.am b/tracing/Makefile.am
>>> index 8bdf1f906..7925ae9c6 100644
>>> --- a/tracing/Makefile.am
>>> +++ b/tracing/Makefile.am
>>> @@ -1,6 +1,7 @@
>>> -
>>> +if BUILD_KERNELSHARK
>>>  SUBDIRS =		\
>>>  	kernelshark
>>> +endif
>>>  
>>>  DIST_SUBDIRS = 		\
>>>  	kernelshark
>>
>> Seems you lost the AC_PROG_CXX - things do not build now.
> 
> Sorry, I assumed that patch [1] pass review , so I have not committed again to review.
> Could you apply this patch?
> 
> https://xenomai.org/pipermail/xenomai/2022-February/047262.html
> 

When sending v4 after my review remarks, please include all patches.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


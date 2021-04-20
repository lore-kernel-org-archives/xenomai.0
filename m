Subject: Re: [PATCH V2 3/3] testsuite/latmus: introduce latmus benchmark
References: <20210416053133.23412-1-hongzhan.chen@intel.com>
 <20210416053133.23412-4-hongzhan.chen@intel.com>
 <17adb9ac-7510-f1f6-9805-67ef8353b536@siemens.com>
 <DM5PR11MB1852339EA17CEADCE2D3DB25F2489@DM5PR11MB1852.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <da74b515-3982-1827-8b77-2ec3977aecea@siemens.com>
Date: Tue, 20 Apr 2021 08:47:40 +0200
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB1852339EA17CEADCE2D3DB25F2489@DM5PR11MB1852.namprd11.prod.outlook.com>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 20.04.21 03:02, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>> Sent: Friday, April 16, 2021 8:05 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>> Subject: Re: [PATCH V2 3/3] testsuite/latmus: introduce latmus benchmark
>>
>> On 16.04.21 07:31, hongzha1 via Xenomai wrote:
>>> Measure response time to GPIO events sent by a remote Zephyr-based
>>> latency monitor (latmon). This monitor collects then sends the latency
>>> data over a network connection to the latmus front-end which displays
>>> the results received:
>>>
>>> [Linux device under test running latmus]  <--+
>>>                                              |
>>>         ^                 | (GPIO ack)       |
>>>         |                 |                  |  TCP/IP network connection
>>>         |                 |                  |  (control & data samples)
>>>         | (GPIO pulse)    v                  |
>>>                                              |
>>> [Zephyr-based device running latmon]      <--+
>>>
>>> The generic latency monitor code running the measurement loop is
>>> available from the zephyr/ directory. This support comes with a Zephyr
>>> device tree patch for enabling this monitor on NXP's FRDM-K64F
>>> development board.
>>
>> Where is all this?
> 
> Actually , this zephyr directory is located in libevl project  at https://git.evlproject.org/libevl.git/tree/benchmarks/zephyr.  
> at this time. Do you think it is suitable to make a copy for this folder in xenomai code base? Or I just described in comments
> that it is from https://git.evlproject.org/libevl.git/tree/benchmarks/zephyr .
> 

It's fine to link that. But, again, this needs to go into proper in-tree
documentation.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


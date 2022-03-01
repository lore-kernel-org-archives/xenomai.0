Message-ID: <4a764fcf-c836-5a52-4d62-4cefea9daf18@siemens.com>
Date: Tue, 1 Mar 2022 09:31:05 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] libtraceevent: Add Add xenomai_schedparams plugin for
 libtraceevent
Content-Language: en-US
References: <20220228054055.16112-1-hongzhan.chen@intel.com>
 <20220228054055.16112-5-hongzhan.chen@intel.com>
 <ec0d4873-ffbe-e679-4f1e-18ed862fcdb5@siemens.com>
 <MN2PR11MB4285EF04221BF6CB43A5B212F2029@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB4285EF04221BF6CB43A5B212F2029@MN2PR11MB4285.namprd11.prod.outlook.com>
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

On 01.03.22 09:21, Chen, Hongzhan wrote:
> 
>>
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>> Sent: Tuesday, March 1, 2022 3:41 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>> Subject: Re: [PATCH 4/4] libtraceevent: Add Add xenomai_schedparams plugin for libtraceevent
>>
>> On 28.02.22 06:40, Hongzhan Chen wrote:
>>> For cobalt thread, there is special struct param_ex data stored in
>>> data record, we need to parse and print its content out correctly
>>> to hint user when using libtraceevent.
>>>
>>
>> While libtraceevent can be used along with KernelShark, it's not bound
>> to it. You can also perfectly use it with pure command line tooling
>> (trace-cmd). That would make it interesting for your UI-free demo images
>> (xenomai-images). So I would recommand controlling its build
>> independently of KernelShark.
>>
>>> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>>> ---
>>>  configure.ac                                  |   1 +
>>>  kernel-shark/Makefile.am                      |   6 +-
>>
>> Maybe call the top-level directory "tracing" instead.
> 
> It was supposed that the building of all plugins is controlled by one option --with-kernelshark in my case. As you suggested ,does that means we need to add one more option like --with-libtraceevent to build libtraceevent standalone independent from building kernelshark plugin. Or we replace --with-kernelshark with- -with-tracing to build all plugins under tracing folder with sole option?
> 

Yes, --with-libtraceevent, and then maybe make --with-kernelshark imply
the former if it depends on it technically.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


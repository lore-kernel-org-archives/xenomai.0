Message-ID: <e99b76a3-cf44-6fdd-1e63-63c6e60b0171@siemens.com>
Date: Tue, 25 Jan 2022 21:26:39 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] cobalt: Fix pid issues when running in child pid namespace
Content-Language: en-US
References: <20220119133154.4122157-1-qiang1.zhang@intel.com>
 <fb9acdbd-3a9b-ca15-c255-d85f0595078c@siemens.com>
 <PH0PR11MB5880EA9644EDFB9F558C0C80DA5F9@PH0PR11MB5880.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PH0PR11MB5880EA9644EDFB9F558C0C80DA5F9@PH0PR11MB5880.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Zhang, Qiang1" <qiang1.zhang@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, MONTET Julien <julien.montet@reseau.eseo.fr>

On 25.01.22 09:25, Zhang, Qiang1 wrote:
> 
> On 19.01.22 14:31, Zqiang wrote:
>> The Xenomai does not yet support the concept of namespaces, and the
>> same task has different pids in its own pid namespace and parent pid
>> namespace. however, when the task running in a child pid namespace, we
>> only recorded the relationship between thread and child pid. so can't
>> use other pid to find thread.
>>
>> To fix it, when the thread is created, record all pid in different
>> namespaces.
>>
>> Updates: https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/19
>>
> 
>>> Can you help refreshing my memory on that and also explain why it takes a different approach than in [1]? That was reported to not work completely either, yes, but the RCU limitation is now gone with everything switched to Dovetail.
>>>
> 
> Hi Jan
> 
> This change doesn't depend on RCU, it apply to I-pipe and dovetail.
> When switched to Dovetail, the RCU limitation is gone?
> 

Dovetail allows to use RCU-protected read accesses from the out-of-band 
(RT) stage, at least in 5.15:

https://source.denx.de/Xenomai/linux-dovetail/-/commit/49cad34e9c2d977a8069278393de922d40ec5d57

Looking at 5.10, there might be remaining restrictions, though possibly 
resolvable by backporting the above:

https://source.denx.de/Xenomai/linux-dovetail/-/commit/f989126cca9a305a101e6ddf60a60ef062d1e7f4

As current master has dropped I-pipe support and this patch will likely 
not be a backport candiate anyway, we may exploit this property and may 
make the pid namespace solution simpler this way.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


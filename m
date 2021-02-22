References: <20210220055311.23826-1-hongzhan.chen@intel.com>
 <6030D8D3.9030108@kylinos.cn>
 <MWHPR11MB1710251FD215D5D9CDB2D641F2819@MWHPR11MB1710.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 1/5] cobalt/rtdm: add new interface to init task on
 specified cpu
In-reply-to: <MWHPR11MB1710251FD215D5D9CDB2D641F2819@MWHPR11MB1710.namprd11.prod.outlook.com>
Date: Mon, 22 Feb 2021 10:16:02 +0100
Message-ID: <87r1l831kd.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: chensong <chensong@kylinos.cn>, xenomai@xenomai.org


Chen, Hongzhan via Xenomai <xenomai@xenomai.org> writes:

>>-----Original Message-----
>>From: chensong <chensong@kylinos.cn> 
>>Sent: Saturday, February 20, 2021 5:40 PM
>>To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>>Subject: Re: [PATCH 1/5] cobalt/rtdm: add new interface to init task on specified cpu
>>
>>why do we need a new interface instead of adding a new parameter(cpu) in 
>>old interface, in this case rtdm_task_init.
>>
>>For backward compatibility?
>
> We discussed it about introducing rtdm_task_init_on_cpu in [1]. Actually most of contents of
> rtdm_task_init_on_cpu is really same with rtdm_task_init except cpu affinity. But rtdm_task_init 
> was already called by several drivers such as net and testing. If we modify definition of 
> rtdm_task_init , we have to modify all of these drivers that calling rtdm_task_init. 
>
> [1]: https://xenomai.org/pipermail/xenomai/2021-February/044250.html

Agreed. Not to speak of the custom drivers in the field, which would
break at build due to a new prototype of rtdm_task_init().

Besides, adding such a variant matches the mainline kernel naming scheme
(kthread_create vs kthread_create_on_node vs
kthread_create_on_cpu).

-- 
Philippe.


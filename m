References: <eac52e41-5114-8535-1a7a-58d6927a7743@xenomai.org>
 <dee5845e-45a9-6837-24b5-61a2ff8cf74d@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d1736bc4-94a7-648e-6c9a-4d8d7a9730a0@xenomai.org>
Date: Mon, 1 Aug 2016 15:51:47 +0200
MIME-Version: 1.0
In-Reply-To: <dee5845e-45a9-6837-24b5-61a2ff8cf74d@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] Switchless RTDM calls from SCHED_WEAK threads
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 08/01/2016 03:31 PM, Jan Kiszka wrote:
> On 2016-07-10 11:47, Philippe Gerum wrote:
>> 3- We could introduce a special tag for composing the RTIOC code of an
>>   ioctl request, that a driver would use to state the preference for
>>   running the request in relaxed mode. The existing adaptative switch
>>   (ENOSYS) would still be available for handling requests for which no
>>   preference has been defined.
>>
>>   e.g.
>>
>>   #define _IOC_RELAX			15U
>>   #define _IOWRX(type, nr, size)	_IOWR(type, nr | (1U << _IOC_RELAX), size)
>>
>>   #define SOMEDEV_RTIOC_FOO		_IOWRX(RTDM_CLASS_BAR, 10, &some_arg)
>>
>>   Pros: Semantics is easy to grasp: the decision about the best mode
>>   to run any given request is left to the driver. It also implies the
>>   best practice of assigning an exclusive handler to each ioctl
>>   request, i.e. either _rt or _nrt, but not both.
>>
>>   Cons: Breaks the ABI, by consuming a bit normally used to encode the
>>   ioctl number for the tag, restricting the namespace to 2^15 codes.
>>   Would not enable the mechanism for other RTDM I/O calls such as
>>   read/write(_nrt).
> 
> If option 3 helps to get this feature upstream, and we can drop related
> patches here, we could live with it.
> 

Ok, I believe this is a reasonable approach, since it keeps the driver
in charge of picking the right mode for the requests it implements. I'll
come back with a draft implementation.

-- 
Philippe.


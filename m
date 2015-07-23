References: <55AE3AAB.5070403@siemens.com> <55AE4068.5050102@xenomai.org>
 <55AE5D0B.60300@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55B0A89B.5020004@xenomai.org>
Date: Thu, 23 Jul 2015 10:40:59 +0200
MIME-Version: 1.0
In-Reply-To: <55AE5D0B.60300@siemens.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3: comapt issues with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 07/21/2015 04:54 PM, Jan Kiszka wrote:
> On 2015-07-21 14:51, Philippe Gerum wrote:
>> On 07/21/2015 02:27 PM, Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> just a heads up, I'll try to address this later:
>>>
>>> I received a report that include/rtdm/uapi/rtdm.h contains some data
>>> structures that are used between the kernel and the userspace library
>>> (so not directly by applications) and are not compatible with
>>> 32-on-64-bit (compat) scenarios. We should probably promote anything
>>> that is longer on 64-bit to that size, unconditionally. As this affects
>>> the ABI, it should be fixed before 3.0 release, ideally.
>>>
>>
>> That would require to fix up the client drivers (setsockopt, getsockopt
>> typically). Ok, I'll have a look when I'm done with testing the blackfin
>> port.
> 
> Indeed. Just realized that there are already compat structs for the
> socket stuff. However, and that was what our user stumbled over, there
> is none for _rtdm_mmap_request. But that should be really internal, right?
> 

mmap() has the compat thunk for 32<->64 bit conversion already, so this
is ok.

-- 
Philippe.


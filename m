Subject: Re: kernel BUG at kernel/auditsc.c:1527!
References: <20210310224629.fd6qttrnxock7gwc@altlinux.org>
 <e55dba39-4d3e-b396-5396-7302ce8ecc18@siemens.com>
 <69da21a9-3fcd-0041-fe0e-b930e32a3a21@siemens.com>
 <20210312024903.iff5tr5lgrf43bzm@altlinux.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <136275a9-6221-0e3a-0c1c-eb89c148dc68@siemens.com>
Date: Fri, 12 Mar 2021 08:19:30 +0100
MIME-Version: 1.0
In-Reply-To: <20210312024903.iff5tr5lgrf43bzm@altlinux.org>
Content-Type: text/plain; charset=koi8-r
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
To: Vitaly Chikunov <vt@altlinux.org>
Cc: Xenomai <xenomai@xenomai.org>

On 12.03.21 03:49, Vitaly Chikunov wrote:
> Jan,
> 
> On Thu, Mar 11, 2021 at 04:10:03PM +0100, Jan Kiszka wrote:
>> On 11.03.21 12:49, Jan Kiszka via Xenomai wrote:
>>> On 10.03.21 23:46, Vitaly Chikunov via Xenomai wrote:
>>>> On Mon, Mar 08, 2021 at 07:12:26AM +0100, xenomai--- via Xenomai wrote:
>>>>> Release tag: ipipe-core-4.19.177-cip44-x86-16
>>>>
>>>> This is not appeared first on this release, but (this release too)
>>>> crashes when boot on x86_64 with audit enabled (audit=1, which is
>>>> default).
>>>>
>>>> Boot console log:
>>>>
>>
>> Seems like something of the error/warning is missing here.
> 
> I will attach full boot log.

Thanks, will have a look.

> 
>>> Can you share your kernel config?
>>>
>>
>> Still no luck, also with the config you sent off-list.
> 
> I thought mailing list would not pass attachment and there is no
> bugzilla to attach files.

We are moving our closed tracker to
https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues - didn't
announce yet, though.

> 
>>
>> Is there any specific service involved? But I do have auditd running
>> here as well. auditctl -s reports "enabled". Or do I need a specific
>> configuration of it to trigger this? A specific kernel command line?
> 
> If you wish, you can extract built kernel from RPM with rpm2cpio and
> try boot on your system:
>   http://git.altlinux.org/tasks/267579/build/100/x86_64/rpms/kernel-image-xenomai-4.19.177-alt1.cip44.16.x86_64.rpm
> (Maybe it's hardware dependent?)
> 

Will check that as well, just to exclude the hardware (I'm reproducing
in QEMU). However, I will likely need more (debug symbols, gdb scripts)
to debug that.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


References: <20160114183423.69665622@md1em3qc> <5698AEA6.6030906@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5698E750.6050508@siemens.com>
Date: Fri, 15 Jan 2016 13:34:24 +0100
MIME-Version: 1.0
In-Reply-To: <5698AEA6.6030906@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe x86_64 huge page ioremap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Henning Schild <henning.schild@siemens.com>, Xenomai@xenomai.org
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

On 2016-01-15 09:32, Philippe Gerum wrote:
> On 01/14/2016 06:34 PM, Henning Schild wrote:
>> Hey,
>>
>> the 4.1 kernel supports mapping IO memory using huge pages.
>> 0f616be120c632c818faaea9adcb8f05a7a8601f ..
>> 6b6378355b925050eb6fa966742d8c2d65ff0d83
>>
>> In ipipe memory that gets ioremapped will get pinned using
>> __ipipe_pin_mapping_globally, however in the x86_64 case that function
>> uses vmalloc_sync_one which must only be used on 4k pages.
>>
>> We found the problem when using the kernel in a VBox VM, where the
>> paravirtualized PCI device has enough iomem to cause huge page
>> mappings. When loading the device driver you will get a BUG caused by
>> __ipipe_pin_mapping_globally.
>>
>> I will work on a fix for the problem. But i would also like to
>> understand the initial purpose of the pinning. Is it even supposed to
>> work for io memory as well? It looks like a way to commit address space
>> changes right down into the page tables, to avoid page-faults in the
>> kernel address space. Probably for more predictable timing ...
>>
> 
> This is for pinning the page table entries referencing kernel mappings,
> so that we don't get minor faults when treading over kernel memory,
> unless the fault fixup code is compatible with primary domain execution,
> and cheaper than tracking the pgds.

I suppose a critical scenario would already be a real-time driver that
accesses io regions in its interrupt handler or in the context of some
real-time task.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux


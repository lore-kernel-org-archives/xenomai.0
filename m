Message-ID: <8da4350a-afa5-8482-4755-d3b8e0024add@siemens.com>
Date: Mon, 3 Jan 2022 07:28:14 +0100
MIME-Version: 1.0
Subject: Re: v5.15-dovetail-rebase compilation fails
Content-Language: en-US
References: <1478129695.36513090.1640631058240.JavaMail.zimbra@telenet.be>
 <97759673-71e3-fc0c-804c-aadeaa8de4ae@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <97759673-71e3-fc0c-804c-aadeaa8de4ae@siemens.com>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>, g.strobbe@telenet.be, xenomai <xenomai@xenomai.org>

On 28.12.21 09:50, Florian Bezdeka wrote:
> On 27.12.21 19:50, G.Strobbe via Xenomai wrote:
>> Hi all,
>>
>> The compilation of file xenomai/kernel/cobalt/debug.c 
>> in branch v5.15-dovetail-rebase failed.
>> The problem is that since kernel vanilla v15.5 
>> include/linux/mm.h no longer defines VM_DENYWRITE
>>
>> It is still used in xndebug_trace_relax()
>>
>> 		/*
>> 		 * Hack. Unlike DSOs, executables and interpreters
>> 		 * (e.g. dynamic linkers) are protected against write
>> 		 * attempts. Use this to determine when $pc should be
>> 		 * fixed up by subtracting the mapping base address in
>> 		 * the DSO case.
>> 		 */
>> 		if (!(vma->vm_flags & VM_DENYWRITE))
>> 			pc -= vma->vm_start;
> 
> Thanks for reporting that. Adding Jan and Philippe to CC, seems the 
> "migration" to 5.15 is not fully done yet.
> 
> As a temporary workaround you could set CONFIG_XENO_OPT_DEBUG (or more
> specific CONFIG_XENO_OPT_DEBUG_TRACE_RELAX) to "n" in your kernel 
> configuration.
> 
> For Jan and Philippe:
> 
> The following commits might be relevant:
> fe69d560b5bd ("kernel/fork: always deny write access to current MM exe_file")
> 8d0920bde5eb ("mm: remove VM_DENYWRITE")
> 592ca09be833 ("fs: update documentation of get_write_access() and friends")
> 
> While looking at 592ca09be833 I wonder if we would have to migrate
> to something like inode_is_open_for_write(). Any comments / ideas?
> 

I'm still waiting for a second opinion on
https://xenomai.org/pipermail/xenomai/2021-October/046646.html.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


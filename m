Message-ID: <97759673-71e3-fc0c-804c-aadeaa8de4ae@siemens.com>
Date: Tue, 28 Dec 2021 09:50:01 +0100
Subject: Re: v5.15-dovetail-rebase compilation fails
Content-Language: en-US
References: <1478129695.36513090.1640631058240.JavaMail.zimbra@telenet.be>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <1478129695.36513090.1640631058240.JavaMail.zimbra@telenet.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: g.strobbe@telenet.be, xenomai <xenomai@xenomai.org>

On 27.12.21 19:50, G.Strobbe via Xenomai wrote:
> Hi all,
> 
> The compilation of file xenomai/kernel/cobalt/debug.c 
> in branch v5.15-dovetail-rebase failed.
> The problem is that since kernel vanilla v15.5 
> include/linux/mm.h no longer defines VM_DENYWRITE
> 
> It is still used in xndebug_trace_relax()
> 
> 		/*
> 		 * Hack. Unlike DSOs, executables and interpreters
> 		 * (e.g. dynamic linkers) are protected against write
> 		 * attempts. Use this to determine when $pc should be
> 		 * fixed up by subtracting the mapping base address in
> 		 * the DSO case.
> 		 */
> 		if (!(vma->vm_flags & VM_DENYWRITE))
> 			pc -= vma->vm_start;

Thanks for reporting that. Adding Jan and Philippe to CC, seems the 
"migration" to 5.15 is not fully done yet.

As a temporary workaround you could set CONFIG_XENO_OPT_DEBUG (or more
specific CONFIG_XENO_OPT_DEBUG_TRACE_RELAX) to "n" in your kernel 
configuration.

For Jan and Philippe:

The following commits might be relevant:
fe69d560b5bd ("kernel/fork: always deny write access to current MM exe_file")
8d0920bde5eb ("mm: remove VM_DENYWRITE")
592ca09be833 ("fs: update documentation of get_write_access() and friends")

While looking at 592ca09be833 I wonder if we would have to migrate
to something like inode_is_open_for_write(). Any comments / ideas?

HTH, 
Florian

> 
> Best regards,
> 
> Gino 
> 			
> 



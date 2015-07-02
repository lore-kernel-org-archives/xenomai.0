References: <E1ZAgI1-0000jO-Kb@sd-51317.xenomai.org>
 <559557C2.3040004@xenomai.org> <55955B45.5000201@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55956729.9010901@xenomai.org>
Date: Thu, 2 Jul 2015 18:30:33 +0200
MIME-Version: 1.0
In-Reply-To: <55955B45.5000201@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Remove
 unused mode parameter from COBALT_SYSCALL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 07/02/2015 05:39 PM, Jan Kiszka wrote:
> On 2015-07-02 17:24, Philippe Gerum wrote:
>> On 07/02/2015 05:20 PM, git repository hosting wrote:
>>> Module: xenomai-jki
>>> Branch: for-forge
>>> Commit: 99736c29a21a5e5536f8db9e580fd11cdb0eb0f2
>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=99736c29a21a5e5536f8db9e580fd11cdb0eb0f2
>>>
>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>>> Date:   Thu Jul  2 17:12:39 2015 +0200
>>>
>>> cobalt/kernel: Remove unused mode parameter from COBALT_SYSCALL
>>
>> We want to keep this. At some point, maybe, we will be able to use this
>> information to instrument the code with calling context guards, or as
>> the source of the mode data in the syscall table. Today, it's at least
>> useful inline documentation, without having to browse the table.
> 
> This only makes sense when cobalt_sysmodes can be generated from it.
> Currently it isn't, and I bet there are already plenty of
> inconsistencies, minimizing the value captured via COBALT_SYSCALL
> massively. So we should either get rid of cobalt_sysmodes or of that
> parameter.
> 

"currently" is the point. If you feel implementing either aspects, i.e.
automatic tagging of the current context when traversing a cobalt call
based on the mode in the syscall macro, or generating the table data
based on the info, please do. If you feel fixing any consistency between
the two mode specs proving your bet right, please do as well. But for
now, I won't pick that commit.


-- 
Philippe.


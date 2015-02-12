Message-ID: <54DCDC98.5070402@siemens.com>
Date: Thu, 12 Feb 2015 18:02:16 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <5491B5E9.4030200@siemens.com> <5491C2CA.7000906@xenomai.org>
 <5491C179.2000600@siemens.com> <5491CB3F.2050509@xenomai.org>
 <5491CC27.6080909@siemens.com> <5491D196.3040309@xenomai.org>
 <54D0E961.4060705@xenomai.org> <54DCD68F.5020005@siemens.com>
In-Reply-To: <54DCD68F.5020005@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mayday mechanism broken on x86-64 - simpler approach
 feasible?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2015-02-12 17:36, Jan Kiszka wrote:
>> As I mentioned earlier, I'd rather fix the MAYDAY implementation for
>> x86_64 instead of forking the implementation between MMU-enabled and
>> MMU-less architectures, also affecting powerpc, arm and x86_32 in the
>> same move. Fortunately, the current implementation allows very specific
>> tweaks to be applied on a per-architecture basis. This one fixes the
>> issue for Cobalt on x86_64, and could be easily backported to 2.6.x:
>>
>> http://git.xenomai.org/xenomai-3.git/commit/?h=next&id=6db20901963d634b9786467c711c2ba526db48a2
> 
> Looks almost good - except for the detail that some bits of the
> instruction pointer are lost on return from the syscall (int vs. long
> return type). Patches in the making.

Will take longer - I need to convert all cobalt syscalls.

We have a sleeping bug there, though likely not seen in practice, with
syscalls returning values > INT_MAX (size_t...). The problem is that
handle_head/root_syscall only forwarded 32-bits so far.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux


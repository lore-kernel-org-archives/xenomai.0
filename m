Message-ID: <559591E5.5060106@siemens.com>
Date: Thu, 02 Jul 2015 21:32:53 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <55956729.9010901@xenomai.org> <55956A56.3050806@siemens.com>
 <20150702164933.GR13256@hermes.click-hack.org>
 <20150702165642.GS13256@hermes.click-hack.org> <5595757A.60301@siemens.com>
 <20150702173508.GU13256@hermes.click-hack.org>
 <20150702175526.GV13256@hermes.click-hack.org> <55957B86.7020009@siemens.com>
 <20150702184232.GX13256@hermes.click-hack.org> <559587A0.7020005@siemens.com>
 <20150702185525.GY13256@hermes.click-hack.org>
In-Reply-To: <20150702185525.GY13256@hermes.click-hack.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2015-07-02 20:55, Gilles Chanteperdrix wrote:
> On Thu, Jul 02, 2015 at 08:49:04PM +0200, Jan Kiszka wrote:
>> On 2015-07-02 20:42, Gilles Chanteperdrix wrote:
>>> On Thu, Jul 02, 2015 at 07:57:26PM +0200, Jan Kiszka wrote:
>>>> On 2015-07-02 19:55, Gilles Chanteperdrix wrote:
>>>>> On Thu, Jul 02, 2015 at 07:35:08PM +0200, Gilles Chanteperdrix wrote:
>>>>>> On Thu, Jul 02, 2015 at 07:31:38PM +0200, Jan Kiszka wrote:
>>>>>>> On 2015-07-02 18:56, Gilles Chanteperdrix wrote:
>>>>>>>> On Thu, Jul 02, 2015 at 06:49:33PM +0200, Gilles Chanteperdrix wrote:
>>>>>>>>> On Thu, Jul 02, 2015 at 06:44:06PM +0200, Jan Kiszka wrote:
>>>>>>>>>> On 2015-07-02 18:30, Philippe Gerum wrote:
>>>>>>>>>>> On 07/02/2015 05:39 PM, Jan Kiszka wrote:
>>>>>>>>>>>> On 2015-07-02 17:24, Philippe Gerum wrote:
>>>>>>>>>>>>> On 07/02/2015 05:20 PM, git repository hosting wrote:
>>>>>>>>>>>>>> Module: xenomai-jki
>>>>>>>>>>>>>> Branch: for-forge
>>>>>>>>>>>>>> Commit: 99736c29a21a5e5536f8db9e580fd11cdb0eb0f2
>>>>>>>>>>>>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=99736c29a21a5e5536f8db9e580fd11cdb0eb0f2
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>>>>>> Date:   Thu Jul  2 17:12:39 2015 +0200
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> cobalt/kernel: Remove unused mode parameter from COBALT_SYSCALL
>>>>>>>>>>>>>
>>>>>>>>>>>>> We want to keep this. At some point, maybe, we will be able to use this
>>>>>>>>>>>>> information to instrument the code with calling context guards, or as
>>>>>>>>>>>>> the source of the mode data in the syscall table. Today, it's at least
>>>>>>>>>>>>> useful inline documentation, without having to browse the table.
>>>>>>>>>>>>
>>>>>>>>>>>> This only makes sense when cobalt_sysmodes can be generated from it.
>>>>>>>>>>>> Currently it isn't, and I bet there are already plenty of
>>>>>>>>>>>> inconsistencies, minimizing the value captured via COBALT_SYSCALL
>>>>>>>>>>>> massively. So we should either get rid of cobalt_sysmodes or of that
>>>>>>>>>>>> parameter.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> "currently" is the point. If you feel implementing either aspects, i.e.
>>>>>>>>>>> automatic tagging of the current context when traversing a cobalt call
>>>>>>>>>>> based on the mode in the syscall macro, or generating the table data
>>>>>>>>>>> based on the info, please do. If you feel fixing any consistency between
>>>>>>>>>>> the two mode specs proving your bet right, please do as well. But for
>>>>>>>>>>> now, I won't pick that commit.
>>>>>>>>>>
>>>>>>>>>> The approach of using COBALT_SYSCALL to define the mode only works if
>>>>>>>>>> that is also the only place to define it. Let's see first if/how that
>>>>>>>>>> can be achieved.
>>>>>>>>>
>>>>>>>>> That can be achieved by getting the macro to adding data in a
>>>>>>>>> special section, then use that section as the syscall table with
>>>>>>>>
>>>>>>>> Use that section to build the syscall table. Or sort it. The section
>>>>>>>> can not be used directoy, the syscalls are not in the right order.
>>>>>>>
>>>>>>> What would be the key for sorting? Semantically the syscall number, but
>>>>>>> how to translate that into a key (i.e. a symbol name) that the linker
>>>>>>> could sort properly?
>>>>>>>
>>>>>>> As far as I can see for x86, the kernel uses a host script to generate
>>>>>>> the syscall table which is defined arch/x86/syscalls/syscall_*.tbl -
>>>>>>> presorted. That step also generates the #defines for the syscall numbers.
>>>>>>
>>>>>> Yes, we probably need to add the syscall number to the
>>>>>> COBALT_SYSCALL macro. Or build it from the function name. A second
>>>>>> possibility is to keep the current table, but do not fill the flag
>>>>>> field, and use the information in the section to find back each
>>>>>> syscall and fill the blanks.
>>>>>
>>>>> Yet another possibility is to run a script on the sources, which
>>>>> generates the table as .c code. The script would simply handle the
>>>>> calls to the COBALT_SYSCALL macro. This can be done with sed or awk
>>>>> even. And this does not require playing with the linker script.
>>>>
>>>> I more and more believe that is actually only feasible approach. The
>>>> linker tricks seem to fail because we cannot prepare the required input
>>>> as needed. If they worked, the kernel would surely use one of them.
>>>
>>> Actually the awk script is astonishingly simple.
>>>
>>> find kernel/cobalt -name '*.c' | xargs cat | awk -f foo.awk
>>>
>>> With foo.awk
>>>
>>> match($0, /COBALT_SYSCALL\([^,]*, [^,]*/)  {
>>> 	str=substr($0, RSTART + 15, RLENGTH - 15)
>>> 	match(str, /[^,]*/)
>>> 	syscall=substr(str, RSTART, RLENGTH)
>>> 	seen[syscall]=1;
>>> 	print "__COBALT_MODE(" str "),"
>>> }
>>>
>>> match($0, /__COBALT_CALL_ENTRY\([^)]*/)  {
>>> 	syscall=substr($0, RSTART + 20, RLENGTH - 20)
>>> 	intable[syscall]=1
>>> }
>>>
>>> END {
>>> 	for (s in intable)  {
>>> 		if (s != "" && s != "__name" && !seen[s])
>>> 			print "missed syscall \"" s "\" implementation!"
>>> 	}
>>> }
>>
>> Ah, good that you have the right awk foo. I'll give this a try.
> 
> Ok, the script issues a list of __COBALT_MODE statements which
> replaces the contents of the cobalt_sysmodes table. You probably want
> to exit 1 when we missed a COBALT_SYSCALL declaration. We could just
> as easily generate the contents of the cobalt_syscalls table, but in
> that case, if the script misses a COBALT_SYSCALL declaration, we
> have no way of knowing.

Well, if posix/*.c would be fine already for the search space, that's
working now.

> 
>>
>>>
>>> The problem will be to re-run the script when a new syscall is added
>>> or a file is modified.
>>
>> That should be simple. Working on the Makefile bits...
> 
> Actually, the only way I see is to regenerate the table at every
> compilation.

Two options:
- Let the generation depend on all relevant input files, then it will
  only be updated on changes, but possibly even of files that do not
  include syscalls.
- Build the table on every run, but check if the result changed. Only
  then update the file that will be included for builds.

Maybe one can combine both, haven't tried yet. Currently working with
the first option.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux


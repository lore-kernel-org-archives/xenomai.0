Date: Fri, 17 Jul 2015 00:34:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150716223406.GB16778@hermes.click-hack.org>
References: <20150702184232.GX13256@hermes.click-hack.org>
 <559587A0.7020005@siemens.com>
 <20150702185525.GY13256@hermes.click-hack.org>
 <559591E5.5060106@siemens.com> <55959E70.1020407@siemens.com>
 <20150703105149.GZ13256@hermes.click-hack.org>
 <20150703123125.GC13256@hermes.click-hack.org>
 <20150703123829.GD13256@hermes.click-hack.org>
 <55A7A516.7090005@siemens.com> <55A7FB0F.6090105@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55A7FB0F.6090105@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Thu, Jul 16, 2015 at 08:42:23PM +0200, Jan Kiszka wrote:
> On 2015-07-16 14:35, Jan Kiszka wrote:
> > On 2015-07-03 14:38, Gilles Chanteperdrix wrote:
> >> On Fri, Jul 03, 2015 at 02:31:25PM +0200, Gilles Chanteperdrix wrote:
> >>> On Fri, Jul 03, 2015 at 12:51:49PM +0200, Gilles Chanteperdrix wrote:
> >>>>> index 0000000..36b1e69
> >>>>> --- /dev/null
> >>>>> +++ b/kernel/cobalt/posix/gen-syscall-entries.sh
> >>>>> @@ -0,0 +1,24 @@
> >>>>> +#! /bin/sh
> >>>>> +
> >>>>> +set -e
> >>>>> +
> >>>>> +shift
> >>>>> +
> >>>>> +echo "#ifdef COBALT_LIST_CALL_ENTRIES"
> >>>>> +awk '
> >>>>> +match($0, /COBALT_SYSCALL\([^,]*, [^,]*/)  {
> >>>>> +	str=substr($0, RSTART + 15, RLENGTH - 15)
> >>>>> +	match(str, /[^,]*/)
> >>>>> +	print "__COBALT_CALL_ENTRY(" substr(str, RSTART, RLENGTH) ")"
> >>>>> +}
> >>>>> +' $*
> >>>>> +echo "#endif"
> >>>>> +
> >>>>> +echo "#ifdef COBALT_LIST_MODES"
> >>>>> +awk '
> >>>>> +match($0, /COBALT_SYSCALL\([^,]*, [^,]*/)  {
> >>>>> +	str=substr($0, RSTART + 15, RLENGTH - 15)
> >>>>> +	print "__COBALT_MODE(" str ")"
> >>>>> +}
> >>>>> +' $*
> >>>>> +echo "#endif"
> >>>>
> >>>> This is particularly inelegant:
> >>>> - you do not need awk to do that, sed is sufficient
> >>>> - with using awk, you can generate the two files in one pass, and
> >>>> remove the #ifdefs trick;
> >>>> - I think the awk script should at least generate an error in case
> >>>> of parser error
> >>>>
> >>>> I will submit an awk script which does that.
> >>>
> >>> Ok, another awk script which does that:
> >>>
> >>> BEGIN {
> >>> 	system("rm -f syscalls_modes.h syscalls_entries.h")
> >>> }
> >>>
> >>> match($0, /COBALT_SYSCALL\([^,]*,[ \t]*[^,]*/)  {
> >>> 	str=substr($0, RSTART + 15, RLENGTH - 15)
> >>> 	match(str, /[^, \t]*/)
> >>> 	syscall=substr(str, RSTART, RLENGTH)
> >>>
> >>> 	if (syscall == "") {
> >>> 		print "Failed to find syscall name in line " $0
> >>> 		exit 1
> >>> 	}
> >>>
> >>> 	print "__COBALT_MODE(" str ")," >> "syscalls_modes.h"
> >>> 	print "__COBALT_CALL_ENTRY(" syscall ")," >> "syscalls_entries.h"
> >>> 	next
> >>> }
> >>>
> >>> /COBALT_SYSCALL\(/  {
> >>> 	print "Failed to parse line " $0
> >>> 	exit 1
> >>> }
> >>>
> >>> It supposes it is running from the output directory, but we can pass
> >>> the output directory as a parameter if you prefer.
> >>
> >> Note that the simplistic approach taken precludes the use of
> >> conditional compilation with syscall definitions.
> > 
> > I'll parametrize and integrate this, thanks.
> 
> To explain the variation from your approach that you will find in my
> queue now: Letting the script generate two files in one run is very
> unhandy when defining the Makefile rules. So I now went for a two-stage
> generation via awk that spits out two different macros the tables
> can use.

Looks like nonsense to me. 

foo bar: foo.awk 

works with GNU make as far as I know

-- 
					    Gilles.
https://click-hack.org


Message-ID: <478370D6.8080605@domain.hid>
Date: Tue, 08 Jan 2008 13:47:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2ff1a98a0801080223l4c975df8qbc64c164b9697454@domain.hid>	<14854214.1199776626079.JavaMail.ngmail@domain.hid>
	<24653876.1199792394399.JavaMail.ngmail@domain.hid>
In-Reply-To: <24653876.1199792394399.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] posix functions for real time and non real time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

M. Koehrer wrote:
> Hi Gilles,
> 
> thank you very much for the response.
> I tried this out and found one strange thing:
> When I run the following simple example (that uses the __real_pthread_ functions)
> the executable appears in the /proc/xenomai/stat list.
> As I am calling __real_pthread_create() I expected that my program does not appear
> in xenomai at all.
> Build is done using xeno-config --posix-cflags plus -O2 -Wall. For linking xeno-config --posix-ldflags 
> is used.

POSIX-skin applications automatically map the main thread to a (prio-0)
Xenomai thread, therefore you see at least one thread in /proc/xenomai.
Technically, this happens in the init function of the pthread_rt lib you
link against, and it helps your main thread to interact with Xenomai
resources without explicit (non-standard) thread wrapping.

> 
> Another question:
> Is there a special header file available that has some defines to map the pthread_xxx
> function to __real_pthread_xxx.
> By including this header I do not have to modify the C code of that files that should
> use the non real-time functions.

You are tackling an important issue: How to build large-scale POSIX
applications over Xenomai when they have both RT and non-RT parts?
Possible strategies:

[RT part dominates]
 - Wrap the non-RT calls with "__real_"-prefixes

[Non-RT part dominates]
 - Invoke RT-services explicitly via "__wrap_"-prefixes

[Both cases]
 - Separate RT- and non-RT-only components into separate program
   modules, link them in two steps: first RT with Xenomai args and
   non-RT as usual, then link both intermediate parts together

For this wrapping, I think that renaming macros for pthread services
could indeed be useful (e.g. something that translates
rt_pthread_mutex_lock in the source code into __warp_pthread_mutex_lock
for the linker).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux


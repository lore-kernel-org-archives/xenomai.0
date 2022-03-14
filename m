Message-ID: <09938899-efbb-24a8-1e5d-c80dd5b7c5fd@siemens.com>
Date: Mon, 14 Mar 2022 07:41:27 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v7 1/3] build: add options to build plugins of kernelshark
 and libtraceevent
Content-Language: en-US
References: <cover.1647090002.git.jan.kiszka@siemens.com>
 <0b26bd28e2bfca49a4e7582be9f01e74bd74c409.1647090002.git.jan.kiszka@siemens.com>
 <MN2PR11MB428509FCA6398CFBBD3BAC91F20F9@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB428509FCA6398CFBBD3BAC91F20F9@MN2PR11MB4285.namprd11.prod.outlook.com>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 14.03.22 02:27, Chen, Hongzhan wrote:
>>
>>
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>> Sent: Saturday, March 12, 2022 9:00 PM
>> To: xenomai@xenomai.org
>> Cc: Chen, Hongzhan <hongzhan.chen@intel.com>
>> Subject: [PATCH v7 1/3] build: add options to build plugins of kernelshark and libtraceevent
>>
>> From: Hongzhan Chen <hongzhan.chen@intel.com>
>>
>> To build plugins of kernelshark and libtraceevent, add options and
>> do necessary configuration.
>>
>> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>> [Jan: cleaned up AC_ARG_ENABLE matches, add missing kshark dep, drop INSTALLDIRs]
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> configure.ac | 33 +++++++++++++++++++++++++++++++++
>> 1 file changed, 33 insertions(+)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 16cffd8f81..ef450aa582 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -91,6 +91,8 @@ AC_ARG_WITH(cxx,
>>     ])
>> AC_PROG_CXX
>>
>> +PKG_PROG_PKG_CONFIG
>> +
>> # Do not let autoconf set the default value of CFLAGS
>> if $XENO_EMPTY_CFLAGS; then
>> 	CFLAGS=""
>> @@ -826,6 +828,37 @@ AC_ARG_WITH(demodir,
>>     ], [XENO_DEMO_DIR=$demodir])
>> AC_MSG_RESULT($XENO_DEMO_DIR)
>>
>> +kernelshark_plugin=
>> +AC_MSG_CHECKING(whether KernelShark plugin should be built)
>> +AC_ARG_ENABLE(kernelshark_plugin,
>> +	AS_HELP_STRING([--enable-kernelshark-plugin], [build KernelShark plugin]),
>> +	[case "$enableval" in
>> +	y | yes) kernelshark_plugin=y ;;
>> +	*) unset kernelshark_plugin ;;
>> +	esac])
>> +AC_MSG_RESULT(${kernelshark_plugin:-no})
>> +AM_CONDITIONAL(XENO_KSHARK_PLUGIN, [test x$kernelshark_plugin = xy])
>> +
>> +libtraceevent_plugin=
>> +AC_MSG_CHECKING(whether libtraceevent plugin should be built)
>> +AC_ARG_ENABLE(libtraceevent_plugin,
>> +	AS_HELP_STRING([--enable-libtraceevent-plugin], [build libtraceevent plugin]),
>> +	[case "$enableval" in
>> +	y | yes) libtraceevent_plugin=y ;;
>> +	*) unset libtraceevent_plugin ;;
>> +	esac])
>> +AC_MSG_RESULT(${libtraceevent_plugin:-no})
>> +AM_CONDITIONAL(XENO_LIBTRACEEVENT_PLUGIN, [test x$libtraceevent_plugin = xy])
>> +
>> +if test x$kernelshark_plugin = xy -o x$libtraceevent_plugin = xy; then
>> +	PKG_CHECK_MODULES(LIBTRACEEVENT, libtraceevent)
>> +fi
>> +
>> +if test x$kernelshark_plugin = xy; then
>> +	PKG_CHECK_MODULES(LIBKSHARK, libkshark)
>> +	PKG_CHECK_MODULES(LIBTRACEFS, libtracefs)
> 
> I do not quite understand why we check LIBTRAEFS here because kernelshark depend on libtracefs 
> as described in [1] which should be handled by kernelshark module itself.
> If we have to check libtracefs, why we do not check other dependency module like libtraceevent  for kernelshark_plugin?
> 

Without this inclusion (and the corresponding usage of 
LIBTRACEFS_CFLAGS), you will get

  CC       plugin_xenomai_cobalt_switch_events_la-xenomai_cobalt_switch_events.lo
In file included from ../../../tracing/kernelshark/xenomai_cobalt_switch_events.c:17:0:
/usr/local/include/trace-cmd/trace-cmd.h:10:10: fatal error: tracefs.h: No such file or directory
 #include "tracefs.h"
          ^~~~~~~~~~~
compilation terminated.

I do not have libtracefs installed via my distro, thus everything must 
be explored and properly appended to the search path.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


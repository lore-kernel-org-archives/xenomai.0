Message-ID: <8b23b623-d1b2-e35e-5386-b2220e581c15@siemens.com>
Date: Thu, 3 Mar 2022 08:00:56 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] libtraceevent: Add xenomai_schedparams plugin for
 libtraceevent
Content-Language: en-US
References: <20220303012031.16509-1-hongzhan.chen@intel.com>
 <9191fe03-91df-0ff9-0dd2-33d04641374d@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <9191fe03-91df-0ff9-0dd2-33d04641374d@siemens.com>
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org, florian.bezdeka@siemens.com

On 03.03.22 07:57, Jan Kiszka via Xenomai wrote:
> On 03.03.22 02:20, Hongzhan Chen wrote:
>> For cobalt thread, there is special struct param_ex data stored in
>> data record, we need to parse and print its content out correctly
>> to hint user.
>>
>> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>> ---
>>  configure.ac                                  |  17 +-
>>  tracing/Makefile.am                           |  13 +-
>>  tracing/libtraceevent/Makefile.am             |  11 ++
>>  tracing/libtraceevent/README                  |  30 ++++
>>  .../plugin_xenomai_schedparams.c              | 158 ++++++++++++++++++
>>  5 files changed, 226 insertions(+), 3 deletions(-)
>>  create mode 100644 tracing/libtraceevent/Makefile.am
>>  create mode 100644 tracing/libtraceevent/README
>>  create mode 100644 tracing/libtraceevent/plugin_xenomai_schedparams.c
>>
>> diff --git a/configure.ac b/configure.ac
>> index b8e9ca143..5858b3b22 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -829,7 +829,7 @@ AC_MSG_RESULT($XENO_DEMO_DIR)
>>  xeno_build_kernelshark=false
>>  AC_MSG_CHECKING(build kernelshark plugins)
>>  AC_ARG_WITH(kernelshark,
>> -    AS_HELP_STRING([--with-kernelshark],[build kernelshark related plugins]),
>> +    AS_HELP_STRING([--with-kernelshark],[build kernelshark related plugins including libtraceevent plugin]),
> 
> Try to refactor in way that you do not needlessly modify code that you
> added in a previous patch of the same series.
> 
>>      [
>>  	case "$withval" in
>>  	"" | y | ye | yes) xeno_build_kernelshark=true;;
>> @@ -840,6 +840,20 @@ AC_MSG_RESULT($xeno_build_kernelshark)
>>  
>>  AM_CONDITIONAL([BUILD_KERNELSHARK], [test x$xeno_build_kernelshark = xtrue])
>>  
>> +xeno_build_libtraceevent=false
>> +AC_MSG_CHECKING(build libtraceevent plugin)
>> +AC_ARG_WITH(libtraceevent,
>> +    AS_HELP_STRING([--with-libtraceevent],[build libtraceevent plugin]),
>> +    [
>> +	case "$withval" in
>> +	"" | y | ye | yes) xeno_build_libtraceevent=true;;
>> +	n | no) xeno_build_libtraceevent=false;;
>> +	esac
>> +    ], [xeno_build_libtraceevent=false])
>> +AC_MSG_RESULT($xeno_build_libtraceevent)
>> +
>> +AM_CONDITIONAL([BUILD_LIBTRACEEVENT], [test x$xeno_build_libtraceevent = xtrue])
>> +
>>  AC_MSG_CHECKING([for test source generation])
>>  AC_RUN_IFELSE([AC_LANG_PROGRAM([[ ]], [[ ]])],
>>      [AC_MSG_RESULT(ok)], [AC_MSG_RESULT(failed)], [AC_MSG_RESULT(untestable)])
>> @@ -959,6 +973,7 @@ AC_CONFIG_FILES([ \
>>  	scripts/xeno \
>>  	tracing/Makefile \
>>  	tracing/kernelshark/Makefile \
>> +	tracing/libtraceevent/Makefile \
>>  	lib/Makefile \
>>  	lib/boilerplate/Makefile \
>>  	lib/boilerplate/init/Makefile \
>> diff --git a/tracing/Makefile.am b/tracing/Makefile.am
>> index 7925ae9c6..1351a98d2 100644
>> --- a/tracing/Makefile.am
>> +++ b/tracing/Makefile.am
>> @@ -1,7 +1,16 @@
>>  if BUILD_KERNELSHARK
>>  SUBDIRS =		\
>> -	kernelshark
>> +	kernelshark	\
>> +	libtraceevent
>> +else
>> +
>> +if BUILD_LIBTRACEEVENT
>> +SUBDIRS =		\
>> +	libtraceevent
>> +endif
>> +
> 
> You want SUBDIRS += ...
> 
> See existing makefiles.
> 

Oh, and I don't think that the kernelshark plugin technically depends on
the libtraceevent one. Both can be and are controlled via configure
independently, though you normally /want/ libtraceevent as well when
using the kernelshark plugin.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


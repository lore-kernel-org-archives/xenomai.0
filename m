Subject: Re: [PATCH v4 3/4] y2038: Add tests for the sc_cobalt_sem_timedwait64
 syscall
References: <20210507124953.1079415-1-florian.bezdeka@siemens.com>
 <20210507124953.1079415-4-florian.bezdeka@siemens.com>
 <268f9b87-e3bf-6628-3828-f48041e37e4a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cb54b4e9-bafc-c92f-c6f6-c3eb73199e97@siemens.com>
Date: Fri, 7 May 2021 18:10:44 +0200
MIME-Version: 1.0
In-Reply-To: <268f9b87-e3bf-6628-3828-f48041e37e4a@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org

On 07.05.21 17:58, Jan Kiszka via Xenomai wrote:
> On 07.05.21 14:49, Florian Bezdeka wrote:
>> Introducing a new smokey plugin that can be extended for all kind of
>> y2038 tests. For now we are testing the new sc_cobalt_sem_timedwait64
>> syscall without using any libc wrappers provided by libcobalt.
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>>  configure.ac                           |   1 +
>>  testsuite/smokey/Makefile.am           |   6 +-
>>  testsuite/smokey/y2038/Makefile.am     |  10 ++
>>  testsuite/smokey/y2038/syscall-tests.c | 177 +++++++++++++++++++++++++
>>  4 files changed, 192 insertions(+), 2 deletions(-)
>>  create mode 100644 testsuite/smokey/y2038/Makefile.am
>>  create mode 100644 testsuite/smokey/y2038/syscall-tests.c
>>
>> diff --git a/configure.ac b/configure.ac
>> index abe538dbd..bd5fd5ba9 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -990,6 +990,7 @@ AC_CONFIG_FILES([ \
>>  	testsuite/smokey/net_common/Makefile \
>>  	testsuite/smokey/cpu-affinity/Makefile \
>>  	testsuite/smokey/gdb/Makefile \
>> +	testsuite/smokey/y2038/Makefile \
>>  	testsuite/clocktest/Makefile \
>>  	testsuite/xeno-test/Makefile \
>>  	utils/Makefile \
>> diff --git a/testsuite/smokey/Makefile.am b/testsuite. Eventually, we /smokey/Makefile.am
>> index 02613c7dc..56c873026 100644
>> --- a/testsuite/smokey/Makefile.am
>> +++ b/testsuite/smokey/Makefile.am
>> @@ -38,7 +38,8 @@ COBALT_SUBDIRS = 	\
>>  	timerfd		\
>>  	tsc		\
>>  	vdso-access 	\
>> -	xddp
>> +	xddp		\
>> +	y2038
>>  
>>  MERCURY_SUBDIRS =	\
>>  	memory-heapmem	\
>> @@ -76,7 +77,8 @@ DIST_SUBDIRS = 		\
>>  	timerfd		\
>>  	tsc		\
>>  	vdso-access 	\
>> -	xddp
>> +	xddp		\
>> +	y2038
>>  
>>  if XENO_COBALT
>>  if CONFIG_XENO_LIBS_DLOPEN
>> diff --git a/testsuite/smokey/y2038/Makefile.am b/testsuite/smokey/y2038/Makefile.am
>> new file mode 100644
>> index 000000000..4bf629e87
>> --- /dev/null
>> +++ b/testsuite/smokey/y2038/Makefile.am
>> @@ -0,0 +1,10 @@
>> +
>> +noinst_LIBRARIES = liby2038.a
>> +
>> +liby2038_a_SOURCES = syscall-tests.c
>> +
>> +liby2038_a_CPPFLAGS = 	\
>> +	@XENO_USER_CFLAGS@	\
>> +	-I$(top_srcdir)		\
>> +	-I$(top_srcdir)/include \
>> +	-I$(top_srcdir)/lib/cobalt/arch/@XENO_TARGET_ARCH@/include
> 
> Is that really needed? How do libs get access to those headers?
> 

XENO_USER_CFLAGS -> XENO_COBALT_CFLAGS may be better here.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


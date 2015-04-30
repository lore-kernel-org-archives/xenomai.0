Message-ID: <5541E1F2.1090908@bmwedler.de>
Date: Thu, 30 Apr 2015 10:04:02 +0200
From: Registrierungen <regist@bmwedler.de>
MIME-Version: 1.0
References: <5541BFA1.40101@bmwedler.de> <5541DB07.4050304@xenomai.org>
In-Reply-To: <5541DB07.4050304@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3.0rc creating alchemy task in a shared object
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Thanks for your reply.

Please not that it works fine for the standalone application.

Just in case, the task is created inside a staticaly linked shared 
object the error occurs.

Here ist the config:

CONFIG_MMU=1
CONFIG_SMP=1
CONFIG_XENO_BUILD_ARGS=" '--prefix=/usr' 
'--includedir=/usr/include/xenomai' '--mandir=/usr/share/man' 
'--with-testdir=/usr/lib/xenomai/testsuite' '--build' 'x86_64-linux-gnu' 
'build_alias=x86_64-linux-gnu'"
CONFIG_XENO_BUILD_STRING="x86_64-pc-linux-gnu"
CONFIG_XENO_COBALT=1
CONFIG_XENO_COMPILER="gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) "
CONFIG_XENO_DEFAULT_PERIOD=100000
CONFIG_XENO_FORTIFY=1
CONFIG_XENO_HOST_STRING="x86_64-pc-linux-gnu"
CONFIG_XENO_LORES_CLOCK_DISABLED=1
CONFIG_XENO_PREFIX="/usr"
CONFIG_XENO_RAW_CLOCK_ENABLED=1
CONFIG_XENO_REVISION_LEVEL=9
CONFIG_XENO_SANITY=1
CONFIG_XENO_TLSF=1
CONFIG_XENO_TLS_MODEL="initial-exec"
CONFIG_XENO_UAPI_LEVEL=9
CONFIG_XENO_VERSION_MAJOR=2
CONFIG_XENO_VERSION_MINOR=99
CONFIG_XENO_VERSION_NAME="Exact Zero"
CONFIG_XENO_VERSION_STRING="3.0-rc1"
CONFIG_XENO_X86_VSYSCALL=1
---
CONFIG_XENO_ARM_SA1100 is OFF
CONFIG_XENO_ARM_TSC_TYPE is OFF
CONFIG_XENO_ASYNC_CANCEL is OFF
CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
CONFIG_XENO_CPU_XSC3 is OFF
CONFIG_XENO_DEBUG is OFF
CONFIG_XENO_DEBUG_FULL is OFF
CONFIG_XENO_LIBS_DLOPEN is OFF
CONFIG_XENO_MERCURY is OFF
CONFIG_XENO_PSHARED is OFF
CONFIG_XENO_REGISTRY is OFF
CONFIG_XENO_VALGRIND_API is OFF

Regards

   Sascha


Am 30.04.2015 um 09:34 schrieb Philippe Gerum:
> On 04/30/2015 07:37 AM, Registrierungen wrote:
>> Hello,
>>
>> i ve got a working xenomai application using alchemy tasks and try to
>> outource funtionallity into a shared object.
>> If i try to create a thread (same code like in the application) in the
>> shared object rt_create_task allways returns EEXISTS.
>> Name parameter change or set to NULL does not change anything.
>>
>> Are there any side effects if i try to create alchemy tasks inside a
>> shared object or are there any restrictions?
>>
> Short answer, no. However, I can't comment more on this issue, since I
> don't know which -rc you are currently running, whether this is a dual
> kernel or single kernel configuration, etc.
>
> The output of the following command may help:
>
> $ ./your-app --dump-config
>



MIME-Version: 1.0
In-Reply-To: <5541FD72.3090806@xenomai.org>
References: <CAMJ=MEceJGYZ+RQ4eW9vnvfM=iLNTUv7sN0ePij4aEbegdAM+w@mail.gmail.com>
 <5541FD72.3090806@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Thu, 30 Apr 2015 14:39:30 +0200
Message-ID: <CAMJ=MEcq-VE-QK021_RigRUVbbXOtKwL4G27bhtP=y+hX3eE6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] [xenomai-forge] Task blocked in t_delete
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "martin.bielik.sk" <martin.bielik.sk@gmail.com>, xenomai@xenomai.org

On Thu, Apr 30, 2015 at 12:01 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 04/30/2015 10:14 AM, Ronny Meeus wrote:
>> Hello
>>
>> we are using the xenomai-forge mercury core together with the pSOS interface.
>>
>> We observe following issue: we have 3 tasks at different priorities
>> (see test code attached).
>> The task with the middle priority is running forever (while (1)).
>>
>> The higest prio task is responsible cleaning up the 2 other tasks.
>> If the middle prio task is deleted first, followed by the low prio, it works.
>> If the low prio task is deleted first, the high prio task just blocks
>> on the delete and the system hangs in that phase.
>>
>
> I could not reproduce this bug with your test case unmodified after an
> hour running this program in loop. Could you paste the output of
> --dump-config so that I can align on your settings?
>

CONFIG_MMU=1
CONFIG_SMP=1
CONFIG_XENO_ASYNC_CANCEL=1
CONFIG_XENO_BUILD_ARGS=" '--target=armeb-buildroot-linux-gnueabi'
'--host=armeb-buildroot-linux-gnueabi'
'--build=x86_64-unknown-linux-gnu' '--prefix=/usr'
'--exec-prefix=/usr' '--sysconfdir=/etc' '--program-prefix='
'--disable-gtk-doc' '--disable-doc' '--disable-docs'
'--disable-documentation' '--with-xmlto=no' '--with-fop=no'
'--enable-ipv6' '--enable-static' '--enable-shared'
'--with-core=mercury' '--includedir=/usr/include/xenomai-forge'
'--disable-doc-install' '--enable-lores-clock' '--enable-smp'
'--enable-async-cancel' '--enable-registry'
'build_alias=x86_64-unknown-linux-gnu'
'host_alias=armeb-buildroot-linux-gnueabi'
'target_alias=armeb-buildroot-linux-gnueabi'
'CC=/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/host/usr/bin/armeb-linux-gcc'
'CFLAGS=-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
-D_FILE_OFFSET_BITS=64  -pipe -mcpu=arm1176jz-s -Os ' 'LDFLAGS='
'CPPFLAGS=-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
-D_FILE_OFFSET_BITS=64'
'CPP=/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/host/usr/bin/armeb-linux-cpp'
'PKG_CONFIG=/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/host/usr/bin/pkg-config'"
CONFIG_XENO_BUILD_STRING="x86_64-unknown-linux-gnu"
CONFIG_XENO_COMPILER="gcc version 4.4.3 (crosstool-NG 1.19.0) "
CONFIG_XENO_DEFAULT_PERIOD=1000000
CONFIG_XENO_FORTIFY=1
CONFIG_XENO_HOST_STRING="armeb-buildroot-linux-gnueabi"
CONFIG_XENO_MERCURY=1
CONFIG_XENO_PREFIX="/usr"
CONFIG_XENO_REGISTRY=1
CONFIG_XENO_REVISION_LEVEL=7
CONFIG_XENO_SANITY=1
CONFIG_XENO_TLSF=1
CONFIG_XENO_TLS_MODEL="initial-exec"
CONFIG_XENO_UAPI_LEVEL=8
CONFIG_XENO_VERSION_MAJOR=2
CONFIG_XENO_VERSION_MINOR=99
CONFIG_XENO_X86_VSYSCALL=1
---
CONFIG_XENO_ARM_SA1100 is OFF
CONFIG_XENO_ARM_TSC_TYPE is OFF
CONFIG_XENO_COBALT is OFF
CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
CONFIG_XENO_CPU_XSC3 is OFF
CONFIG_XENO_DEBUG is OFF
CONFIG_XENO_DEBUG_FULL is OFF
CONFIG_XENO_LIBS_DLOPEN is OFF
CONFIG_XENO_LORES_CLOCK_DISABLED is OFF
CONFIG_XENO_PSHARED is OFF
CONFIG_XENO_RAW_CLOCK_ENABLED is OFF
CONFIG_XENO_VALGRIND_API is OFF

>> My assumption is that this is a bug in the delete functionality.
>> Is this a known issue?
>>
>
> No report from such issue.
>

If I run the test I see:

/tmp # ./task_delete
Start of test
Create and start main task:Create task M:
Create task L:
Start task M:
Start task L:
M: entry
L: entry
M: Dead loop starts
Cleaning ..
End of test

Here is the piece of the code that goes wrong:

  printf("Cleaning ..\r\n");
  /* Remove tasks */
  t_delete(L_id);
  /* Followed code is not executed because t_delete is somehow blocked */
  printf("Removed L task id = 0x%lx\r\n", L_id);
  t_delete(M_id);
  printf("Removed M task id = 0x%lx\r\n", M_id);
}

Since the trace "Removed L task id..." is not generated, my assumption
it that the t_delete(L_id) blocks.


Ronny


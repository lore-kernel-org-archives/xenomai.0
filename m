References: <75c20daf-b35f-116e-11c5-75f6fcfc10ed@gmail.com>
 <0532cb51-4e2b-f600-b866-f60bd3d13c80@numalliance.com>
From: Fyleo <fyleo45@gmail.com>
Message-ID: <bbc4317c-2238-b9f1-0e4d-10a683618af8@gmail.com>
Date: Tue, 30 May 2017 12:17:59 +0200
MIME-Version: 1.0
In-Reply-To: <0532cb51-4e2b-f600-b866-f60bd3d13c80@numalliance.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: fr-classic
Subject: Re: [Xenomai] dlopen failing when using shared library on xenomai
 3.0.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


> Le 29/05/2017 à 23:19, Fyleo a écrit :
>> Hello all,
>>
>> I'm trying to port machinekit (machinekit.io) to xenomai 3.0.4 which 
>> support only xenomai 2.6.4 for the moment.
>>
>> This software is design this way :
>>
>> A : main executable
>>
>> B : shared library abstracting thread API, with one library for 
>> posix, for xenomai, ...
>>
>> The xenomai B library is linked against alchemy, copperplate, ... 
>> (xeno-config --ldflags --auto-init-solib --skin=alchemy)
>>
>> The program works in a way that, at start time, it load with dlopen 
>> the configured API (B).
>>
>> My problem is that dlopen(with RTLD_GLOBAL|RTLD_NOW) fail with the 
>> error : "/usr/lib/libcopperplate.so.0: undefined symbol: main"
>>
>> Here is the simplified test case to reproduce the problem :
>>
>> main.c:
>>     #include <stdio.h>
>>     #include <stdlib.h>
>>     #include <dlfcn.h>
>>
>>     int main(int argc, char *const argv[])
>>     {
>>         void *handle;
>>
>>         handle = dlopen("./ulapi-xenomai.so", RTLD_GLOBAL|RTLD_NOW);
>>         if (!handle) {
>>             fprintf(stderr, "%s\n", dlerror());
>>             exit(EXIT_FAILURE);
>>         }
>>
>>         dlclose(handle);
>>         exit(EXIT_SUCCESS);
>>     }
>>
>> gcc main.c -o testcase -ldl
>> gcc -Wl,-soname,ulapi-xenomai.so -shared -o ulapi-xenomai.so 
>> `xeno-config --ldflags --auto-init-solib --skin=alchemy`
>>
>> run testcase
>>
>> I am missing something or is there a solution that doesn't imply to 
>> use RTLD_LAZY ?
>>
>> my xeno-config --info
>> Xenomai version: Xenomai/cobalt v3.0.4
>> Linux beaglebone 4.4.62-ti-xenomai-r105 #1 SMP Wed May 24 00:09:09 
>> UTC 2017 armv7l GNU/Linux
>> Kernel parameters: console=ttyO0,115200n8 
>> capemgr.disable_partno=BB-BONELT-HDMI 
>> bone_capemgr.uboot_capemgr_enabled=1 root=/dev/mmcblk0p1 ro 
>> rootfstype=ext4 rootwait coherent_pool=1M net.ifnames=0 quiet
>> I-pipe release #7 detected
>> Cobalt core 3.0.4 detected
>> Compiler: gcc version 4.9.2 (Debian 4.9.2-10)
>> Build args: --prefix=/usr --includedir=/usr/include/xenomai 
>> --mandir=/usr/share/man --with-testdir=/usr/lib/xenomai/testsuite 
>> --enable-dlopen-libs --enable-smp --build arm-linux-gnueabihf 
>> build_alias=arm-linux-gnueabihf
>>
>> Regards,
>>
>> Fyleo
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
On 30/05/2017 09:22, Stéphane Ancelot wrote:
> Hi,
>
> Why don't you link the shared lib at compilation ?
>
> Regards,
> S.Ancelot
Hi,

Because there is multiple ulapi that can be loaded at execution time to 
switch between posix (non-xenomai) thread, xenomai thread, rtai thread 
and so on, depending on environnement variable.
It is not my program so i want to be less invasive as possible.

Regards,
Fyleo



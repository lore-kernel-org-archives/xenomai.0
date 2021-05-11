Subject: Re: xeno-test failed due to cond_destroy error
References: <CAMDn9+TNXf5msUQu6kobU9-b2-8O460rg6icT18NpJdnQzh1Rw@mail.gmail.com>
 <02935a30-7b67-5878-ce25-f2276aeea0a8@siemens.com>
 <CAMDn9+Rxc=H=0R46YK0CgbNLHQZuF8N=_KY-7S-87rY+r86zHw@mail.gmail.com>
 <56335a02-69dd-32ed-5c1b-9df7b1a4b760@siemens.com>
 <CAMDn9+R2AozuqLk_eLge+vbnxj0vRFuzV0DuVdarCk1bLgcakA@mail.gmail.com>
 <CAMDn9+QAgAVtfchVkPS2j9UC0wiFO+uBjVPh4MLT084q40KL5Q@mail.gmail.com>
 <CAMDn9+QdT887Fe97p7-aFKBX5ZtzxtVmPjUryySVxrnC2vW+PQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6f675adc-5f4f-885f-f21e-5a8ce79797a1@siemens.com>
Date: Tue, 11 May 2021 17:10:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAMDn9+QdT887Fe97p7-aFKBX5ZtzxtVmPjUryySVxrnC2vW+PQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fangsuo Wu <tiger20081015@gmail.com>
Cc: xenomai@xenomai.org

On 11.05.21 12:37, Fangsuo Wu wrote:
> Hi, the issue seems related to the gcc compiler I
> used（gcc-linaro-arm-linux-gnueabihf-4.9-2014.08_linux）.

Huh, that is... well "matured".

> 
> I added some log and found the failure was from below code, line 155:
> pthread_cond_destroy
>     -> cobalt_cond_autoinit_type:
> 149 static int __attribute__((cold))
> 150 >-------cobalt_cond_autoinit_type(const pthread_cond_t *cond)
> 151 {
> 152 >-------static const pthread_cond_t cond_initializer =
> 153 >------->-------PTHREAD_COND_INITIALIZER;
> 154
> 155 >-------return memcmp(cond, &cond_initializer,
> sizeof(cond_initializer)) == 0 ?
> 156 >------->-------0 : -1;   //memcmp is not Zero
> 157 }
> 
> I dumped the content of pthread_cond_t  cond and cond_initializer. For
> the latter one, all bytes were 0, but for cond variable, only the
> first 44 bytes were 0, the last 4 bytes' value changed every time.
> 
> I found the pthread_cond_t  and PTHREAD_COND_INITIALIZER definitions
> in the GCC I used:
> 
> #define PTHREAD_COND_INITIALIZER { { 0, 0, 0, 0, 0, (void *) 0, 0, 0}}
> #define __SIZEOF_PTHREAD_COND_T 48
> 
>  89 typedef union
>  90 {
>  91   struct
>  92   {
>  93     int __lock;
>  94     unsigned int __futex;
>  95     __extension__ unsigned long long int __total_seq;
>  96     __extension__ unsigned long long int __wakeup_seq;
>  97     __extension__ unsigned long long int __woken_seq;
>  98     void *__mutex;
>  99     unsigned int __nwaiters;
> 100     unsigned int __broadcast_seq;
> 101   } __data;
> 102   char __size[__SIZEOF_PTHREAD_COND_T];
> 103   __extension__ long long int __align;
> 104 } pthread_cond_t;
> 105
> 
> The total size of pthread_cond_t.__size is 48. But
> PTHREAD_COND_INITIALIZER only initializes the first 44 bytes, thus the
> last 4 bytes' value becomes unpredictable. The issue was gone after I
> made the below change:
> 
>  197 //#define PTHREAD_COND_INITIALIZER { { 0, 0, 0, 0, 0, (void *) 0,
> 0, 0}}
>  198 #define PTHREAD_COND_INITIALIZER { .__size = {0}}
> 

Err, those types should rather come from glibc, not [lib]gcc.

Which glibc version are you using?

Jan

> 
> 
> 2021-05-10 17:40 GMT+08:00, Fangsuo Wu <tiger20081015@gmail.com>:
>> BTW, I just wrote an application which is exactly the same with
>> autoinit_simple_conddestroy. And it can run successfully in my board.
>>
>>   1 #include <stdio.h>
>>   2 #include <pthread.h>
>>   3 int main(void)
>>   4 {
>>   5 >-------pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
>>   6 >-------if(pthread_cond_destroy(&cond) == 0)
>>   7 >------->-------printf("suc!\n");
>>   8 >-------else
>>   9 >------->-------printf("err!\n");
>>  10 }
>>
>> sh-4.4# ./main
>> suc!
>>
>>
>> 2021-05-10 17:28 GMT+08:00, Fangsuo Wu <tiger20081015@gmail.com>:
>>> Jan,
>>> I removed the CFLAGS and LDFLAGS, with configure command:
>>>
>>> ./configure --build=i686-pc-linux-gnu --host=arm-linux-gnueabihf
>>> --with-core=cobalt --enable-smp --enable-lazy-setsched
>>> --enable-debug=symbols
>>>
>>> But the issue still remains. I changed the failed test case as below,
>>> the issue still exists.
>>>
>>> 226 static void autoinit_simple_conddestroy(void)
>>> 227 {
>>> 228 >-------pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
>>> 229 #if 0
>>> 230 >-------pthread_cond_t cond2 = PTHREAD_COND_INITIALIZER;
>>> 231 >-------unsigned int invalmagic = ~0x86860505; // ~COBALT_COND_MAGIC
>>> 232
>>> 233 >-------memcpy((char *)&cond2 + sizeof(cond2) - sizeof(invalmagic),
>>> 234 >------->-------&invalmagic, sizeof(invalmagic));
>>> 235
>>> 236 >-------smokey_trace("%s", __func__);
>>> 237 #endif
>>> 238 >-------check("cond_destroy", cond_destroy(&cond), 0);
>>> 239 //>-----check("cond_destroy invalid", cond_destroy(&cond2), -EINVAL);
>>> 240 }
>>>
>>> I'll try QEMU later to see if the issue also exits in QEMU.
>>>
>>> BTW, I saw some below warnings in compiling, do they have any
>>> relationship with the issue?
>>>   /bin/bash ../../../libtool   --mode=install /usr/bin/install -c
>>> smokey_net_server '/home/data/nfs_test//usr/xenomai/bin'
>>> libtool: warning: '../../../lib/cobalt/libcobalt.la' has not been
>>> installed in '/usr/xenomai/lib'
>>> libtool: warning: '../../../lib/cobalt/libmodechk.la' has not been
>>> installed in '/usr/xenomai/lib'
>>>
>>>
>>>
>>>
>>> 2021-05-10 15:35 GMT+08:00, Jan Kiszka <jan.kiszka@siemens.com>:
>>>> On 10.05.21 09:20, Fangsuo Wu wrote:
>>>>> Jan,
>>>>> Thanks for your reply. The environment I used is listed below. BTW, I
>>>>> can run latency test successfully.
>>>>>
>>>>> 1. The revision of Xenomai: xenomai-3.1.tar.bz2
>>>>> 2. Soc: dual ARM cortex A7
>>>>> 3. How I built application libraries:
>>>>>     ./configure CFLAGS="-march=armv7-a -mfpu=vfp3"
>>>>> LDFLAGS="-march=armv7-a -mfpu=vfp3"   --build=i686-pc-linux-gnu
>>>>> --host=arm-linux-gnueabihf --with-core=cobalt --enable-smp
>>>>> --enable-pshared
>>>>>    make DESTDIR=/home/data/nfs_test/ install
>>>>> 4. The kernel I used is 4.19 so I applied
>>>>> ipipe-core-4.19.55-arm-5.patch, and manually enabled
>>>>> CONFIG_IPIPE_ARM_KUSER_TSC. The full config file is:
>>>>>
>>>>
>>>> OK - our qemu-armhf target [1] is multicore A7 as well. Do you see the
>>>> problem in QEMU, too? Do any of the extra CFLAGS or LDFLAGS you pass
>>>> play a role here? We compile in CI only with "--enable-smp
>>>> --enable-lazy-setsched --enable-debug=symbols" - maybe
>>>> "--enable-pshared"...
>>>>
>>>> Jan
>>>>
>>>> [1] https://source.denx.de/Xenomai/xenomai-images/-/jobs/265962#L387
>>>>
>>>> --
>>>> Siemens AG, T RDA IOT
>>>> Corporate Competence Center Embedded Linux
>>>>
>>>
>>

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


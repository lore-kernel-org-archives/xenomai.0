MIME-Version: 1.0
In-Reply-To: <56335a02-69dd-32ed-5c1b-9df7b1a4b760@siemens.com>
References: <CAMDn9+TNXf5msUQu6kobU9-b2-8O460rg6icT18NpJdnQzh1Rw@mail.gmail.com>
 <02935a30-7b67-5878-ce25-f2276aeea0a8@siemens.com>
 <CAMDn9+Rxc=H=0R46YK0CgbNLHQZuF8N=_KY-7S-87rY+r86zHw@mail.gmail.com>
 <56335a02-69dd-32ed-5c1b-9df7b1a4b760@siemens.com>
From: Fangsuo Wu <tiger20081015@gmail.com>
Date: Mon, 10 May 2021 17:28:39 +0800
Message-ID: <CAMDn9+R2AozuqLk_eLge+vbnxj0vRFuzV0DuVdarCk1bLgcakA@mail.gmail.com>
Subject: Re: xeno-test failed due to cond_destroy error
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Jan,
I removed the CFLAGS and LDFLAGS, with configure command:

./configure --build=i686-pc-linux-gnu --host=arm-linux-gnueabihf
--with-core=cobalt --enable-smp --enable-lazy-setsched
--enable-debug=symbols

But the issue still remains. I changed the failed test case as below,
the issue still exists.

226 static void autoinit_simple_conddestroy(void)
227 {
228 >-------pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
229 #if 0
230 >-------pthread_cond_t cond2 = PTHREAD_COND_INITIALIZER;
231 >-------unsigned int invalmagic = ~0x86860505; // ~COBALT_COND_MAGIC
232
233 >-------memcpy((char *)&cond2 + sizeof(cond2) - sizeof(invalmagic),
234 >------->-------&invalmagic, sizeof(invalmagic));
235
236 >-------smokey_trace("%s", __func__);
237 #endif
238 >-------check("cond_destroy", cond_destroy(&cond), 0);
239 //>-----check("cond_destroy invalid", cond_destroy(&cond2), -EINVAL);
240 }

I'll try QEMU later to see if the issue also exits in QEMU.

BTW, I saw some below warnings in compiling, do they have any
relationship with the issue?
  /bin/bash ../../../libtool   --mode=install /usr/bin/install -c
smokey_net_server '/home/data/nfs_test//usr/xenomai/bin'
libtool: warning: '../../../lib/cobalt/libcobalt.la' has not been
installed in '/usr/xenomai/lib'
libtool: warning: '../../../lib/cobalt/libmodechk.la' has not been
installed in '/usr/xenomai/lib'




2021-05-10 15:35 GMT+08:00, Jan Kiszka <jan.kiszka@siemens.com>:
> On 10.05.21 09:20, Fangsuo Wu wrote:
>> Jan,
>> Thanks for your reply. The environment I used is listed below. BTW, I
>> can run latency test successfully.
>>
>> 1. The revision of Xenomai: xenomai-3.1.tar.bz2
>> 2. Soc: dual ARM cortex A7
>> 3. How I built application libraries:
>>     ./configure CFLAGS="-march=armv7-a -mfpu=vfp3"
>> LDFLAGS="-march=armv7-a -mfpu=vfp3"   --build=i686-pc-linux-gnu
>> --host=arm-linux-gnueabihf --with-core=cobalt --enable-smp
>> --enable-pshared
>>    make DESTDIR=/home/data/nfs_test/ install
>> 4. The kernel I used is 4.19 so I applied
>> ipipe-core-4.19.55-arm-5.patch, and manually enabled
>> CONFIG_IPIPE_ARM_KUSER_TSC. The full config file is:
>>
>
> OK - our qemu-armhf target [1] is multicore A7 as well. Do you see the
> problem in QEMU, too? Do any of the extra CFLAGS or LDFLAGS you pass
> play a role here? We compile in CI only with "--enable-smp
> --enable-lazy-setsched --enable-debug=symbols" - maybe
> "--enable-pshared"...
>
> Jan
>
> [1] https://source.denx.de/Xenomai/xenomai-images/-/jobs/265962#L387
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>


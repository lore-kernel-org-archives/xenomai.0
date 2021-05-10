Subject: Re: xeno-test failed due to cond_destroy error
References: <CAMDn9+TNXf5msUQu6kobU9-b2-8O460rg6icT18NpJdnQzh1Rw@mail.gmail.com>
 <02935a30-7b67-5878-ce25-f2276aeea0a8@siemens.com>
 <CAMDn9+Rxc=H=0R46YK0CgbNLHQZuF8N=_KY-7S-87rY+r86zHw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <56335a02-69dd-32ed-5c1b-9df7b1a4b760@siemens.com>
Date: Mon, 10 May 2021 09:35:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAMDn9+Rxc=H=0R46YK0CgbNLHQZuF8N=_KY-7S-87rY+r86zHw@mail.gmail.com>
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
To: Fangsuo Wu <tiger20081015@gmail.com>
Cc: xenomai@xenomai.org

On 10.05.21 09:20, Fangsuo Wu wrote:
> Jan,
> Thanks for your reply. The environment I used is listed below. BTW, I
> can run latency test successfully.
> 
> 1. The revision of Xenomai: xenomai-3.1.tar.bz2
> 2. Soc: dual ARM cortex A7
> 3. How I built application libraries:
>     ./configure CFLAGS="-march=armv7-a -mfpu=vfp3"
> LDFLAGS="-march=armv7-a -mfpu=vfp3"   --build=i686-pc-linux-gnu
> --host=arm-linux-gnueabihf --with-core=cobalt --enable-smp
> --enable-pshared
>    make DESTDIR=/home/data/nfs_test/ install
> 4. The kernel I used is 4.19 so I applied
> ipipe-core-4.19.55-arm-5.patch, and manually enabled
> CONFIG_IPIPE_ARM_KUSER_TSC. The full config file is:
> 

OK - our qemu-armhf target [1] is multicore A7 as well. Do you see the
problem in QEMU, too? Do any of the extra CFLAGS or LDFLAGS you pass
play a role here? We compile in CI only with "--enable-smp
--enable-lazy-setsched --enable-debug=symbols" - maybe "--enable-pshared"...

Jan

[1] https://source.denx.de/Xenomai/xenomai-images/-/jobs/265962#L387

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


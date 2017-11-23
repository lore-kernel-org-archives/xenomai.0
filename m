References: <d3f6995a-1d45-d262-21a0-97a51253da91@alaxarxa.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e665e5ab-796f-8aac-997c-33b88079d27c@xenomai.org>
Date: Thu, 23 Nov 2017 13:22:37 +0100
MIME-Version: 1.0
In-Reply-To: <d3f6995a-1d45-d262-21a0-97a51253da91@alaxarxa.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cannot initialize TLSF memory manager
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/23/2017 01:10 PM, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> 
> I have seen this bug before, but it seems that it's again in 3.0.6. Running
> 3.0.6 with:
> 
>  xeno-config --info
> Xenomai version: Xenomai/cobalt v3.0.6
> Linux bmm3 4.9.51-xenomai-3.0.6-ipipe #1 SMP Thu Nov 23 09:03:27 CET 2017 x86_64
> GNU/Linux
> Kernel parameters: BOOT_IMAGE=/boot/vmlinuz-4.9.51-xenomai-3.0.6-ipipe
> root=UUID=ab96eed9-cd79-4d30-9e93-e9f32a18cca6 ro quiet
> xenomai.allowed_group=113 nosmap
> I-pipe release #4 detected
> Cobalt core 3.0.6 detected
> Compiler: gcc version 6.3.0 20170516 (Debian 6.3.0-18)
> Build args: --build=x86_64-linux-gnu --includedir=/usr/include
> --mandir=/usr/share/man --infodir=/usr/share/info --sysconfdir=/etc
> --localstatedir=/var --disable-silent-rules --libdir=/usr/lib/x86_64-linux-gnu
> --libexecdir=/usr/lib/x86_64-linux-gnu --disable-maintainer-mode
> --disable-dependency-tracking --prefix=/usr --includedir=/usr/include/xenomai
> --mandir=/usr/share/man --with-testdir=/usr/lib/x86_64-linux-gnu/xenomai
> --enable-fortify --libdir=/usr/lib/x86_64-linux-gnu/ --enable-pshared
> --enable-registry --enable-doc-build --enable-dlopen-libs --enable-tls
> --enable-smp --with-core=cobalt --build x86_64-linux-gnu
> build_alias=x86_64-linux-gnu CFLAGS=-g -O2
> -fdebug-prefix-map=/build/xenomai-3.0.6+ds1=. -fstack-protector-strong -Wformat
> -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -fno-omit-frame-pointer
> LDFLAGS=-Wl,-z,relro -Wl,-z,now -Wl,--as-needed CPPFLAGS=-Wdate-time
> -D_FORTIFY_SOURCE=2
> 
> 
> 
> when I try xeno-test, I got:
> 
>  xeno-test
> Started child 2593: /bin/bash
> /usr/lib/x86_64-linux-gnu/xenomai/xeno-test-run-wrapper /usr/bin/xeno-test
> ++ echo 0
> ++ testdir=/usr/lib/x86_64-linux-gnu/xenomai
> ++ /usr/lib/x86_64-linux-gnu/xenomai/smokey --run
> init_memory_pool(): invalid pool
>    0"000.022| BUG in heapobj_pkg_init_private(): [main] cannot initialize TLSF
> memory manager
> 
> 
> Any idea?
> 

Can you check whether the call to tlsf_malloc() in
heapobj_pkg_init_private() returns non-NULL?
(lib/copperplate/heapobj-tlsf.c), and print out the value of alloc_size too?

Thanks,

-- 
Philippe.


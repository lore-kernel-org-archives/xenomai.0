MIME-Version: 1.0
Sender: patrickdepinguin@domain.hid
In-Reply-To: <1317462819.2190.1.camel@domain.hid>
References: <CAAXf6LXwqMUOrmHQX4O6hk2ar95Sym8A9vu9MSBtjE4G6Sq0ag@domain.hid>
	<1317462819.2190.1.camel@domain.hid>
Date: Mon, 3 Oct 2011 17:03:49 +0200
Message-ID: <CAAXf6LW68rkURbZPrWeuw2zYwSwcFQv3r5DdRrrJfP9=7TKZdw@domain.hid>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai-forge: cast to pointer from integer of
 different size
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-help@domain.hid

Hi Philippe,

On Sat, Oct 1, 2011 at 11:53 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Fri, 2011-09-30 at 21:53 +0200, Thomas De Schampheleire wrote:
>> Hi,
>>
>> I'm trying to compile xenomai-forge on powerpc, but am facing
>> compilation problems:
>>
>> libtool: compile:
>> /repo/tdescham/reborn/buildroot-08-eglibc-test-toolchain/output/host/usr=
/bin/powerpc-linux-gcc
>> -DHAVE_CONFIG_H -I. -I../../lib/include -O2 -D_GNU_SOURCE -D_REENTRANT
>> -Wall -pipe -Wstrict-prototypes -Wmissing-prototypes -Wno-long-long
>> -Wno-unused-parameter -Werror -D__XENO__ -D__IN_XENO__
>> -Wstrict-prototypes -I../../include -pipe -Os -D_LARGEFILE_SOURCE
>> -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -MT
>> libcopperplate_la-cluster.lo -MD -MP -MF
>> .deps/libcopperplate_la-cluster.Tpo -c cluster.c =A0-fPIC -DPIC -o
>> .libs/libcopperplate_la-cluster.o
>> cc1: warnings being treated as errors
>> In file included from cluster.c:89:
>> ../../include/copperplate/heapobj.h: In function 'mainheap_ptr':
>> ../../include/copperplate/heapobj.h:82: error: cast to pointer from
>> integer of different size
>> ../../include/copperplate/heapobj.h: In function 'mainheap_off':
>> ../../include/copperplate/heapobj.h:87: error: cast from pointer to
>> integer of different size
>> cc1: warnings being treated as errors
>>
>> The C library we are using for this build is eglibc.
>>
>> The offending code is:
>> static inline void *mainheap_ptr(off_t off)
>> {
>> =A0 =A0 =A0 =A0 return off ? (void *)__memptr(__pshared_heap, off) : NUL=
L;
>> }
>>
>> static inline off_t mainheap_off(void *addr)
>> {
>> =A0 =A0 =A0 =A0 return addr ? (off_t)__memoff(__pshared_heap, addr) : 0;
>> }
>>
>> Since glibc/eglibc has large file support, the size of off_t is 8
>> bytes (I confirmed this from the preprocessor output).
>> However, on this 32-bit powerpc platform, a void pointer is only 4
>> bytes, hence the compiler error.
>>
>> Is my assumption correct that you are developing xenomai-forge on a
>> 64-bit platform?
>>
>
> Both on ppc 32bit and x86_64, but my ppc toolchain does not enable large
> file support.
>
>> What is the proper solution here?
>
> Use a specific memory offset type would be the best approach. I have
> committed something along these lines to the repo.

Thanks, these changes compile without problem.

Best regards,
Thomas


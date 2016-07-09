MIME-Version: 1.0
In-Reply-To: <20160708205055.GU9465@hermes.click-hack.org>
References: <CAPXCTbbQ1Lo7voRB1sVOtnZ0yjwhZBgUnzi1YX2rv_CL1z8f0g@mail.gmail.com>
 <20160708194905.GQ9465@hermes.click-hack.org>
 <CAPXCTbYJ_rQnvdU7srw1oGL6R0c7vJmMF+u_T7d-zgkZ1yLCXg@mail.gmail.com>
 <20160708203405.GS9465@hermes.click-hack.org>
 <CAPXCTbai+OJHRkt=x5qxrQNa+dsmN8aNpcgxSmygsqW7rqibXQ@mail.gmail.com>
 <20160708205055.GU9465@hermes.click-hack.org>
From: Eder Alves de Moura <edermoura@gmail.com>
Date: Fri, 8 Jul 2016 21:04:23 -0300
Message-ID: <CAPXCTbaKXWin12_EOs8SXX_2t7w4naUjymniXBOUkTrAVfTtJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Compiling testsuite and utils
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Running:

xenomai-3-3.0.2/build$ ../configure --with-core=3Dcobalt --enable-smp
--enable-pshared
configure: error: cannot find install-sh, install.sh, or shtool in
config ".."/config


checking whether we build for Cobalt or Mercury core... cobalt
checking build system type... x86_64-pc-linux-gnu
checking host system type... x86_64-pc-linux-gnu
checking for a BSD-compatible install... /usr/bin/install -c
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking whether gcc understands -c and -o together... yes
checking how to run the C preprocessor... gcc -E
checking target system type... x86_64-pc-linux-gnu
checking for gcc... gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... (cached) none needed
checking whether gcc understands -c and -o together... (cached) yes
checking how to run the C preprocessor... gcc -E
checking for grep that handles long lines and -e... /bin/grep
../configure: line 4500: LT_PATH_NM: command not found
../configure: line 4503: LT_SYS_SYMBOL_USCORE: command not found
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for style of include used by make... GNU
checking whether make supports nested variables... yes
configure: error: source directory already configured; run "make
distclean" there first



But executing make distclean doesn't work also.

2016-07-08 17:50 GMT-03:00 Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org>:
> On Fri, Jul 08, 2016 at 05:47:40PM -0300, Eder Alves de Moura wrote:
>> - do you really want to compile a 32 bits version of Xenomai?
>>
>> no. I am not want to compile it to a specific 32 bits.
>
> The run configure without a --host or CFLAGS, or LDFLAGS. The
> defaults should be fine.
>
> --
>                                             Gilles.
> https://click-hack.org



--=20
--------------------------------------------------
=C3=89der Alves de Moura


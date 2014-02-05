Message-ID: <52F2983E.5080505@xenomai.org>
Date: Wed, 05 Feb 2014 20:59:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52F27AAD.8050809@siemens.com>
In-Reply-To: <52F27AAD.8050809@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] forge: --enable-pshared broken?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 02/05/2014 06:53 PM, Jan Kiszka wrote:
> Hi,
> 
> trying to test a --enable-pshared build gives me this linker error:
> 
> libtool: link: ../../../scripts/wrap-link.sh gcc -g -o .libs/check-vdso
> check_vdso-check-vdso.o  ../../lib/cobalt/.libs/libcobalt.so -lfuse
> -lpthread -lrt -lm -Wl,-rpath -Wl,/data/xenomai-forge/inst64/lib
> ../../lib/cobalt/.libs/libcobalt.so: undefined reference to `__main_heap'
> 
> Is this known/reproducible?

I get the same issue with cobalt, when linking the "latency" test, which
in my tree uses the posix api.

-- 
                                                                Gilles.


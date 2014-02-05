Message-ID: <52F27AAD.8050809@siemens.com>
Date: Wed, 05 Feb 2014 18:53:49 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] forge: --enable-pshared broken?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

trying to test a --enable-pshared build gives me this linker error:

libtool: link: ../../../scripts/wrap-link.sh gcc -g -o .libs/check-vdso
check_vdso-check-vdso.o  ../../lib/cobalt/.libs/libcobalt.so -lfuse
-lpthread -lrt -lm -Wl,-rpath -Wl,/data/xenomai-forge/inst64/lib
../../lib/cobalt/.libs/libcobalt.so: undefined reference to `__main_heap'

Is this known/reproducible?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux


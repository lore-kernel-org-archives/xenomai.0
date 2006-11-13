Message-ID: <822467320611121613u2cbcd224nc3afedd43d4b4463@domain.hid>
Date: Sun, 12 Nov 2006 17:13:05 -0700
From: "Terry Laurenzo" <tlaurenzo@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_78749_8614347.1163376785914"
Subject: [Xenomai-core] Undefined reference to ___wrap_pthread_mutex_lock
	and friends on Blackfin
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_78749_8614347.1163376785914
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello.  I'm new to this list and new to Xenomai.  I am getting the
following when trying to build Xenomai 2.2.3:

-------------
cyclictest.elf2flt(.text+0x4946): In function `_pthread_key_delete':
: undefined reference to `___wrap_pthread_mutex_lock'
cyclictest.elf2flt(.text+0x4970): In function `_pthread_key_delete':
: undefined reference to `___wrap_pthread_mutex_unlock'
cyclictest.elf2flt(.text+0x49c8): In function `_pthread_key_delete':
: undefined reference to `___wrap_pthread_mutex_unlock'
cyclictest.elf2flt(.text+0x49e8): In function `_pthread_key_create':
: undefined reference to `___wrap_pthread_mutex_lock'
cyclictest.elf2flt(.text+0x4a10): In function `_pthread_key_create':
: undefined reference to `___wrap_pthread_mutex_unlock'
cyclictest.elf2flt(.text+0x4a2e): In function `_pthread_key_create':
: undefined reference to `___wrap_pthread_mutex_unlock'
collect2: ld returned 1 exit status
-------------

The problem seems to be that the version of libpthread.a that I am
using makes reference to the pthread_mutex_lock and
pthread_mutex_unlock functions from a couple of places including
pthread_key_create and pthread_key_delete.

Since the Posix testsuite programs link libpthread after
libpthread_rt, these references (which are defined in libpthread_rt)
cannot be resolved.  I don't know if these calls are recent additions
or what, but the uClibc/libpthread and libpthread_rt libraries are
mutually dependent on each other.

I don't know enough about what is going on with the Xenomai Posix skin
to figure out the right way to fix this problem, but the attached
patch fixes the build failures by passing the --start-group linker
flag, forcing ld to resolve circular references for all subsequent
object files.    I know it's not great but it gets me going.  You have
to rerun automake to get the changes.

Applying the patch makes it build but the testsuites for the Posix
skin don't seem to work.  For example, here is what I get when trying
to run cyclictest:
  root:/usr/xenomai/testsuite/cyclic> ./cyclictest
  Xenomai Posix skin init: pthread_atfork: Unknown error -1

The native testsuites seem to function as expected.

Does anyone have any ideas what the issue is?

Here is my platform specs:
   - Blackfin BF537-STAMP
   - uClinux R06R1-RC2 with corresponding toolchain
   - gcc4.1.0

Xenomai configure was run per the README like so:
$XENOMAI_DIR/configure --build=i686-pc-linux-gnu
--host=bfinnommu-unknown-linux-gnu CC=bfin-uclinux-gcc
CXX=bfin-uclinux-gcc AR=bfin-uclinux-ar LD=bfin-uclinux-ld
--disable-shared

Also, it would appear that Xenomai releases post 2.2.3 will not run on
an unpatched uClinux R06R1-RC2.  The problem seems to be that some
macros were added to the newer kernel for addressing various
peripherals.  Xenomai > 2.2.3 uses these macros which are not defined
in this official uClinux release.  It would be nice to note something
to this effect in the readme.

Thanks!

-- 

Regards,
Terry Laurenzo
Redcode Technologies

------=_Part_78749_8614347.1163376785914
Content-Type: text/x-patch; name="xenomai-2.2.3.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="xenomai-2.2.3.patch"
X-Attachment-Id: f_eug4hmd3

ZGlmZiAtTmF1ciB4ZW5vbWFpLTIuMi4zLm9yaWcvc3JjL3Rlc3RzdWl0ZS9jeWNsaWMvTWFrZWZp
bGUuYW0geGVub21haS0yLjIuMy9zcmMvdGVzdHN1aXRlL2N5Y2xpYy9NYWtlZmlsZS5hbQotLS0g
eGVub21haS0yLjIuMy5vcmlnL3NyYy90ZXN0c3VpdGUvY3ljbGljL01ha2VmaWxlLmFtCTIwMDYt
MDktMTUgMDg6MTg6MDguMDAwMDAwMDAwIC0wNjAwCisrKyB4ZW5vbWFpLTIuMi4zL3NyYy90ZXN0
c3VpdGUvY3ljbGljL01ha2VmaWxlLmFtCTIwMDYtMTEtMTIgMTY6NTk6NTkuMDAwMDAwMDAwIC0w
NzAwCkBAIC02LDcgKzYsNyBAQAogCiBjeWNsaWN0ZXN0X0NQUEZMQUdTID0gLUkkKHRvcF9zcmNk
aXIpL2luY2x1ZGUvcG9zaXggJChYRU5PX1VTRVJfQ0ZMQUdTKSAtRElQSVBFX1RSQUNFPTEgLUkk
KHRvcF9zcmNkaXIpL2luY2x1ZGUKIAotY3ljbGljdGVzdF9MREZMQUdTID0gJChYRU5PX1BPU0lY
X1dSQVBQRVJTKSAkKFhFTk9fVVNFUl9MREZMQUdTKQorY3ljbGljdGVzdF9MREZMQUdTID0gJChY
RU5PX1BPU0lYX1dSQVBQRVJTKSAkKFhFTk9fVVNFUl9MREZMQUdTKSAtV2wsLS1zdGFydC1ncm91
cAogCiBjeWNsaWN0ZXN0X0xEQUREID0gXAogCS4uLy4uL3NraW5zL3Bvc2l4Ly5saWJzL2xpYnB0
aHJlYWRfcnQuYSAtbHB0aHJlYWQgLWxydApkaWZmIC1OYXVyIHhlbm9tYWktMi4yLjMub3JpZy9z
cmMvdGVzdHN1aXRlL2lycWJlbmNoL01ha2VmaWxlLmFtIHhlbm9tYWktMi4yLjMvc3JjL3Rlc3Rz
dWl0ZS9pcnFiZW5jaC9NYWtlZmlsZS5hbQotLS0geGVub21haS0yLjIuMy5vcmlnL3NyYy90ZXN0
c3VpdGUvaXJxYmVuY2gvTWFrZWZpbGUuYW0JMjAwNi0wOS0xNSAwODoxODowOC4wMDAwMDAwMDAg
LTA2MDAKKysrIHhlbm9tYWktMi4yLjMvc3JjL3Rlc3RzdWl0ZS9pcnFiZW5jaC9NYWtlZmlsZS5h
bQkyMDA2LTExLTEyIDE2OjU3OjQwLjAwMDAwMDAwMCAtMDcwMApAQCAtMTYsNyArMTYsNyBAQAog
CiBpcnFsb29wX0xERkxBR1MgPSBcCiAJJChYRU5PX1BPU0lYX1dSQVBQRVJTKSBcCi0JJChYRU5P
X1VTRVJfTERGTEFHUykKKwkkKFhFTk9fVVNFUl9MREZMQUdTKSAtV2wsLS1zdGFydC1ncm91cAog
CiBpcnFsb29wX0xEQUREID0gXAogCS4uLy4uL3NraW5zL3Bvc2l4Ly5saWJzL2xpYnB0aHJlYWRf
cnQuYSAtbHB0aHJlYWQKZGlmZiAtTmF1ciB4ZW5vbWFpLTIuMi4zLm9yaWcvc3JjL3Rlc3RzdWl0
ZS9zd2l0Y2h0ZXN0L01ha2VmaWxlLmFtIHhlbm9tYWktMi4yLjMvc3JjL3Rlc3RzdWl0ZS9zd2l0
Y2h0ZXN0L01ha2VmaWxlLmFtCi0tLSB4ZW5vbWFpLTIuMi4zLm9yaWcvc3JjL3Rlc3RzdWl0ZS9z
d2l0Y2h0ZXN0L01ha2VmaWxlLmFtCTIwMDYtMDktMTcgMDg6NTk6MjkuMDAwMDAwMDAwIC0wNjAw
CisrKyB4ZW5vbWFpLTIuMi4zL3NyYy90ZXN0c3VpdGUvc3dpdGNodGVzdC9NYWtlZmlsZS5hbQky
MDA2LTExLTEyIDE2OjU3OjQwLjAwMDAwMDAwMCAtMDcwMApAQCAtNiw3ICs2LDcgQEAKIAogc3dp
dGNodGVzdF9DUFBGTEFHUyA9IC1JJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL3Bvc2l4ICQoWEVOT19V
U0VSX0NGTEFHUykgLWcgLUkkKHRvcF9zcmNkaXIpL2luY2x1ZGUKIAotc3dpdGNodGVzdF9MREZM
QUdTID0gICQoWEVOT19QT1NJWF9XUkFQUEVSUykgJChYRU5PX1VTRVJfTERGTEFHUykKK3N3aXRj
aHRlc3RfTERGTEFHUyA9ICAkKFhFTk9fUE9TSVhfV1JBUFBFUlMpICQoWEVOT19VU0VSX0xERkxB
R1MpIC1XbCwtLXN0YXJ0LWdyb3VwCiAKIHN3aXRjaHRlc3RfTERBREQgPSBcCiAJLi4vLi4vc2tp
bnMvcG9zaXgvLmxpYnMvbGlicHRocmVhZF9ydC5hCS1scHRocmVhZCAtbHJ0Cgo=
------=_Part_78749_8614347.1163376785914--


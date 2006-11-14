Message-ID: <4546494d0611131932q480046e0vfa092f4eaa15f7b5@domain.hid>
Date: Tue, 14 Nov 2006 11:32:11 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_114938_19904353.1163475131985"
Subject: [Xenomai-core] [PATCH]Build xenomai on Blackfin in FDPIC format
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

------=_Part_114938_19904353.1163475131985
Content-Type: multipart/alternative; 
	boundary="----=_Part_114939_28343387.1163475131985"

------=_Part_114939_28343387.1163475131985
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Philippe,

Since bfin-gcc release 2006-R1, bfin-gcc begins to support "FDPIC" format
besides "BFLT".
"FDPIC" supports shared library. Bellow patch makes it possible to build
xenomai-2.2.5 in FDPIC
format. In docs.blackfin.uclinux.org/doku.php?id=adeos there is step by step
guide.

Although it is still possible to build xenomai as BFLT in this way:

configure --host=bfin CC=bfin-uclinux-gcc LDFLAGS=-Wl,-elf2flt
--disable-shared

There will be error:

 bfin-uclinux-gcc -Wl,-elf2flt -o cyclictest
-Wl,@/home/adam/workspace/xenomai/xenomai_src/xenomai-2.2.5/src/skins/posix/posix.wrappers
cyclictest-cyclictest.o  ../../skins/posix/.libs/libpthread_rt.a -lpthread
-lrt
/home/adam/workspace/toolchain/1110/bfin-uclinux/bin/../lib/gcc/bfin-uclinux/4.1.1/../../../../bfin-uclinux/lib/libpthread.a(
specific.o): In function `_pthread_key_delete':
(.text+0x24e): undefined reference to `___wrap_pthread_mutex_lock'
/home/adam/workspace/toolchain/1110/bfin-uclinux/bin/../lib/gcc/bfin-uclinux/4.1.1/../../../../bfin-uclinux/lib/libpthread.a(
specific.o): In function `_pthread_key_delete':

And this can be fixed like:

bfin-uclinux-gcc -Wl,-elf2flt -o cyclictest
-Wl,@/home/adam/workspace/xenomai/xenomai_src/xenomai-2.2.5/src/skins/posix/posix.wrappers
cyclictest-cyclictest.o -lpthread -lrt
../../skins/posix/.libs/libpthread_rt.a

But using "FDPIC" format is suggested.

Thanks,

-Yi

------=_Part_114939_28343387.1163475131985
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Philippe,<br><br>Since bfin-gcc release 2006-R1, bfin-gcc begins to support &quot;FDPIC&quot; format besides &quot;BFLT&quot;.<br>&quot;FDPIC&quot; supports shared library. Bellow patch makes it possible to build xenomai-2.2.5
 in FDPIC<br>format. In <a href="http://docs.blackfin.uclinux.org/doku.php?id=adeos">docs.blackfin.uclinux.org/doku.php?id=adeos</a> there is step by step guide.<br><br>Although it is still possible to build xenomai as BFLT in this way:
<br><br>configure --host=bfin CC=bfin-uclinux-gcc LDFLAGS=-Wl,-elf2flt --disable-shared<br><br>There will be error:<br><br>&nbsp;bfin-uclinux-gcc -Wl,-elf2flt -o cyclictest -Wl,@/home/adam/workspace/xenomai/xenomai_src/xenomai-
2.2.5/src/skins/posix/posix.wrappers cyclictest-cyclictest.o&nbsp; ../../skins/posix/.libs/libpthread_rt.a -lpthread -lrt<br>/home/adam/workspace/toolchain/1110/bfin-uclinux/bin/../lib/gcc/bfin-uclinux/4.1.1/../../../../bfin-uclinux/lib/libpthread.a(
specific.o): In function `_pthread_key_delete':<br>(.text+0x24e): undefined reference to `___wrap_pthread_mutex_lock'<br>/home/adam/workspace/toolchain/1110/bfin-uclinux/bin/../lib/gcc/bfin-uclinux/4.1.1/../../../../bfin-uclinux/lib/libpthread.a(
specific.o): In function `_pthread_key_delete':<br><br>And this can be fixed like:<br><br>bfin-uclinux-gcc -Wl,-elf2flt -o cyclictest -Wl,@/home/adam/workspace/xenomai/xenomai_src/xenomai-2.2.5/src/skins/posix/posix.wrappers 
cyclictest-cyclictest.o -lpthread -lrt ../../skins/posix/.libs/libpthread_rt.a<br><br>But using &quot;FDPIC&quot; format is suggested.<br><br>Thanks,<br><br>-Yi<br>

------=_Part_114939_28343387.1163475131985--

------=_Part_114938_19904353.1163475131985
Content-Type: text/x-patch; name=xenomai_2.2.5_bfin.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_euhqp08p
Content-Disposition: attachment; filename="xenomai_2.2.5_bfin.patch"

ZGlmZiAtTnVyIHhlbm9tYWktMi4yLjUub3JpZy9jb25maWd1cmUgeGVub21haS0yLjIuNS9jb25m
aWd1cmUKLS0tIHhlbm9tYWktMi4yLjUub3JpZy9jb25maWd1cmUJMjAwNi0xMS0wNSAyMzozMTo0
Ni4wMDAwMDAwMDAgKzA4MDAKKysrIHhlbm9tYWktMi4yLjUvY29uZmlndXJlCTIwMDYtMTEtMTQg
MTE6MTU6NDcuMDAwMDAwMDAwICswODAwCkBAIC0yMTE2Myw5ICsyMTE2Myw2IEBACiAgICAgICAg
IDs7CiAgYmxhY2tmaW4pCiAJWEVOT19VU0VSX0NGTEFHUz0iJFhFTk9fVVNFUl9DRkxBR1MgLVdh
bGwgLXBpcGUiCi0JIyB1Q2xpbnV4IHdhbnRzIGZsYXQgZm9ybWF0IGV4ZWN1dGFibGVzOyBhc3N1
bWUgdGhhdCBvdXIKLQkjIHNvdXJjZSBmb3JtYXQgaXMgRUxGLgotCVhFTk9fVVNFUl9MREZMQUdT
PSItV2wsLWVsZjJmbHQiCiAgICAgICAgIDs7CiAgYXJtKQogCVhFTk9fVVNFUl9DRkxBR1M9IiRY
RU5PX1VTRVJfQ0ZMQUdTIC1XYWxsIC1waXBlIgpkaWZmIC1OdXIgeGVub21haS0yLjIuNS5vcmln
L2NvbmZpZ3VyZS5pbiB4ZW5vbWFpLTIuMi41L2NvbmZpZ3VyZS5pbgotLS0geGVub21haS0yLjIu
NS5vcmlnL2NvbmZpZ3VyZS5pbgkyMDA2LTA5LTI0IDIyOjUwOjEwLjAwMDAwMDAwMCArMDgwMAor
KysgeGVub21haS0yLjIuNS9jb25maWd1cmUuaW4JMjAwNi0xMS0xNCAxMToxNToyMC4wMDAwMDAw
MDAgKzA4MDAKQEAgLTUzNiw5ICs1MzYsNiBAQAogICAgICAgICA7OwogIGJsYWNrZmluKQogCVhF
Tk9fVVNFUl9DRkxBR1M9IiRYRU5PX1VTRVJfQ0ZMQUdTIC1XYWxsIC1waXBlIgotCSMgdUNsaW51
eCB3YW50cyBmbGF0IGZvcm1hdCBleGVjdXRhYmxlczsgYXNzdW1lIHRoYXQgb3VyCi0JIyBzb3Vy
Y2UgZm9ybWF0IGlzIEVMRi4KLQlYRU5PX1VTRVJfTERGTEFHUz0iLVdsLC1lbGYyZmx0IgogICAg
ICAgICA7OwogIGFybSkKIAlYRU5PX1VTRVJfQ0ZMQUdTPSIkWEVOT19VU0VSX0NGTEFHUyAtV2Fs
bCAtcGlwZSIKZGlmZiAtTnVyIHhlbm9tYWktMi4yLjUub3JpZy9SRUFETUUuSU5TVEFMTCB4ZW5v
bWFpLTIuMi41L1JFQURNRS5JTlNUQUxMCi0tLSB4ZW5vbWFpLTIuMi41Lm9yaWcvUkVBRE1FLklO
U1RBTEwJMjAwNi0wNy0xOCAyMToxOToxNy4wMDAwMDAwMDAgKzA4MDAKKysrIHhlbm9tYWktMi4y
LjUvUkVBRE1FLklOU1RBTEwJMjAwNi0xMS0xNCAxMToxMzowNi4wMDAwMDAwMDAgKzA4MDAKQEAg
LTI3MCwxMiArMjcwLDkgQEAKICQgbWFrZSBBUkNIPWJmaW5ub21tdSBDUk9TU19DT01QSUxFPWJm
aW4tdWNsaW51eC0geGNvbmZpZy9nY29uZmlnL21lbnVjb25maWcgIyBzZWxlY3QgdGhlIGtlcm5l
bCBhbmQgWGVub21haSBvcHRpb25zCiAkIG1ha2UgQVJDSD1iZmlubm9tbXUgQ1JPU1NfQ09NUElM
RT1iZmluLXVjbGludXgtIGJ6SW1hZ2UgbW9kdWxlcyAjIHRoZW4gaW5zdGFsbCBhcyBuZWVkZWQK
ICQgbWtkaXIgJGJ1aWxkX3Jvb3QgJiYgY2QgJGJ1aWxkX3Jvb3QKLSQgJHhlbm9tYWlfcm9vdC9j
b25maWd1cmUgLS1idWlsZD1pNjg2LXBjLWxpbnV4LWdudSAtLWhvc3Q9YmZpbm5vbW11LXVua25v
d24tbGludXgtZ251IENDPWJmaW4tdWNsaW51eC1nY2MgQ1hYPWJmaW4tdWNsaW51eC1nY2MgQVI9
YmZpbi11Y2xpbnV4LWFyIExEPWJmaW4tdWNsaW51eC1sZCAtLWRpc2FibGUtc2hhcmVkCiskICR4
ZW5vbWFpX3Jvb3QvY29uZmlndXJlIC0taG9zdD1iZmluIENDPWJmaW4tdWNsaW51eC1nY2MgQ0ZM
QUdTPS1tZmRwaWMgCiAkIG1ha2UgaW5zdGFsbAogCi1DQVVUSU9OOiBub3RlIHRoZSAtLWRpc2Fi
bGVkLXNoYXJlZCBmbGFnIGNvbmZpZ3VyaW5nIG91dCB0aGUgc2hhcmVkCi1saWJyYXJ5IHN1cHBv
cnQsIHdoaWNoIGlzIHVuYXZhaWxhYmxlIGZvciB0aGlzIGFyY2hpdGVjdHVyZS4KLQogWW91IG1h
eSBhbHNvIHdhbnQgdG8gaGF2ZSBhIGxvb2sgYXQgdGhpcyBoYW5kcy1vbiBkZXNjcmlwdGlvbiBh
Ym91dAogY29uZmlndXJpbmcgYW5kIGJ1aWxkaW5nIGEgWGVub21haSBzeXN0ZW0gZm9yIHRoZSBC
bGFja2ZpbgogYXJjaGl0ZWN0dXJlOiBodHRwOi8vZG9jcy5ibGFja2Zpbi51Y2xpbnV4Lm9yZy9k
b2t1LnBocD9pZD1hZGVvcwo=
------=_Part_114938_19904353.1163475131985--


Date: Thu, 29 Mar 2018 15:11:44 +0300 (EEST)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <287223691.8750502.1522325504217.JavaMail.zimbra@triolcorp.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] x86 unusual IRQ number on UDOO board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>
Cc: Olej <o.tsiliuric@yandex.ru>

Good day=20

CPU0 CPU1 CPU2 CPU3=20
0: 15 1 0 0 IO-APIC 2-edge timer=20
9: 0 0 0 0 IO-APIC 9-fasteoi acpi, INT0002=20
32: 0 0 0 0 IO-APIC 32-fasteoi 808622C1:00=20
37: 0 0 0 0 IO-APIC 37-fasteoi 808622C1:05=20
42: 0 0 0 0 IO-APIC 42-fasteoi dw:dmac-1=20
43: 0 0 0 0 IO-APIC 43-fasteoi dw:dmac-1=20
45: 3446 136249 69996 69930 IO-APIC 45-fasteoi mmc0=20
47: 0 0 0 0 IO-APIC 47-fasteoi mmc1=20

it is seems very unusual=20
does Xenomai work good with such IRQ numbers ?=20


304: 1 0 0 0 chv-gpio 50 80860F14:01 cd=20
309: 26 24943 873 302 PCI-MSI 327680-edge xhci_hcd=20
310: 15 11904 14 14 PCI-MSI 1048576-edge enp2s0=20
311: 0 0 0 0 PCI-MSI 311296-edge ahci[0000:00:13.0]=20
312: 395 394 220882 417 PCI-MSI 32768-edge i915=20
313: 0 0 0 0 INT0002 Virtual GPIO 2 ACPI:Event=20
314: 7 6 5 5 PCI-MSI 425984-edge mei_txe=20
315: 329 391 365 361 PCI-MSI 442368-edge snd_hda_intel:card0=20

=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,=20
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.=20

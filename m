Message-ID: <1342430162.7582.YahooMailNeo@web120606.mail.ne1.yahoo.com>
Date: Mon, 16 Jul 2012 02:16:02 -0700 (PDT)
From: Jignesh Patel <jigneshj.patel@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenomai 2.6.1 compiler error
Reply-To: Jignesh Patel <jigneshj.patel@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "rgupta108@gmail.com" <rgupta108@gmail.com>, "patelilesh32@gmail.com" <patelilesh32@gmail.com>

hi,=0A=0AI'm trying to compile Xenomai 2.6.1 with kernel 3.2.21 that time i=
t generate following error... =0A=0A=0ACC =A0 =A0 =A0kernel/xenomai/nucleus=
/heap.o=0A=A0CC =A0 =A0=0A =A0kernel/xenomai/nucleus/intr.o=0A=A0CC =A0 =A0=
 =A0kernel/xenomai/nucleus/pod.o=0AIn=0A file included from /usr/src/linux-=
3.2.21/arch/x86/include/asm/xenomai/switch.h:2:0,=0A=A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 from /usr/src/linux-3.2.21/arch/x86/include/asm/xenomai/bits/pod_3=
2.h:27,=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from /usr/src/linux-3.2.21/arch/x=
86/include/asm/xenomai/bits/pod.h:2,=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from=
 kernel/xenomai/nucleus/pod.c:47:=0A/usr/src/linux-3.2.21/arch/x86/include/=
asm/xenomai/switch_32.h:30:2: warning: #warning "Buffer overflow detection =
not supported in 32bit =0Amode" [-Wcpp]=0A/usr/src/linux-3.2.21/arch/x86/in=
clude/asm/xenomai/switch_32.h:31:2: error: #error "Disable CONFIG_CC_STACKP=
ROTECTOR in your kernel =0Aconfiguration"=0Amake[3]: * [kernel/xenomai/nucl=
eus/pod.o] =0AError 1=0Amake[2]: * [kernel/xenomai/nucleus] Error 2=0Amake[=
1]: * [kernel/xenomai] Error 2=0Amake: * [kernel] Error 2=0A=0A=0Ahow i can=
 enable CONFIG_CC_STACKPROTECTOR in my kernel configuration???=0A

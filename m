MIME-Version: 1.0
Date: Mon, 20 Jan 2014 09:31:04 +0100
Message-ID: <CANKLDmv_hfbVcWzoxjerWOTEWqEWPnQzUu44GF=SbC0iSopDOg@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] xnarch_xchg infinite loop
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,

We have the problem that (hot-)rebooting our Xenomai system fails every 1
out of 10 times.

The system is an ARM iMX6Solo (Cortex-A9) running Xenomai 2.6.2.1 and
kernel 3.0 (freescale branch).

When the system hangs at reboot, it is in an infinite loop in the Xenomai
atomic exchange implementation, with STREX always returning 1:

__xnarch_xchg
S:0xC0094B2C : ADD      r3,r6,#0x890
S:0xC0094B30 : LDREX    r2,[r3]
S:0xC0094B34 : STREX    r1,r9,[r3]
S:0xC0094B38 : TEQ      r1,#0
S:0xC0094B3C : BNE      {pc}-0xc ; 0xc0094b30

Does anyone know what is causing the STREX to always return 0 and why it
might get into this state?
Is there a workaround for this problem?

Any help is appreciated!

Thanks,
Henri

From: "PRADHAN, MAKARAND (RC-CA)" <makarand.pradhan@siemens.com>
Date: Tue, 5 Aug 2014 20:33:28 +0000
Message-ID: <B89CCBE86D4F62448EE4F6367C6D3C891DACCB0F@USMLVA0EM24MSX.ww017.siemens.net>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Question regarding rt_sem_p
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi All,

I am facing a unique problem related to Semaphores and would appreciate any=
 suggestions that you may have.

My system:
CPU: DRA7xx (Arch: arm. Texas Inst, OMAP based SOC with Dual Core A-15s)
Linux: 3.12-1

rt_sem_p is returning ENOSYS after some time only while running under GDB. =
When I run without GDB everything seems to work. The timeout used is TM_INF=
INITE. I've tried to dig into the Xenomai user space and the kernel code to=
 see where ENOSYS may be returned by rt_sem_p. All the same, I have not bee=
n successful in identifying the root cause.

Any opinions/views?

Thanks and Rgds,
Makarand.

This message and any attachments are solely for the use of intended recipie=
nts. The information contained herein may include trade secrets, protected =
health or personal information, privileged or otherwise confidential inform=
ation. Unauthorized review, forwarding, printing, copying, distributing, or=
 using such information is strictly prohibited and may be unlawful. If you =
are not an intended recipient, you are hereby notified that you received th=
is email in error, and that any review, dissemination, distribution or copy=
ing of this email and any attachment is strictly prohibited. If you have re=
ceived this email in error, please contact the sender and delete the messag=
e and any attachment from your system. Thank you for your cooperation

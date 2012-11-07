From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Wed, 7 Nov 2012 20:06:45 +0100
Message-Id: <9A40FDD0-65C2-470A-ACB7-AB556CF62501@mah.priv.at>
Mime-Version: 1.0 (Apple Message framework v1283)
Subject: [Xenomai] RTDM API: no CPU binding, FPU setting for tasks available?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

As suggested, I adapted the LinuxCNC kernel support from native to RTDM =
API; my remaining issues are:

- how do I achieve CPU binding which is available in rt_task_create() =
(T_CPU(cpuid))?
- do I need to tell an RTDM task that the thread might use the FPU =
(T_FPU in rt_task_create()) ?

thanks in advance,

Michael




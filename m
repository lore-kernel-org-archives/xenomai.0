MIME-Version: 1.0
Date: Mon, 16 Jul 2012 14:36:02 +0300
Message-ID: <CADFJ0Sob8CJ_MByvBYf_MBeLga_eMwHRorPNPJhjHnnXeUNmAg@mail.gmail.com>
From: Eralp Bayraktar <bayraktar.eralp@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Xenomai 2.6.1 hangs at boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

When I build Nucleus into the kernel, booting process hangs at the line:

I-pipe: Domain Xenomai registered.
Xenomai: hal/i386 started.

I am using Xenomai 2.6.1 and linux kernel 2.6.35.13. I am compiling for an
i686 intel atom machine from a 64 bit intel machine. I don't have any
xenomai specific files (libs etc) on the root. It is a virgin linux root.

Is this a known issue? I can't seem to find a clue for my mistake.

Message-ID: <52E90C95.702@axelsw.it>
Date: Wed, 29 Jan 2014 15:13:41 +0100
From: Marco Tessore <marco.tessore@axelsw.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Please,
 can anybody help me to find where is supposed to be the handler
 function for the Xenomai syscall in the kernel tree?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Good morning,
I am a newbie of Xenomai, and I'm trying to patch a modified (non 
vanilla) Linux kernel 3.11.0rc3 for ARM architecture (Freescale iMx28) 
with Xenomai 2.6.3.
To achieve this goal I have modified, then applied the patch 
ipipe-core-3.8.13-arm-3, but, probably because of my changes, something 
seems to not work properly.

In particular, when I launch any sample application, I get the following 
error message:
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)

Given that the specified configurations are active in my kernel, and 
they are all compiled into the kernel without resorting to modules,
looking deeper in the code I saw that the syscall
muxid = XENOMAI_SYSBIND(skin_magic,
                 XENOMAI_FEAT_DEP, XENOMAI_ABI_REV, &finfo);
in the file bind.c of the user space shared objects is returning ENOSYS.

The question is: where I can find - where is supposed to be - the 
handler function for the Xenomai syscall in the kernel tree?
This can help me a lot to find what mistake I done.


I thank in advance anyone who can help me solve the problem.

Sincerely
Marco Tessore



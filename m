Message-ID: <3a62cd359d1baaa923985e5438f7b75a.squirrel@www.nta-inc.net>
Date: Mon, 31 Dec 2012 22:09:08 -0600
From: jeff.webb@nta-inc.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] RTDM serial issue
Reply-To: jeff.webb@nta-inc.net
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

When I try to open an RTDM serial device under Xenomai-2.6.2/Linux 3.4.6
(Ubuntu 12.04), the call appears to succeed, but I get the following
output in /var/log/kern.log:

kernel: [  109.250736] I-pipe: Detected stalled head domain, probably
caused by a bug.
kernel: [  109.250737]         A critical section may have been left
unterminated.
kernel: [  109.250743] Pid: 3585, comm: serial_tx Not tainted
3.4.6-xenomai-2.6.2 #1
kernel: [  109.250745] Call Trace:
kernel: [  109.250754]  [<ffffffff810c8a5e>] ipipe_root_only+0xbe/0x130
kernel: [  109.250758]  [<ffffffff81104aa0>] ? irq_vfile_show+0x570/0x570
kernel: [  109.250762]  [<ffffffff810c8f56>] ipipe_request_irq+0x36/0x100
kernel: [  109.250765]  [<ffffffff810cb753>] ipipe_virtualize_irq+0x13/0x30
kernel: [  109.250770]  [<ffffffff810ffe80>] rthal_irq_request+0x30/0x40
kernel: [  109.250772]  [<ffffffff811061cb>] xnintr_attach+0x2fb/0x460
kernel: [  109.250777]  [<ffffffff8119e572>] rtdm_irq_request+0x32/0x70
kernel: [  109.250782]  [<ffffffff81594f01>] rt_16550_open+0x161/0x380
kernel: [  109.250785]  [<ffffffff8119b681>] __rt_dev_open+0xb1/0x140
kernel: [  109.250789]  [<ffffffff811a2738>] sys_rtdm_open+0x78/0xa0
kernel: [  109.250792]  [<ffffffff8111ed00>] hisyscall_event+0x220/0x3b0
kernel: [  109.250796]  [<ffffffff810cba4f>] ipipe_syscall_hook+0x5f/0xa0
kernel: [  109.250799]  [<ffffffff810c9551>]
__ipipe_notify_syscall+0x131/0x2e0
kernel: [  109.250804]  [<ffffffff81020b46>] __ipipe_syscall_root+0x46/0x160
kernel: [  109.250808]  [<ffffffff813a679a>]
__ipipe_syscall_root_thunk+0x35/0x67
kernel: [  109.250813]  [<ffffffff816c6cf7>] ?
system_call_after_swapgs+0x54/0x6d
kernel: [  109.250815] ------------[ cut here ]------------
kernel: [  109.250818] WARNING: at include/linux/ipipe_debug.h:88
xnintr_attach+0x41f/0x460()
kernel: [  109.250820] Hardware name: Precision WorkStation T3400
kernel: [  109.250822] Modules linked in: bnep rfcomm bluetooth
binfmt_misc dm_crypt snd_hda_codec_analog snd_hda_intel snd_hda_codec
snd_hwde
 snd_seq_midi_event snd_seq snd_timer snd_seq_device snd soundcore
usbhid x38_edac hid edac_core snd_page_alloc coretemp psmouse mac_hid dcdba
t_pc lp parport reiserfs nouveau ttm drm_kms_helper drm i2c_algo_bit
mxm_wmi video wmi tg3
kernel: [  109.250874] Pid: 3585, comm: serial_tx Not tainted
3.4.6-xenomai-2.6.2 #1
kernel: [  109.250876] Call Trace:
kernel: [  109.250880]  [<ffffffff8103cc0f>] warn_slowpath_common+0x7f/0xc0
kernel: [  109.250883]  [<ffffffff8103cc6a>] warn_slowpath_null+0x1a/0x20
kernel: [  109.250886]  [<ffffffff811062ef>] xnintr_attach+0x41f/0x460
kernel: [  109.250889]  [<ffffffff8119e572>] rtdm_irq_request+0x32/0x70
kernel: [  109.250892]  [<ffffffff81594f01>] rt_16550_open+0x161/0x380
kernel: [  109.250896]  [<ffffffff8119b681>] __rt_dev_open+0xb1/0x140
kernel: [  109.250899]  [<ffffffff811a2738>] sys_rtdm_open+0x78/0xa0
kernel: [  109.250902]  [<ffffffff8111ed00>] hisyscall_event+0x220/0x3b0
kernel: [  109.250905]  [<ffffffff810cba4f>] ipipe_syscall_hook+0x5f/0xa0
kernel: [  109.250908]  [<ffffffff810c9551>]
__ipipe_notify_syscall+0x131/0x2e0
kernel: [  109.250912]  [<ffffffff81020b46>] __ipipe_syscall_root+0x46/0x160
kernel: [  109.250915]  [<ffffffff813a679a>]
__ipipe_syscall_root_thunk+0x35/0x67
kernel: [  109.250918]  [<ffffffff816c6cf7>] ?
system_call_after_swapgs+0x54/0x6d
kernel: [  109.250921] ---[ end trace b86b12c8ae154342 ]---

This only happens the first time I run my application.  Despite these
messages, my application code seems to work for the most part.  I am having
a few high latencies that may be associated with this, or may be due to
something else entirely.  Regardless, the messages seem to indicate that
something is not right.  I get similar behavior using a Xenomai build I made
in mid October using the ipipe-core 3.4 branch and xenomai 2.6 git branch.
I get the same results on several Ubuntu 12.04 machines.  Here is a simple
test program that triggers the sort of output described above:

/* Standard includes */
#include <stdio.h>
#include <errno.h>
#include <error.h>
#include <stdlib.h>   /* Exit status macros and atexit */
#include <sys/mman.h> /* Memory management (mlockall) */

#include <rtdm/rtserial.h>

/* Main program */
int main(void)
{
  int err;
  int fd;

  /* Disable paging for this program's memory */
  err = mlockall(MCL_CURRENT | MCL_FUTURE);
  if (err)
  {
      error(EXIT_FAILURE, errno,
            "could not disable memory paging for this program");
  }

  /* Open the serial port */
  fd = rt_dev_open("rtser0", 0);
  if (fd < 0)
    {
      error(EXIT_FAILURE, errno,
            "could not open serial device");
    }

  printf("open succeeded\n");

  /* Close the serial port */
  rt_dev_close(fd);

  return 0;
}

makefile flags:
CFLAGS := $(shell xeno-config --skin=native --cflags)
LDLIBS := -lrtdm $(shell xeno-config --skin=native --ldflags)

If I try to compile and run this same test program on an older machine
running Xenomai 2.5.5.2 / Linux 2.6.32.20 (Ubuntu 10.04), I do not have
any issues.  I also built a set of Xenomai 2.6.1 / Linux 3.2.21 packages
for this older system and I don't seem to see the problem there either.
I had a package build issue (too old of a version of some dpkg build tool)
when trying to build the latest Xenomai/Linux combo under 10.04, so I
didn't test that configuration on the older machine.  The newer machines
have hardware that is not supported in older Xenomai/Linux configurations,
so I haven't been able to do an apples-to-apples comparison to verify if
the behavior is due to a change in the Xenomai version.  Any help in
deciphering what's going on, or some next steps in debugging would be
appreciated.

Thanks for all the fine work in putting together this latest release.

-Jeff




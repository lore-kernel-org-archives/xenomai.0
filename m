Date: Thu, 26 Jan 2017 15:59:26 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170126155926.594b8e2b@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] RFC: switchtest FPU, introduce option to enforce testing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hey,

currently the switchtest will not run FPU related tests on x86 when
some kernel-CONFIGS are set. (CONFIG_X86_USE_3DNOW, CONFIG_MD_RAID456)

http://git.xenomai.org/xenomai-3.git/tree/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h#n32

The FPU switching code is infamous for popping up with every other
kernel-release. Therefore i think this test is extremely important and
should not "just" be ignored on a "typical" kernel config.

In order to run the test today you have to change your kernel config,
boot that kernel and run the test. If it works you can change back to
the config you had before and you should be safe. But that is a lot of
work and you will not be running the test on your "actual" kernel.

As far as i understand the situation this is a safeguard so you do not
mess up your raid when you do active developement on a machine with say
a raid-rootfs. For such a scenario running that kind of stress test on
a subsystem that is known to break easily is a bad idea.

http://www.xenomai.org/pipermail/xenomai/2016-August/036598.html

But say your test machine is disposable or known to not use RAID etc.
It would be nice to have a way to enforce the test anyway. A good
example for such a scenario is CI where you might want to test your
actual production kernel and not a second kernel that comes close.

I would like to add a --force option to switchtest, pass that up to the
kernel to skip the sanity check there.

Or would that be a bad idea?
Henning


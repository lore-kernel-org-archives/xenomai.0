From: Philippe Gerum <rpm@xenomai.org>
Subject: I-pipe / Dovetail news
Message-ID: <24c08bcc-b152-ab0f-a92d-c990a780e90b@xenomai.org>
Date: Thu, 2 May 2019 18:46:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: Dmitriy Cherkasov <dmitriy@oss-tech.org>, Steven Seeger <steven.seeger@flightsystems.net>, "Kiszka, Jan" <jan.kiszka@siemens.com>


This is a note to let you know that work is ongoing to enable Dovetail
for Xenomai 3. For those who don't know what Dovetail is, you may want
to have a look at [1].

In a nutshell, the I-pipe is a venerable piece of code which needs extra
care when porting to new kernel releases. Which you could also translate
as: this is a freaking mess to maintain. Dovetail is a new
implementation of the interrupt pipeline mechanism, which addresses the
painful issues the I-pipe had over the years, greatly simplifying the
task for the real-time core as well. This implementation was started
circa kernel 4.7, and has evolved a lot since then.

Currently, Dovetail is routinely validated over a few ARM and ARM64 SoCs
running the EVL co-kernel [2]. The other news is that I'm currently
porting Dovetail to x86_64, in parallel to rebasing the Xenomai
infrastructure code over its generic interface. I'm not interested in
the x86_32 architecture, and I believe there is a general consensus that
this architecture will be discontinued in Xenomai at some point.

At the end of this process, a Dovetail-based Cobalt core should be
available for the ARM, ARM64 and x86_64 architectures. The port is made
in a way that enables the Cobalt core to interface with either the
I-pipe or Dovetail at build time. ppc32 is likely to follow at some
point if Steven is ok with this. I could probably help with that, I
still have my lite52xx workhorse around, and a few 40x and 44x SoCs
generously offered by Denx Engineering (thanks Wolfgang).

Both ports (Xenomai over Dovetail, and Dovetail for x86_64) won't be
available overnight. There is still quite some work to be carried out
before you can run a Dovetail-enabled Xenomai on a x86 machine. This
said, things have been going fairly nicely so far, especially for
Dovetail x86 which now boots a basic but promising IRQ pipeline in a KVM
guest [3].

Final note: Dmitriy is short on time for side projects at the moment, we
agreed that I should take over the ipipe-arm64 [4] maintenance since I'm
familiar with this architecture. So I'm doing just that: the first task
will be to upgrade the currently supported release to 4.19.

[1] https://evenless.org/dovetail/
[2] https://www.evenless.org/ports/
[3] https://git.evenless.org/linux-evl.git/log/?h=wip/dovetail/x86
[4] https://gitlab.denx.de/Xenomai/ipipe-arm64

-- 
Philippe.


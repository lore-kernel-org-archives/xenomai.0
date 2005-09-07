Message-ID: <431EA3CC.70303@domain.hid>
Date: Wed, 07 Sep 2005 10:24:44 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Nextgen Adeos patch series
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: karim@domain.hid


A new generation of Adeos patches is hitting the street, and will
gradually replace the former one for all architectures. This move is
in direct consequence of the work that took place some weeks ago on
the LKML, where a refactored implementation of the interrupt pipeline
scheme, which is at the core of the Adeos patch, has been submitted
for review.

To this end, the code has undergone a large revamping, especially on
x86, basically in order to take the lessons learned during the last
three years of continuous use and development of Adeos as a realtime
system enabler for RTAI.

Four major reasons led to this decision:

- The original Adeos papers [1] authored by Karim Yaghmour described
the core of what would be a full-featured virtualization system usable
for various purposes, whilst the current Adeos incarnation is "only" a
real-time enabling extension, hence a functional subset of this
proposal, which provides basic but still crucial support to RTOSes
that want to integrate with the Linux kernel environment. The revised
implementation now exclusively focuses on the latter goal, dismissing
any generic feature that does not immediately benefit this application
domain.  As a positive side-effect, the maintenance of such patches
already proved to be far easier.

- The x86 implementation from the former patch series had a serious
design flaw when it comes to handle the complexity of this
architecture's hardware interrupt management on some
configurations. This has led to a number of bug reports, many of them
involving interrupt routing. The cause of most, if not all, of these
issues has been identified, and the fix has required significant
surgery, much beyond the usual bug fixing process. Fundamental changes
took place internally for that purpose.

- A number of generic and arch-dependent optimizations were only
possible with radical changes to the implementation, which also had an
impact on the Adeos API that definitely breaks backward compatibility
with the older patches. This said, the core interrupt and event
interposition features still have the same semantics, and the
pipelining scheme is still of course at the heart of the
implementation.

- Adeos needs to integrate as seamlessly as possible with the Linux
internals, so that combining it with other kernel extensions
(e.g. LTT, PREEMPT_RT) is made easier. The refactoring of the Adeos
codebase according to the kernel coding standards made the patch less
intrusive in the same time, which eventually helps such combination
work.

Some pratical details now:

- The new patch series is nicknamed "I-pipe" (for Interrupt Pipeline),
in reference to the work published on the LKML, which is at the core
of the new implementation.

- I-pipe patches are named the following way, which makes it easy to
distinguish them unambiguously from the former generation ones:
adeos-ipipe-<kernel_version>-X.Y-ZZ.patch. The former candidate/final
release naming convention has been replaced by a more usual version
stamp, consisting of the major, minor and patchlevel identifiers
(i.e. X.Y-ZZ).

- I-pipe patches are immediately available for x86. By the time those
lines are written, PPC support is being developed.

- I-pipe/x86 patches for 2.6 kernels are available for download from
here, along with the former generation ones (go the the oldgen/
directory for those):
http://download.gna.org/adeos/patches/v2.6/adeos/i386/

[1] http://www.opersys.com/ftp/pub/Adeos/adeos.pdf
     http://www.opersys.com/ftp/pub/Adeos/practical-smp-clusters.pdf

-- 

Philippe.


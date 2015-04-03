MIME-Version: 1.0
Date: Fri, 3 Apr 2015 13:45:41 -0700
Message-ID: <CAJqUr7yKoXNCpEZ0_oo=U9koMyido2G1kxF5HPupvrvBkadjtQ@mail.gmail.com>
From: Don Mahurin <don@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] tsc on armv8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

A few questions about tsc as it relates to armv8.

1. armv8 has a 64 bit system counter register CNTPCT_EL0 (system counter
frequency get/set with CNTFRQ_EL0). May this be used as a replacement for
the arm tsc emulation. If so, should we use another architecture to model
the implementation?
(the count value is "at least 56 bits wide" according to spec and zero
padded to 64 bits. is the counter still sufficient?)


2. Is a tsc implementation strictly required to test basic i-pipe
functionality. I understand that a configuration without
CONFIG_IPIPE_ARM_KUSER_TSC is not currently supported on arm (which we are
basing the arm64 port upon), but what is the minimum tsc functionality that
needs to be implemented for basic i-pipe functionality. (Can some functions
be stubbed initially?)

-Don

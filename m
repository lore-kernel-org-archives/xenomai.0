Message-ID: <4AC61F57.2010404@domain.hid>
Date: Fri, 02 Oct 2009 17:42:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] RTDM fd support.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Hi Jan,

from discussions on the mailing list, it seems that we are going to need
that unified file descriptors thing. However, since everybody wants
2.5.0 to be released ASAP, we should try to think about any changes for
this support which would break the ABI, do them now, and keep the rest
for later.

One such problem is the translation which currently exists between rtdm
file descriptors and descriptors passed to the posix skin, by adding
1024 - 128. So, I propose to fix this issue.

The idea Philippe had, and which I tend to agree to, was, in case of
open/socket/accept, to open("/dev/null"), and use an association table
somewhere to associate with the kernel-space descriptor number. Since
we are at it, this association table could in fact be the file
descriptor table, which we would put in the core skin ppd. The actual
data structure should be sparse, a linked list does not scale, so,
probably a hash would do. (I could also propose a solution based on avl
trees, but their implementation is not nearly as simple).

Additionnally, this would allow our open/socket to conform to posix
which states that open should return the lowest free file descriptor.

Should I propose a patch in that direction? Do you see any other
possible cause of ABI breakage when we migrate to an unified file
descriptors structure?

TIA,
regards.

-- 
					    Gilles.



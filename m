Message-ID: <4347E01F.5080308@domain.hid>
Date: Sat, 08 Oct 2005 09:05:03 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [Fwd: Without joy or bitterness]
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

In testing the new list, Im probably jumping the gun,
but at least the msg is on-topic, useful.

Happy Birthday Philippe,
lemme buy you a virtual beer.

-------- Original Message --------
Subject: 	Without joy or bitterness
Date: 	Sat, 08 Oct 2005 00:27:37 +0200
From: 	Philippe Gerum <rpm@xenomai.org>
Organization: 	Xenomai
To: 	rtai@domain.hid
CC: 	rtai-dev@domain.hid, Paolo Mantegazza <mantegazza@domain.hid>



As some of you may have noticed reading this list during the last
months, it's been a long time since Paolo and myself have agreed on
any topic regarding RTAI. The crux of the problem is basically that
DIAPM's (and as such Paolo's) goals for RTAI - as a project and as a
technology - are no more compatible with the goals of the on-going
"fusion" development effort.

As a conclusion of this situation, the port once planned of the 3.x
APIs over the fusion core has been canceled, albeit this was a
cornerstone of the fusion effort, which would have paved the way to
RTAI 4.x [1]. This step would have required the DIAPM people to help
us - the fusion contributors - gradually extend the existing
"compatibility" skin, so that all RTAI services to applications would
have been eventually rebased on the fusion framework, whilst keeping
full compatibility with the original 3.x APIs.

This decision is a direct consequence of the inability Paolo and
myself had to agree on key issues regarding this convergence process,
and specifically the two following major requirements from the DIAPM,
which are unfortunately unacceptable to fusion's major contributors
and particularly myself as the maintainer of both the Adeos and fusion
projects:

#1 - the integration of significant portions of the existing 3.x
kernel code into the fusion core, in order to guarantee by
construction the same CPU footprints currently exhibited by the 3.x
series, instead of performing a clean room implementation of the 3.x
APIs as regular fusion skins.

#2 - the integration of sideways into the official Adeos patch aimed
at bypassing the pipelining code which actually implements the Adeos
scheme. This requirement is a direct consequence of #1, since fusion
is fundamentally based on the Adeos pipeline, but the optimal
configuration of recent releases of 3.x now depends on those sideways.

Firstly, the key design decision of the fusion architecture is to rely
on an abstract RTOS core aka the "nucleus" inherited from the Xenomai
project [2]. The standard interface exported by the nucleus is
available for building any kind of real-time API personality aka
"skin", which can be used in turn by the applications.  The advantage
of such architecture is basically that each and every available
real-time personality contributes to exercise, debug and help
optimizing a single generic core handling the basic real-time duties,
which is in turn beneficial to all other real-time personalities
depending on it. Unlike Paolo, I still think that such design would
have allowed us to properly and efficiently emulate the existing 3.x
APIs despite the additional abstraction layer, the same way a number
of available fusion skins already emulate various traditional RTOS. At
the contrary, a mix of both code bases seems to me the wrong approach,
since 3.x and fusion designs are conflicting in many ways at core
level.

Secondly, Adeos has been explicitely contributed to the real-time
Linux community as a patent-free mechanism for prioritizing interrupt
delivery in the Linux kernel, based on a non-patented pipelining
scheme [3], a feature which is critical to any real-time extension
designed for operating in such context. Unlike Paolo, I see those
sideways as being potentially harmful to its users, since they bluntly
bypass what makes Adeos a patent-free implementation.

Because this situation impedes any further development of RTAI 4.x the
way we initially devised with Paolo, it also leads to have two
competing - and not only diverging - code bases into the RTAI project,
which is something that would only bring more confusion, without any
upside for its users.

I clearly understand that RTAI is DIAPM's project for developing
DSP-style real-time support suitable for their own needs, and as such,
my views as the maintainer of a development branch cannot indefinitely
go against Paolo's vision for the whole project. For this reason, and
as Paolo is already aware of, I see no future anymore for the fusion
effort within the RTAI project, therefore I have decided to step down
from the latter. This move de facto causes the classic RTAI branch
(i.e. v3.x) to remain the single implementation of reference for the
RTAI project.

This said, I take this opportunity to thank Paolo regardless of our
recent disagreements, for his confidence in my ability to help RTAI,
first with the Adeos contribution, then as the initial 3.x maintainer.
Hopefully, this work will have been useful to the RTAI community.
Conversely, it is just fair to acknowledge that fusion owes the RTAI
community a lot, like the pioneering effort toward efficient real-time
support in user-space.

Now, the future: I will continue developing the fusion technology with
the help of contributors who want to build a deeply integrated
real-time framework for the GNU/Linux environment which conforms to
the Free Software standards.

To this end, the Xenomai project, which once merged with RTAI, has
been reactivated as an independent project at the GNA site [4] and the
fusion code base has moved there for future development. Xenomai 2.0
will soon be released, as a major evolution of this project's initial
implementation, which is at the core of what would become the
RTAI/fusion branch. In other words, Xenomai 2.0 will be the actual
incarnation of what should have been RTAI/fusion 1.0, under other
circumstances.

Questions related to the former RTAI/fusion branch on this list should
be directed at the Xenomai mailing lists instead [5]. People already
using RTAI/fusion 0.9.1 will have no problem migrating to Xenomai,
simple guidelines and a conversion kit will be available soon. In any
case, no API change will be required. The upcoming release of Xenomai
2.0 will be announced to this list.

The Xenomai project will keep on focusing on the all-time goals of the
former RTAI/fusion branch, namely:

- Provide a seamlessly integrated real-time extension, acting as a
bridge from the traditional RTOS world to the GNU/Linux environment.

- Cooperate with other development groups as much as possible, in
order to build a comprehensive and industrial-grade real-time
framework.

- Leverage the on-going effort of the Linux kernel community, in order
to help supporting a broader spectrum of real-time applications with a
high level of integration with the GNU/Linux environment, which is
still deeply needed in the embedded space.

In any case, be convinced that my decision to leave the RTAI project
has been taken without joy or bitterness, but aims at giving a chance
to the fusion effort to keep developing and proving its relevance.

[1] https://mail.rtai.org/pipermail/rtai/2004-April/007406.html
[2] http://www.xenomai.org/
[3] http://www.linuxdevices.com/articles/AT7788559732.html
[4] http://www.gna.org/projects/xenomai/
[5] https://gna.org/mail/?group=xenomai

-- 

Philippe.

_______________________________________________
RTAI mailing list
RTAI@rtai.org
https://mail.rtai.org/cgi-bin/mailman/listinfo/rtai




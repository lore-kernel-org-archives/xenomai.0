Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Mar 2005 11:01:21 -0600
Message-ID: <0D21CBD1298D2C4790E2F2B86D96EC193802B4@domain.hid>
From: "Reynolds, Terry \(Contractor-SIMTECH\)" <terry.reynolds2@domain.hid>
Subject: [Adeos-main] ppc64 pipeline problem
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos <adeos-main@gna.org>

Hi All,
=20
I've corrected the syscall portion of the pipeline, and have a new, but =
similar, problem.  The=20
ADEOS_SYSCALL_PROLOGUE event (event 4 on this system) is now branching =
to __adeos_enter_syscall
function, which calls adeos_handle_event.  This eventually returns to =
the kernel, marked as to be handled via the linux
syscall code.  This starts a long loop of event 4's, which are =
apparently not being processed
correctly.
=20
I get this behavior when trying to load the rtai_nucleus module, or run =
the latency example.
=20
What syscall event does this adeos event 4 correspond to?   What =
generated it? =20
=20
FYI, when I modify entry.S to call a .do_show_syscall for this event =
what I get is:
=20
syscall 3221225472 ( f7db7000, 1000, 1000, f7db8000, fe92d50, =
100000000200f932) regs=3Dc00000000065aefc
current=3Dc00000007983b1c0 cpu=3D0=20
=20
Which is :
syscall gpr0 ( r3, r4, r5, r6, r7, r8) r9(ptr to regs) current_task cpu#
=20
Thanks,
=20
Terry


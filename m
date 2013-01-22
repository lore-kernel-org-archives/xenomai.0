References: <1358809464.75419.YahooMailNeo@web140601.mail.bf1.yahoo.com>
Message-ID: <1358883137.7479.YahooMailNeo@web140606.mail.bf1.yahoo.com>
Date: Tue, 22 Jan 2013 11:32:17 -0800 (PST)
From: A User <t02446@yahoo.com>
In-Reply-To: <1358809464.75419.YahooMailNeo@web140601.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] x86 Linux with xenomai and i915 graphics stall
Reply-To: A User <t02446@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles,=0A=0AThank you for your help.=0A=0AToday we compiled our buggy 3.2.=
21 Linux (i915 stalls) with the I-pipe tracer turned on.=A0 That had the ef=
fect of making the GPU stall bug disappear (or made it less frequent - it's=
 intermittent).=A0 So instead of trying to figure that out, we decided to t=
ry running:=A0 3.5.7/2.6.2.=0A=0ANote, when we tried compiling 3.5.3 and 2.=
6.2 on January 3, we had some problems, which have since been fixed:=0Ahttp=
://www.xenomai.org/pipermail/xenomai/2013-January/027187.html=0A=0ASo today=
 Daniel and I compiled a kernel.org Linux 3.5.7 patched with Xenomai 2.6.2 =
from git.=A0 We used the same Linux .config as our 3.2.21 that was giving u=
s GPU stall problems.=A0 (We ran make xconfig and accepted the changes that=
 it made.)=0A=0AOur new Linux 3.5.7 with Xenomai 2.6.2 compiles and runs.=
=0AThe compile gets warning messages that we will ignore for now.=0Ahttp://=
www.xenomai.org/pipermail/xenomai/2013-January/027491.html=0A=0AWe compiled=
 two 3.5.7 kernels, with CONFIG_PCI_MSI turned off and on.=0A=0AIt looks li=
ke both kernels behave about the same.=A0 We do not see the GPU stalls now.=
=A0 (The GPU stalls were intermittent before, so we are not 100% sure they =
are gone, but we have not seen them yet.)=0A=0A=0AWhen we run latency, we s=
till get about 10 usec on a quiet system.=A0 When we run glxgears and make =
the window size=A0 600x600 pixels, and we use the mouse to drag the glxgear=
s window quickly around on the desktop, the max latency goes to about 250 u=
sec (with gnome-3 fallback and compiz).=0A=0ASo, it looks like we are ok fo=
r now with this configuration, unless that latency is unusual.=0Aglxgears i=
n a window that is not being dragged has lower latency.=0A=0A=0APlease note=
 that the x86 config help file:=0A=0Ahttp://www.xenomai.org/index.php/Confi=
guring_x86_kernels=0A=0Asays:=0A=0A"""=0A=0AUse care when referring to old =
mail posts, archives, and google results. This page is kept up to date with=
 information on what options you might need to tweak.=0A...=0A=0AThe option=
 CONFIG_PCI_MSI should be disabled=0A=0A"""=0A=0A=0AWe will keep CONFIG_PCI=
_MSI turned on for now, as Gilles suggests.=0A=0A=0A-Andy and Daniel=0A=0A=
=0A=0A----- Original Message -----=0AFrom: A User <t02446@yahoo.com>=0ATo: =
"xenomai@xenomai.org" <xenomai@xenomai.org>=0ACc: =0ASent: Monday, January =
21, 2013 6:04 PM=0ASubject: x86 Linux with xenomai and i915 graphics stall=
=0A=0AI'm trying to run a Linux/Xenomai system with Ubuntu 12.04 LTS=0Adist=
ro including X Window System on an Intel x86 board.=0A=0A...=0A


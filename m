From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15784.40343.952661.934733@domain.hid>
Date: Sun, 13 Oct 2002 00:09:27 +0200
Subject: [Adeos-main] Adeos project status
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: adeos-main@gna.org, karim@domain.hid
Cc: rtai@domain.hid, xenomai-main@domain.hid

Hi,

For everyone's information, the Adeos project status as of today
follows.

Best regards,

Philippe.

--

o Adeos releases

  Since June 6 2002, the Adeos project has produced the following
  stable releases of its nanokernel patch for Linux:

	- r1, r2, r3 and r4 for the 2.4 branch
	- r1 for the 2.5 branch

  Each kernel patch against Linux is numbered after the release number
  of the nanokernel it implements and the kernel version it can be
  applied to.

  e.g. adeos-linux-2.4.19-r4.diff contains the 4th release of the
  Adeos nanokernel one can apply to a vanilla Linux 2.4.19 kernel in
  order to get the domain magic running.

  Since the changes between two major Linux branches may have a
  significant impact on the low-level Adeos code, we decided to keep
  such branching for the nanokernel itself. As a result of this,
  a patch release number is only significant for a given Linux branch,
  thus two patch releases with identical numbers but for different
  Linux branches cannot be compared.

  e.g. recent 2.5r1 actually has the same functionalities (and
  maybe bugs :o) than 2.4r4 has, while 2.4r1 represents the Adeos
  limbos and therefore has no 2.5 equivalent.

  Several intermediate candidate patch releases pave the way
  to the next stable patch release. These are numbered after the next
  stable release suffixed by "c<iteration#>". e.g. 2.4r5c2 is the
  second candidate patch release toward the r5 stable patch for the
  Linux 2.4 branch.

  The stable Adeos patch releases have been ported to the following
  platforms:

	- Linux 2.4.18/x86 (2.4r1, 2.4r3, 2.4r3)
	- Linux 2.4.19/x86 (2.4r1, 2.4r4)
	- Linux 2.5.25/x86 (2.5r1)
	- Linux 2.5.31/x86 (2.5r1)
	- Linux 2.5.37/x86 (2.5r1)
	- Linux 2.5.40/x86 (2.5r1)

  Adeos patches and workspaces for obsolete development Linux kernels
  are removed from our CVS head periodically, but you can always find
  them using older CVS tags.

o Documentation

  The Adeos API is fully documented aside of the kernel patch in
  doc/interface.h using a Doxygen format. Please read the HOWTO file
  to learn how to build the PS/PDF/HTML output. An on-line version is
  available at http://www.nongnu.org/adeos/doc/api/. Other documents
  (such as Karim's Adeos Design Document) are available whether in the
  Adeos distro or on-line from our WEB site.

o Recent work and applications

  A recently completed development effort aimed at hardening the Adeos
  subsystem under various load cases (including very unreasonable ones
  :o) while reducing its own impact on the overall interrupt latency.
  SMP support has also been improved.

  We also tried hard to reduce the overall impact of the Adeos code on
  the original Linux code (aka "#ifdef flood syndrom") by implementing
  a smarter infrastructure layer. Changes to the Linux core are fewer
  and still easily recognizable.

  Like many free software projects, Adeos has started to mature since
  it has been used for "real world" applications, such as providing
  interrupt virtualization services to the current development
  versions of the Xenomai and RTAI real-time systems.

  We are currently working closely with the RTAI project to have all
  their real-time layers (kernel-based and user space) run smoothly
  over the Adeos nanokernel in UP and SMP modes. Kernel-based UP mode
  over Adeos is now stable and exhibits pretty decent interrupt
  latencies.

  A new Adeos snapshot (20021012) is available from our download
  area. It includes the latest major changes and smaller fixes
  validated with the RTAI core. The latest (candidate) patches
  available from this snapshot are 2.4.19-r5c2 and 2.5.41-r2c2.

o Future directions

  Generally speaking, we'd like to see the Adeos scheme used in other
  application fields than real-time systems, such as SMP clustering or
  kernel debuggers.

  We are closely tracking the Linux 2.5 branch (issuing candidate
  patches) to ensure that Adeos will be ready for 2.6.  Adeos will be
  available for the next 2.4.20 too.

  But above all, and in the short term, we want to have Adeos ported to
  other architectures than x86 now that it's steady. So please, if you
  have time and motivation to take on an architecture port for the
  Adeos project, contact us and we will help (actually, if you are
  familiar enough with the target CPU's interrupt subsystem, it should
  be a piece of cake for you to port Adeos -- really!).

  [ Btw, sympathizing proof-readers who care to fix my
  Parisian English Variant(tm)(c)(r) that spreaded over the
  documentation are warmly welcomed too :o> ]

o Useful links

  http://savannah.nongnu.org/adeos/ -- Adeos project WEB site.

  http://savannah.nongnu.org/projects/adeos/ -- Adeos project
  workspace on savannah (Web CVS access, mailing list archive and
  more).

  http://savannah.nongnu.org/download/adeos/ -- Adeos download area.

  http://www.aero.polimi.it/~rtai/ -- Home of the RTAI project.

  http://www.xenomai.org/ -- Home of the Xenomai project.



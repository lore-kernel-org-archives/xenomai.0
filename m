Message-ID: <5338834B.5090604@steinkuehler.net>
Date: Sun, 30 Mar 2014 15:49:15 -0500
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Dedicated Core?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Is it possible to (easily) dedicate a CPU core to a single Xenomai
user-space thread?

Background:
I am running software based step/direction generation logic for motion
control as part of LinuxCNC.  On the x86 platform, latency numbers are
very good, and it's possible to run fast enough as a Xenomai user-space
thread.

ARM systems have significantly worse latency numbers, but on the
BeagleBone I have migrated the step/direction code to the PRU on-board
co-processors so everything works fine (actually better than on most x86
systems).

But most available ARM CPUs do not have the PRU co-processors found on
the BeagleBone.  However, there are a number of systems that have
multiple cores, and I'm particularly looking at the quad-core iMX6 parts.

If it would be possible to simply keep a thread running full-time on one
core, I could get really good step/direction performance without having
to worry about interrupt latency, but I don't know if there's an (easy)
way to do this using Xenomai, or if the 'dedicated' core would still be
subject to hardware interrupts and if my running thread might be
occasionally migrated to other physical cores.

-- =

Charles Steinkuehler
charles@steinkuehler.net

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140330/39738b0=
1/attachment.sig>

From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15669.58314.307577.58284@domain.hid>
Date: Wed, 17 Jul 2002 23:38:18 +0200
Subject: [Adeos-main] [ANNOUNCE] Adeos M2
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
To: linux-kernel@domain.hid
Cc: adeos-main@gna.org, xenomai-main@domain.hid

On behalf of the Adeos project team, I'm glad to announce the
availability of the new Adeos milestone release M2 based on 2.4.18
(x86).  This release aims at stabilizing the code (internals and API),
which now includes the SMP support.

Aside of this, the initial port of Adeos to 2.5 (2.5.25/x86) has just
been completed. It is available from our CVS area on Savannah.

Finally, the RTOS available from the Xenomai project (*) has been
ported over Adeos to serve as a proof-of-concept of one of the
possible applications Karim had envisioned. In order to achieve a high
degree of determinism, this real-time kernel (loaded as a module) runs
aside of Linux as a separate Adeos domain living ahead of the Linux
domain in the interrupt pipeline.

M2 release: http://savannah.gnu.org/download/adeos/releases/adeos-m2.tar.gz
On-line Adeos doc: http://www.freesoftware.fsf.org/adeos/doc/api/globals.html
Adeos CVS: http://savannah.gnu.org/cvs/?group=adeos
Xenomai: http://savannah.gnu.org/download/xenomai/snapshots/xenomai-1.1pre2.tar.gz

(*) Xenomai is a development framework for real-time systems which
includes a collection of emulators mimicking APIs of traditional RTOS
such as VxWorks, pSOS+ and VRTXsa. These emulators run over a single
"generic" RTOS core which have been ported over Adeos.

Regards,

Philippe.


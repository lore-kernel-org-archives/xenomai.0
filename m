From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15705.41071.28923.978296@domain.hid>
Date: Wed, 14 Aug 2002 02:12:31 +0200
Subject: [Adeos-main] RTAI over Adeos -- Experimental
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
To: rtai@domain.hid
Cc: adeos-main@gna.org

Hello all,

ARTI (Adeos-based Real-Time Interface) is the experimental rewrite of
the RTAI real-time interface for x86 over the Adeos nanokernel
(http://www.freesoftware.fsf.org/adeos/). In other words, this is a
replacement for the RTAI/x86 real-time interface module (aka "rtai.c")
exclusively using the Adeos services to handle interrupts and
exceptions. The API exported by ARTI is meant to be compatible with
the original RTAI interface so that existing applications can use it
seamlessly.

Basically, most of the internals have been rewritten in order to fully
delegate the hardware interrupt control to Adeos. To this end, the new
module creates an Adeos domain which has precedence over the Linux
kernel into the interrupt pipeline. This way, each and every interrupt
is first delivered to the ARTI module which further controls its
propagation to Linux when needed.

You can currently use ARTI in replacement of the original RTAI
interface to run kernel-based applications over the standard UP
scheduler. Neither the SMP scheduler nor LXRT are supported at this
time.

If interested, you can download this work from
http://freesoftware.fsf.org/download/xenomai/misc/arti.tar.bz2

This code is in no way for production use. It is an experimental work
aimed at fostering ideas and thoughts on both RTAI and Adeos
development.

More information can be found in the README file shipped with the
distro.

Regards,

Philippe.



From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15657.24190.301211.695088@domain.hid>
Date: Mon, 8 Jul 2002 11:42:22 +0200
Subject: [Adeos-main] Adeos r2c2/x86
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
To: adeos-main@gna.org

New Adeos snapshot r2c2/x86 is available from
http://savannah.gnu.org/download/adeos/snapshots/adeos-20020706.tar.gz
and from the CVS tree (tag "snap-20020706").

This new candidate release mainly adds an exception propagation scheme
similar to the one used for pipelining interrupts. This should be
rather useful for implementing a kernel debugger over Adeos.
Basically, domains are now allowed to interpose their own handlers for
processing exceptions raised by themselves or less prioritary domains.
A preliminary draft of the Adeos API is also available in doc/api.txt.

Since the code is quite stable now, r2c2 is expected to be the last
candidate release before the final one.

Best regards,

Philippe.


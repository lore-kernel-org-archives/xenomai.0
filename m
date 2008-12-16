Message-ID: <4947AE91.8010000@domain.hid>
Date: Tue, 16 Dec 2008 14:35:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] xnpipe: Racy input_handler business
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

someone just dumped another kernel oops on my desk which points to the
xnpipe subsystem: xnpipe_release was called, invoking
__pipe_input_handler ie. the registered input_handler of the native pipe
services. And that handler tried to call an invalid monitor callback
(but no one ever set a monitor handler).

So I looked at how the nucleus deals with input_handler registration,
deregistration, and invocation where it also passes some cookie that
points to the native pipe object here. Looks like that code is racy /wrt
concurrent cleanup of kernel and user side.

What is the intended locking policy when dereferencing the tuple of
xnpipe_state_t.input_handler and xnpipe_state_t.cookie? Sometimes the
handler is called under nklock, sometimes only both values are obtained
and then nklock is dropped before invoking the handler (which is bogus
as cookie may become invalid in the meantime). Even worse,
xnpipe_release does not care at all about locking when calling
input_handler as its last duty - and that's obviously where my customer
just caught an oops.

In other words: Can't we always hold nklock while checking for
input_handler != NULL and then invoking it with the corresponding
cookie? This will just require us to properly clear input_handler on
xnpipe_disconnect.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 26
Corporate Competence Center Embedded Linux


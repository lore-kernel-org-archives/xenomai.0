Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2009 17:00:43 -0500
Message-ID: <181804936ABC2349BE503168465576460BE76E09@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: [Xenomai-help] Shared interrupt usage questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Is there any acceptable method to share interrupts in userspace using
the native or other skin?  I am writing a userspace driver for a
Freescale mpc5121e PSC serial controller, which has 12 programmable
serial controllers which share a single FIFO controller.  The single
FIFO controller has only a single IRQ line for all 12 PSCs.  This is
further complicated by the fact that I also have to share this IRQ line
with the Linux domain, as it uses it for the console and other devices.

I cannot create multiple descriptors for the same IRQ line using
rt_intr_create and the I_SHARED flag doesn't seem to be exported to
userspace.  Is it valid to create one interrupt object and have multiple
tasks call rt_intr_wait for the same interrupt object?
=20
As far as sharing with the Linux domain, from the documentation it seems
I would just pass I_PROPAGATE and this should then be transparent to the
Linux domain.  Are there additional concerns I should be aware of with
sharing the IRQ between domains?

I have set this up with a single shared interrupt object and it seems=
 to
function properly.  I just want to make sure I'm not putting myself in=
 a
condition where I could get some obscure race condition or have a
deadlocked interrupt server task.

Thanks.


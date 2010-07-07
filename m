Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 7 Jul 2010 17:51:48 -0500
Message-ID: <181804936ABC2349BE503168465576460F3855E1@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: [Xenomai-help] Determining stack usage?
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

With the recent questions about the stack size going around I had a
somewhat related question.  Does Xenomai (or Linux for that matter)
provide any mechanism to determine stack usage?  I know of other RTOSes
that used a mechanism that basically prefills the stack with a guard
word upon task creation, and then calculates the stack usage based on
the first non guard word it encounters from the bottom of the stack. =
 I
didn't know if Xenomai provided this or anything similar.

This kind of mechanism has proved somewhat useful to me in the past. =
 It
allows you to know that you're close to overruning your stack and adjust
accordingly.  Otherwise you don't really have any way of knowing until
things go bad.


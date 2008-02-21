Message-Id: <47BDA1710200000100192821@domain.hid>
Date: Thu, 21 Feb 2008 16:06:09 -0500
From: "Hubert Talbot" <Hubert.Talbot@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-help] Non RT PCI device driver vs interrupts (almost ok)
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


First of all, I am studying xenomai to show to my manager that this =
framework=20
can do the expected job for our realtime applications (me, I believe!). I =
have to prove
that with a concrete application (alike the ones we do in general), where =
the
need to test xenomai with pci card.

The first step I decided to do is capture interrupt. Eventually, I will =
want
to translate driver to rtdm.

I had some difficulties to catch interrupt from realtime task but with
your confirmation, it is ok now.

However, it seems to be not as precise as expected=20
(in milliseconds order instead of microsecs).


Within a demo application...


The main function is as:

- opens board (specifying ISR)
- enables capturing of digital IO events
- enables interrupt requests in response to captured DIO edges
- enables interrupts
- reads counter
- disables interrupts
- closes board


And the ISR is as:

- gets interrupts status
- updates count
- resets DIO event capture flags
- enables interrupts



Doing like that in realtime application, I succeeded to catch interrupts
but with imprecision.

In rt_task, I have the following:

- rt_intr_wait()
- gets interrupts status (1)
- reads counter=20
- resets DIO event capture flags (2)
- enables interrupts (3)


Can (1) (2) (3) api calls cause the imprecision (primary/secondary mode)?

Should it be better if device driver would be implemented with xenomai-rtdm=
?


Thanks

Hubert




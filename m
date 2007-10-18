Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Oct 2007 14:11:19 +0200
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E016387F8@domain.hid>
From: "Thomas Necker" <thomas.necker@domain.hid>
Subject: [Xenomai-help] xnpod_announce_tick when migrating from 2.3 to 2.4
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

Hello

I'm trying to migrate our software from 2.3 to 2.4 and I'm struggling
with the new timebase concept.
Here is how it works in 2.3:
- I have a small kernel module that calls xnpod_stop_timer and then
xnpod_start_timer with a handling function of my own.
- This handling function does some housekeeping and then calls
xnpod_announce_tick to trigger the nucleus (and eventually the pSOS
skin).
This is basically what Philippe suggested about a year ago.
Now, all these functions are gone in 2.4, how's the best way to do
something similar now?
I couldn't figure out how the new timebase concept can be used for that.
Thanks in advance.

Regards,
Thomas


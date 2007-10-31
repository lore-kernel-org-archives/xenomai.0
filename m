Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 Oct 2007 10:37:33 +0100
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E0172B790@domain.hid>
From: "Thomas Necker" <thomas.necker@domain.hid>
Subject: [Xenomai-help] xntbase_get_jiffies in user space?
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

A few weeks ago I was asking about a global variable available that just
counts the system ticks (for pSOS skin) and that could be read by the
application. Philippe suggested xntbase_get_jiffies for that purpose.
Now it seems to me that this function can only be called in kernel
space. Is that correct? And if so, is there a way to get this
information in user space? Basically I want to get rid of kernel code in
this context completely if possible.

Thomas



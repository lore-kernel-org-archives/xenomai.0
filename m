Message-ID: <4934EB57.9080305@domain.hid>
Date: Tue, 02 Dec 2008 09:01:27 +0100
From: =?ISO-8859-15?Q?Patrick_Gr=E4bel?= <graebel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Calling comedi from a RT task
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


Hi,

I am using Xenomai 2.3.1 and comedi with driver "ni_pcimio". I am able
to create a RT task that triggers each msec. But calling the comedi API
kicks me out of RT as indicated by /proc/xenomai/stat (column MSW). The
modules loaded are:

comedi_fc   3584 1 ni_pcimio
kcomedilib 20868 0
comedi     33248 6 ni_pcimio, ni_tio, comedi_fc, mite, 8255, kcomedilib
licModule  44272 1 kcomedilib

The comedi modules are from a 2.6.20-14-ipipe/comedi/driver directory.
How do I use the comedi API so that the task will stay realtime? What do
I have to check?



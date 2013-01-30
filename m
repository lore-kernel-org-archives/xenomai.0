From: "Poole Jr, Donald R." <donald.poole@swri.org>
Date: Wed, 30 Jan 2013 06:22:53 +0000
Message-ID: <E9605457112439448B6B3ED284E065333175C3A5@mbx256-1.adm.swri.edu>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Sending data from RT ISR to Userland
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello All,

I'm developing a Xenomai RTDM kernel driver (against Xenomai 2.6.1) that re=
ads the pulse-width of a pulse-width modulation frames (or period) using an=
 interrupt service routine. On the rising/falling edges of the pulse, I rea=
d the times using rtdm_clock_read() to measure the pulse-width.  Now, after=
 making this measurement, I want to send this data to a user-land process/a=
pplication for further processing and decision making.  I was going to use =
the Native Skin's message pipe API, but after doing some googling I found o=
ut that the message pipe API is deprecated.  That being the case, I've been=
 reading through the documentation so more to find another solution, but I =
can't seem to find anything that would allow me to accomplish what I'm afte=
r.  What would be the best way to send data/information from the kernel dri=
ver to the user land process?

Donald R. Poole, Jr.
Research Engineer
Voice: 210.522.3131 | Fax: 210.522.4931
Tactical Networks & Communications (tacticalnetworks.swri.org)
Southwest Research Institute (SwRI)

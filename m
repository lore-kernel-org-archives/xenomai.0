Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 May 2010 08:05:06 +0200
Message-ID: <DFFBF4EB468A894AB1474ED220F05AF60134C0BA@srv-dc.ona-electroerosion.com>
From: "Asier Tamayo" <asier.tamayo@domain.hid>
Subject: [Xenomai-help] Xenomai and/or PREEMPT_RT patch
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

Hello all:

I'm just a newbie to this list, so just forgive me if my question is =
obvious or has been answered many times ;-)

I want to do a port from an old system running a proprietary RTOS to a =
new one based in Linux. My system runs many applications at the same =
time (GUI, parsers, ...), a few of which are hard real-time.=20

I've seen there are many approaches to the real-time issue in Linux; =
finally, it seems to me that the only solutions that will last are =
Xenomai and the PREEMPT_RT patches (OSADL). Am I wrong?

Can anybody give me some advice about which system to use? Any good =
comparison I can read? Everything I find comparing real-time Linux =
approaches seems to be quite out of date. Should I use Xenomai on its =
own? Or maybe Xenomai and Linux with the preempt patches applied? =
Running the GUI, which demands a lot of CPU and RAM, can have any effect =
on the real-time behaviour?

Any hint will be really helpful,

Best regards,

Asier


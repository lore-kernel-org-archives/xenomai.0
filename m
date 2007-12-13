Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Dec 2007 16:51:32 +0100
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E01A9B226@domain.hid>
From: "Thomas Necker" <thomas.necker@domain.hid>
Subject: [Xenomai-help] Oprofile with PPC in timer mode
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

I'm trying to get oprofile working on a MPC8270 with xenomai. However,
hardware perofromance counters don't seem to work due to a bug in the
603 processor. I tried it with oprofile's timer mode without success.
Before digging deeper: Has anyone experience with this? Since oprofile's
timer mode requires interrupts not to be disabled, I suspect this
interferes somehow with the adeos ipipe ...

Thomas


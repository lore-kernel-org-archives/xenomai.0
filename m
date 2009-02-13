Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Feb 2009 13:58:02 +0100
Message-ID: <4B2EEE69E41E524EB7FCDC62A15D68D80308F137@domain.hid>
From: <thomas.debes@domain.hid>
Subject: [Xenomai-help] Floating Point Exceptions in RT-Tasks
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

I successfully managed to enable FP Exceptions on our MPC5200 board for
plain linux applications (via fesetenv). When I put the same trigger
code (DivByZero) into a (native) RT task no exception is triggered until
I force a mode switch to secondary mode (e.g. printf). How can I get
them without performing the mode switch?

Thanks for your help!
Thomas


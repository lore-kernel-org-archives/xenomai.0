Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Nov 2007 09:32:45 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D375D71@domain.hid>
In-Reply-To: <2ff1a98a0711270657y63482de1ref80ba849f172918@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D375D6B@slcmail.slc.mew.int>
	<2ff1a98a0711270657y63482de1ref80ba849f172918@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] wathcdog
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> What is wrong with Xenomai watchdog and Linux soft lockup detector ?

The problem is that there doesn't seem to be a way for my application to
be notified that one of its thread was killed by the watchdog handler.
If there is a way for me to know this, then it would work fine. Please
let me know if there is a way for me to know.

Thanks,
Steven



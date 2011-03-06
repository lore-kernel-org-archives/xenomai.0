Date: Sun, 6 Mar 2011 12:58:53 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1299385072.2200.2.camel@domain.hid>
Message-ID: <alpine.DEB.1.10.1103061254350.23811@domain.hid>
References: <alpine.DEB.1.10.1102281209570.12109@domain.hid>
	<4D6B9032.5060907@domain.hid>
	<alpine.DEB.1.10.1102281325340.12109@domain.hid>
	<4D6B92C8.3070505@domain.hid>
	<alpine.DEB.1.10.1102281342180.12109@domain.hid>
	<4D6B97E5.5030901@domain.hid> 
	<alpine.DEB.1.10.1102281353490.12109@domain.hid>
	<4D6BA899.90600@domain.hid>
	<alpine.DEB.1.10.1102281944470.12808@domain.hid>
	<alpine.DEB.1.10.1103011145430.14165@domain.hid>
	<1299385072.2200.2.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] More blackfin kernel oops under heavy load
Reply-To: Kolja Waschk <xenoka09@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

> 100% reproducible here as well. Does this fix help?
> +++ b/arch/blackfin/mach-common/entry.S

Great, yes!

The real system is already up with this fix and running at highest load since
about one hour now, stable, without any OOPses.

Really good news. I was already reparing to backport some of our code to the older kernel... thank you so much!

Kolja



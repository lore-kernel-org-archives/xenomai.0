Content-Type: text/plain; charset="us-ascii"
Date: Mon, 20 Nov 2006 10:55:02 +0100
From: karre@domain.hid
In-Reply-To: <45616F69.5090404@domain.hid>
Message-ID: <20061120095502.244780@domain.hid>
MIME-Version: 1.0
References: <20061117143512.191580@domain.hid> <455DCBAB.4090204@domain.hid>
	<45606152.2000100@domain.hid> <45616F69.5090404@domain.hid>
Subject: Re: [Xenomai-help] System freezes with Xenomai 2.2.5 and kernel 2.6.17
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

Hi Jan,

that sounds very good! The notebook will need some time for compilation, but I am hopeful that your hint will be successful.

> Same config? Then the same issue I will explain below.

Concerning the processor type and PC speaker driver, yes.

> Not to forget "configure". Yes, that's the user-space part.

Yes, of course. Btw., is it normal that Xenomai's ./configure doen't need any interaction?

> That driver also uses the PIT and finally causes the lock-up. Upcoming
> Xenomai 2.3 detects the conflict and warns you, but 2.2 lets you trap
> into this without any hint.

Oh yes, I had to experience this is true ;)

> Yeah, I know those (likely) SuSE-related warnings as well. I never felt
> like looking for their reason, I can just say that they are harmless.

Ok, I didn't recognize any problems as well. So probably nothing to care about.

Thank you very much & have a nice day!

Richard


-- 
"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail


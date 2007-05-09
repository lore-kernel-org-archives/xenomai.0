Date: Thu, 10 May 2007 00:36:28 +0200 (CEST)
From: Herman Bruyninckx <Herman.Bruyninckx@domain.hid>
In-Reply-To: <20669310.1178719111471.JavaMail.ngmail@domain.hid>
Message-ID: <Pine.LNX.4.64.0705100031530.30761@domain.hid>
References: <Pine.LNX.4.64.0705091531560.22958@domain.hid> <4641B5CF.80303@domain.hid>
	<22908039.1178707932628.JavaMail.ngmail@domain.hid>
	<13086080.1178713660670.JavaMail.ngmail@domain.hid>
	<20669310.1178719111471.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized for
Reply-To: Herman Bruyninckx <herman.bruyninckx@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Wed, 9 May 2007, M. Koehrer wrote:

> thanks for your replies.
> I agree that is the best to do an approach that avoids critical sections.
> However, we have here the typical "historical heritage".

Nevertheless, I repeat my pledge _not_ to put new features in Xenomai
because of bad programming in legacy code! Every new feature will
automatically be considered by newcomers as good features, and that's _not_
the case! In my opinion, a good RTOS is one with a minimum of features, but
with a maximum of good application templates. (Call it "software patterns"
if you like.)

> That means I still have to count on the IPC provided by the OS.

I understand, but then I can't support your "complaint" about the Xenomai
features not being computationally optimal :-) _You_ have a bad legacy code,
so _you_ should pay the price for it, not the RTOS development or
maintainability...

Herman

Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm



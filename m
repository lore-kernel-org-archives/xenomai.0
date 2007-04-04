Content-Type: text/plain; charset="us-ascii"
Date: Wed, 04 Apr 2007 17:10:57 +0200
From: "Jack Whorn" <jackwhorn@domain.hid>
In-Reply-To: <1175674653.4666.9.camel@domain.hid>
Message-ID: <20070404151057.177770@domain.hid>
MIME-Version: 1.0
References: <20070328203115.190280@domain.hid>	
	<17930.56329.893396.220621@domain.hid>	
	<20070329031758.125210@domain.hid> <460B7CE0.60107@domain.hid>	
	<20070403200539.126240@domain.hid> <1175631875.22950.72.camel@domain.hid>	
	<20070403205554.107880@domain.hid> <1175674653.4666.9.camel@domain.hid>
Subject: Re: [Xenomai-help] Preemptive scheduling
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
To: rpm@xenomai.org, xenomai@xenomai.org


> Changeset r2092 introduced the sleeping scheduler lock for v2.3.x.

Hi Philippe,

I appreciate your help very much! I found and applied the diffs of changeset r2092. It seems to work much better now: The system is able to access the hard disk, as I see the LED blinking periodically. That`s great!

Still, I can`t use the keyboard to stop the application by pressing Strg-C. Also, the text cursor doesn`t blink, so the Linux system seems to be overloaded (probably, it`s no longer scheduled).

So, the Linux-Kernel now seems to be able to run on behalf of a high-priority task. Though, it is no longer scheduled as an idle task, which is ok as there is the higher priority-task with the infinite loop. This way, everything acts as expected.

Nevertheless, it would be interesting to run a linux shell concurrently. Can I adjust linux priority during runtime (or: where do I have to adjust it in the sources)?

And btw, where can I look up the keyboard interrupt`s priority (is it kernel`s priority)?

Thanks a lot,

Jack

-- 
"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail


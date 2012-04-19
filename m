From: Robert Berger <gmane@domain.hid>
Date: Thu, 19 Apr 2012 21:32:34 +0300
Message-ID: <jmplo1$l96$1@domain.hid>
References: <loom.20120419T145521-358@domain.hid>	<4F9019B0.9020500@domain.hid>
	<4F901A3E.7030807@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <4F901A3E.7030807@domain.hid>
Subject: Re: [Xenomai-help] P2020RDB with 3.1.5 kernel oops
Reply-To: gmane@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi Philippe,

I'm currently doing an Embedded Linux training for the PSI guys in
Switzerland and today we did the real-time chapter. We tried to get
Xenomai run on a p2020 with a 3.1.5 kernel and actually managed it with
your little patch ;)

We just enabled kgdb in the kernel config, the thing booted up and after
creating /dev/rtheap cyclictest with cycling.

As a side effect you just showed them how well community support works!

Thanks,

Robert..."Just because you don't understand it does not mean it's
random". - Dimitris F.

My public pgp key is available at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1




Date: Sat, 26 Apr 2008 14:45:26 -0700 (PDT)
From: George Pitich <george_pitich@domain.hid>
In-Reply-To: <952621.63539.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <647120.41017.qm@domain.hid>
Subject: Re: [Xenomai-help] xenomai installation
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

> Interestingly enough after a boot, klatency test
> runs,
> but if i stop it (ctrl-c) and run it again it
> segfaults:
> 
> /usr/xenomai/bin/xeno-load: line 180: 22756
> Segmentation fault      $suflag $* $cmdargs

just figured out that it might be because of (ARCH)
uname -i gives unknown?



      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ


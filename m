MIME-Version: 1.0
Date: Thu, 22 Sep 2011 12:25:20 +0200
Message-ID: <CAMJ=MEeNhEL+Zdc6KLj2LtwtWOSgvszyeEddCeCOqfeSS44Law@domain.hid>
From: Ronny Meeus <ronny.meeus@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Not possible to clone xenomai-force over http.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hello

I try to clone the xenomai-force repository over http since I'm behind
a firewall and observe following error:

meeusr@domain.hid$ git clone http://git.xenomai.org/xenomai-forge.git
Initialized empty Git repository in /home/meeusr/repo/xenomai-forge/.git/
fatal: http://git.xenomai.org/xenomai-forge.git/info/refs not found:
did you run git update-server-info on the server?
meeusr@domain.hid$

While the xenomai-head works fine.

meeusr@domain.hid$ git clone http://git.xenomai.org/xenomai-head.git
Initialized empty Git repository in /home/meeusr/repo/xenomai-head/.git/
Cloning into xenomai-head...

Can the http protocol also be activated for this repo?

Thanks,
Ronny


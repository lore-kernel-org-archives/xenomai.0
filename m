Message-ID: <4A5EF6E1.80108@domain.hid>
Date: Thu, 16 Jul 2009 11:46:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b88603c30907130031v9ec9618r46bd28b494ac3417@domain.hid>	
	<4A5CC870.3030208@domain.hid>	
	<b88603c30907160058n55d9a49eq644a2e326626bc01@domain.hid>	
	<4A5EE47E.5000507@domain.hid>	
	<b88603c30907160224o7a0ebde0w6d52016dc40fccbe@domain.hid>	
	<4A5EF277.8090304@domain.hid>
	<b88603c30907160239u3417036g1fa21251e7d4a379@domain.hid>
In-Reply-To: <b88603c30907160239u3417036g1fa21251e7d4a379@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ARM: userspace apps result in Segmentation fault
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> Please find attached the full .config

There seems to be something wrong with unlocked context switches. Are
you using the I-pipe patch which ships with the version of Xenomai you
are using? Or did you download some more recent patches on the Adeos site?

-- 
                                          Gilles



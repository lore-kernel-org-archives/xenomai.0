Date: Thu, 12 Apr 2007 16:14:22 +0200
From: Daniel Simon <Daniel.Simon@domain.hid>
Message-ID: <20070412161422.098f06f9@domain.hid>
In-Reply-To: <1175793189.7594.19.camel@domain.hid>
References: <20070403143122.4ac4ffaf@domain.hid>
	<46124C61.3070107@domain.hid>
	<20070403162752.2d4a1ae6@domain.hid>
	<46126603.1050007@domain.hid>
	<20070403170416.6c3f7ded@domain.hid>
	<46126DC3.8070905@domain.hid>
	<20070403171828.2da9c6fa@domain.hid>
	<46127166.9040503@domain.hid>
	<20070403175535.7340cc06@domain.hid>
	<46127DD8.8060502@domain.hid>
	<20070404181558.0ba333da@domain.hid>
	<4613D7CC.2040703@domain.hid>
	<20070405092815.15bd1af1@domain.hid>
	<20070405101200.10084177@domain.hid>
	<4614BA29.3010609@domain.hid>
	<20070405113420.0d2cc0ae@domain.hid>
	<1175766682.7594.9.camel@domain.hid>
	<20070405162558.23084607@domain.hid>
	<1175786178.7594.15.camel@domain.hid>
	<20070405183505.4062120f@domain.hid>
	<1175793189.7594.19.camel@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] large latencies on a Dell D620 dual core laptop
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

On Thu, 05 Apr 2007 19:13:09 +0200
Philippe Gerum <rpm@xenomai.org> wrote:


Hello, me again...

> Ok. Does enabling CONFIG_SMP and disabling CONFIG_IRQBALANCE still work?

No, more precisely, in console mode I was able to run a latency test, then it
hanged when rmmod-ing xeno_native.  On a second trial modprobe xeno_posix
immediatly freezed...

To summarize, xenomai tests work with a SMP enabled kernel in runlevel 2, but
only with a UP kernel in runlevel 3 or 5. 

It seems that NFS badly interracts with xenomai in SMP? Any other idea ?

	Daniel

-- 
      Daniel SIMON    Projet NeCS  INRIA Rhone-Alpes
ZIRST, 655 avenue de l'Europe, 38330 MONTBONNOT SAINT MARTIN, FRANCE 
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
	 http://necs.inrialpes.fr/people/simon/




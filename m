Date: Tue, 3 Apr 2007 17:04:16 +0200
From: Daniel Simon <Daniel.Simon@domain.hid>
Subject: Re: [Xenomai-help] large latencies on a Dell D620 dual core laptop
Message-ID: <20070403170416.6c3f7ded@domain.hid>
In-Reply-To: <46126603.1050007@domain.hid>
References: <20070403143122.4ac4ffaf@domain.hid>
	<46124C61.3070107@domain.hid>
	<20070403162752.2d4a1ae6@domain.hid>
	<46126603.1050007@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, 03 Apr 2007 16:34:43 +0200
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> If you compile Xenomai as a module, then Xenomai will not be started at
> boot time. And later, when loading Xenomai modules, even if
> CONFIG_XENO_HW_SMI_APMC is disabled, since the system has booted,
> starting Xenomai should not prevent the system from booting.

I can compile Xenomai_nucleus as a module (which is already done), but I  it
seems that CONFIG_XENOMAI must be set to y or n, "m" is not allowed
(or is there a way to bypass the config script?) 

-- 
      Daniel SIMON    Projet NeCS  INRIA Rhone-Alpes
ZIRST, 655 avenue de l'Europe, 38330 MONTBONNOT SAINT MARTIN, FRANCE 
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
	 http://necs.inrialpes.fr/people/simon/




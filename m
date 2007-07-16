Date: Mon, 16 Jul 2007 18:19:00 +0200
From: Daniel Simon <Daniel.Simon@domain.hid>
Message-ID: <20070716181900.3f075bc7@domain.hid>
In-Reply-To: <46960A4B.5070206@domain.hid>
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>
	<4668440F.7020706@domain.hid>
	<20070608124927.1b789a9e@domain.hid>
	<46693B6B.1010201@domain.hid>
	<20070625175107.438849fa@domain.hid>
	<467FF391.8020401@domain.hid>
	<20070627105726.7db7a459@domain.hid>
	<46825054.7030800@domain.hid>
	<20070629164326.15579570@domain.hid>
	<4690B86C.1000907@domain.hid>
	<20070711155932.4b88699e@domain.hid>
	<4694E96B.5020801@domain.hid>
	<20070711173545.709225f1@domain.hid>
	<4694FD99.3030405@domain.hid>
	<20070711185529.62544380@domain.hid>
	<469549AF.5090102@domain.hid>
	<20070712113039.14050727@domain.hid>
	<46960A4B.5070206@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] measuring tasks execution time
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 12 Jul 2007 13:02:35 +0200
Jan Kiszka <jan.kiszka@domain.hid> wrote:

Hi Jan,

> > -I am thinking about more demanding tests, with intertasks preemption and
> > overloads,

I have shaked my examples in various ways, with
preemptions, overruns and high load on the machine, and the exectime patch
behaves well, providing data consistent with the expectations (and with
the rt_timer_read() probe when usable).

	Daniel

-- 
       Daniel SIMON    Projet NeCS  INRIA Rhone-Alpes
        Inovallee, 655 avenue de l'Europe, Montbonnot
             38 334 Saint Ismier Cedex France
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
          http://necs.inrialpes.fr/people/simon/




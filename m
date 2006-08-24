From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Thu, 24 Aug 2006 07:31:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608240731.39283.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Buildbot reorgnized and will get prettier in the
	future
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi everybody

I invested quite a few hours to clean up my buildbot setup, as there
were a lot of hacks going into it during the last few months 
which had reduced considerably its readability.

The changes are now:
- Work based on the Debian package 0.7.3 of buildbot
- Documentation reworked/completed. It may be downloaded from:
  http://ngiger.dyndns.org/xenomai-data/xeno_buildbot.pdf
- master.cfg reworked
   - clearer parameter passing to subscripts
   - prepared for debugging (simple way to skip steps, handy
     if only the last script of a 1 hour compilation run fails)
   - merged hacks for RTnet, DENX-2.4 kernel into xenoSteps procedure
- scripts reworked, install*.sh merged into a single ruby script install.rb
- Some work as I would like to make the installation directory may be
  specified per through /path/buitbot/slave/<builder>/instDef.rb and no
  more in master.cfg (using installPattern). At the moment both must match.

As always the whole buildbot documentation and all scripts (except some
which contain passwords) may be downloaded from:
http://ngiger.dyndns.org/svn/admin/hcu3_linux/doc/buildbot/

Yesterday builbot 0.7.4 was released. I will try to switch to it and add the 
following improvements:
- cleaning up installPattern in master.cfg
- Prettier HTML output using a CSS.
- Adding a readable HTML output of the simulator errors
- May be use Debian init.d script to start/stop the daemons

Best regards

-- 
Niklaus Giger


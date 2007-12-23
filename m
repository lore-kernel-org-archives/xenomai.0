From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 23 Dec 2007 23:08:00 +0100
References: <200712231747.35449.niklaus.giger@domain.hid>
	<18286.42879.115252.945308@domain.hid>
In-Reply-To: <18286.42879.115252.945308@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712232308.01843.niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Buildbot is back (and reporting errors)
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi
Am Sonntag, 23. Dezember 2007 schrieb Gilles Chanteperdrix:
> Niklaus Giger wrote:
> 
> Are you sure these errors are related to Xenomai, do not you get the
> same errors if you build the kernel without Xenomai enabled ? Also,
> you should tell us which versions of Linux you used, and post a link to
> the kernel configuration.
> 
I tweaked the buildbot to also produce a link to the config used.
Is it better for you if I post only the link to a failed build like
http://ngiger.dyndns.org/buildbot/builders/tqm_f/builds/
or
http://ngiger.dyndns.org/buildbot/builders/ppc_q/builds/22

There you can by clicking on the link go to the stdio of the failing step 
to the standard output. You find also in the same step (or for the tqm case
in the step before) a link to 'config'.

On the same page you get also info about the revision and
branch used of the Xenomai tree. With the link to 'cmd2run' you
get info about which linux version the buildbot uses.

Aggregating all this information into one single page would demand 
quite some effort. I am at this moment not sure whether it is worth
the effort, but once running the tests on my board is incorporated
into the buildbot, I will take another look at this challenge.

Best regards

-- 
Niklaus Giger


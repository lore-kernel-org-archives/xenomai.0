Message-ID: <44394A9E.80309@domain.hid>
Date: Sun, 09 Apr 2006 19:55:42 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Proposal to use buildbot for Xenomai
References: <200604072337.48181.niklaus.giger@domain.hid>
In-Reply-To: <200604072337.48181.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi everybody
> 
> If you point your browser at http://ngiger.dyndns.org/buildbot/ (with ending 
> slash please), you will find a first prototype of the continuos integration 
> tool buildbot (http://buildbot.sourceforge.net/)
> 

Great stuff.

> It proves that it possible to automatically retrieve each revison of the 
> Xenomai and compile it for (at the moment) two targets, a stock PPC and a 
> custom PPC405 board (cross-compiling).
> 
> At the moment it already is useful for me, but I would like to ask your 
> opinion about its usefulness. Would this be useful for you too? Do you have a 
> special target to propose (other architectures, other target like skins, all 
> xenomai components as modules/built-ins, mvm simulator)?
> 

With the growing number of supported archs, not to speak of the two 
major kernel versions supported (2.4/2.6) for some of them, a tool 
providing continuous integration is clearly extremely useful, since it's 
now virtually impossible for all developers to systematically check 
their work against all possible arch/config combinations.

Additionally, setting up a build slave for any particular arch of 
interest is something users wanting to contribute back could do rather 
easily, and specifically companies who happen to be happy Xenomai users.

AFAIC, the upside would be to be able to produce performance numbers 
after the builds by running regression tests, so that we could evaluate 
the impact of core changes almost immediately.

-- 

Philippe.


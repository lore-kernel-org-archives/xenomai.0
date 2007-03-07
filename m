From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-core] Debian rule set.
Date: Wed, 7 Mar 2007 22:44:43 +0000
References: <200703070332.47745.paul_c@domain.hid>
	<17903.6084.618033.175847@domain.hid>
In-Reply-To: <17903.6084.618033.175847@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703072244.43107.paul_c@domain.hid>
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


Hi Gilles

On Wednesday 07 March 2007 19:51, Gilles Chanteperdrix wrote:
> That is great. It means that we should try and solve the includedir
> issue. However, from a maintenance point of view, would not it make mor  
> sense to modify the prepare-kernel script to that it suits the needs of
> debian packaging than to have a second script almost like it in the
> debian directory ?

Modifying the prepare-kernel script would be preferable in the long term, but 
I didn't see much point initially for three reasons - The initial rule set 
is "proof of concept" and would benefit from some peer review (also need to 
tweak a few lines).. Second, the prepare-kernel script would require 
extensive modifications for the needs of one or two people. Finally, the 
kernel patching system in Debian has some new features currently 
in "experimental", so when these make their way in to testing/unstable, the 
prepare-kernel & patch generation would need to be overhauled.


Regards, Paul.


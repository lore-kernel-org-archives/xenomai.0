From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17903.6084.618033.175847@domain.hid>
Date: Wed, 7 Mar 2007 20:51:32 +0100
Subject: Re: [Xenomai-core] Debian rule set.
In-Reply-To: <200703070332.47745.paul_c@domain.hid>
References: <200703070332.47745.paul_c@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

Paul wrote:
 > 
 > Attached is a rule set for generating a series of Debian packages. Four 
 > packages are generated, these are:

That is great. It means that we should try and solve the includedir
issue. However, from a maintenance point of view, would not it make mor
sense to modify the prepare-kernel script to that it suits the needs of
debian packaging than to have a second script almost like it in the
debian directory ?

-- 


					    Gilles Chanteperdrix.


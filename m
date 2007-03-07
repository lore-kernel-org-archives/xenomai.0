From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-core] --includedir ignored
Date: Wed, 7 Mar 2007 23:53:51 +0000
References: <200703051548.12008.paul_c@domain.hid>
	<1173309302.5059.49.camel@domain.hid>
In-Reply-To: <1173309302.5059.49.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703072353.51568.paul_c@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

On Wednesday 07 March 2007 23:15, Philippe Gerum wrote:
> include/compat is not installed on purpose, since what goes to
> $(prefix)/include is aimed at compiling user-space code only, and files
> under the compat/ root are placeholders for compiling Xenomai-enabled
> 2.4 kernels.

OK - That makes sense.. If the compat/ includes are specific to 2.4 kernels, 
then there would be little reason to put them in any 2.6 patches.


Regards, Paul.



From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17236.37957.919219.175800@domain.hid>
Date: Tue, 18 Oct 2005 08:20:53 +0200
Subject: Re: [Xenomai-core] Cosmetic changes to script xeno-config + man page
In-Reply-To: <200510180217.41806.rlenglet@domain.hid>
References: <200510170157.58507.rlenglet@domain.hid>
	<4353D250.9050807@domain.hid>
	<200510180217.41806.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Romain Lenglet <rlenglet@domain.hid>
Cc: xenomai@xenomai.org

Romain Lenglet wrote:
 > > if you see an error, please provide a proper patch.
 > 
 > Here is a patch that includes the correction of xeno-config.in 
 > and the manpage. If someone wants to add it to the patch tracker 
 > on the Gna! project page, please do it.

You are supposed to be able to ad that patch to the tracker: being a
logged-in user should be enough to be able to post a patch. I do not
think it wise to open it to anonymous users, it would open it for use by
spammers.

 > I am currently working on manpages for xeno-load(1) and 
 > runinfo(5) (for the format of .runinfo files). I will send a 
 > patch with these.

Thanks. Note that you will need to document the latency test. This looks
important, because this is the first program users should run, before
messing with .runinfo.

In order to compare Xenomai with other Debian packagees, I checked
gtk-config, and I have a few remarks on xeno-config and its manpage.

gtk-config is made to be sourced from configure scripts, so that
configure scripts have a simple way to know whether GTK is installed,
and a simple way to get the glib_* variables and export them to the
generated makefiles.

When run with no arguments, xeno-config prints the usage, but most
importantly returns an error. I would suggest firstly that we do not
print anything, after all the standard way to get help is the --help
or -h argument, but if you do insist that you want help, I admit
configure script may redirect output when sourcing xeno-config. But I
strongly suggest we return 0, otherwise, there is no simple way
for a configure script to know whether Xenomai is correctly installed.

gtk-config has no --verbose option and I wonder how useful this option
is. I mean, if you want to have the variables list, you may run (modulo
we do not return 1 as status when called with no arguments)
. xeno-config
set | grep '^XENO'

Now, about the manpage itself, unless I am wrong, the DESTDIR feature is
not documented, it is very useful when compiling for a target.

-- 


					    Gilles Chanteperdrix.


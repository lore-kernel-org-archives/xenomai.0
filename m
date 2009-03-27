From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1238006810.6815.102.camel@domain.hid>
References: <1238006810.6815.102.camel@domain.hid>
Content-Type: text/plain
Date: Sat, 28 Mar 2009 00:31:31 +0100
Message-Id: <1238196691.6815.273.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Migrating to GIT
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
Cc: Wolfgang Grandegger <wg@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>

On Wed, 2009-03-25 at 19:46 +0100, Philippe Gerum wrote:
> We are about to convert our SVN repos to GIT trees. This operation will
> take place between Thursday, March 26, 3pm CET and Friday 27, 8am CET.
> Please make sure to pull the data you need from those repos before we
> start the migration. Starting from Friday morning, everything will be
> available anew via GIT trees, and the old SVN repos will not be
> accessible anymore. Committers, please push pending patches before
> tomorrow afternoon as well, or wait for Friday.
> 
> Detailed instructions for cloning the Xenomai code from the GIT trees
> will be sent on Friday to the lists, and also made available from our
> Wiki on xenomai.org.
> 
> Sorry in advance for any inconvenience this may cause.
> 

Since this morning, our repos are available from http://git.xenomai.org/
for browsing, and can be cloned via a read-only access from our main
site as well.

To clone the current development version (formerly known as the SVN trunk, aiming at 2.5), use:

git clone git://xenomai.org/xenomai-head.git

To clone the maintenance branch of a given stable version 'X', use:

git clone git://xenomai.org/xenomai-2.X.git

-- 
Philippe.




Message-ID: <4BEEE3D9.8060000@domain.hid>
Date: Sat, 15 May 2010 20:11:37 +0200
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] New Debian source package format 3.0
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

Hi,

for some time now, Debian has the new source package version 3.0 [1] to 
which I'm currently migrating the Xenomai package.

This has the following consequences:

* I don't need to repackage the upstream tarball anymore, since with the 
new format, dpkg supports bzip2 besides gz, among others
* There are actually 2 different 3.0 package formats: "native" and 
"quilt". While the former is appropriate for maintaining "Upstream" and 
Debian together in one single place, the latter is appropriate for 
Debian packages that have an upstream development location outside Debian.
* To migrate appropriately, you can do the following changes in the 
xenomai.org repository:

$ mkdir debian/source
$ echo '3.0 (native)' > debian/source/format
$ dch 'Switch to dpkg-source 3.0 (native) format'

   while I will do accordingly at Debian with "native" replaced by 
"quilt". (Maintaining it as "native" in both locations would only be 
reasonable if Debian would have official Xenomai release privileges 
which is neither the case nor necessary. - E.g. maintenance of "old" 
Xenomai versions in Debian stable while xenomai already has newer 
versions available.)
* You can remove the "-x" Debian revision from the native Debian package 
and the watch file at xenomai.org.
* Debian now ships a ".debian.tar.gz" file instead of ".diff.gz" for the 
"quilt" version.
* Take care of "native" instead of "quilt" when synchronizing with the 
"downstream" Debian package

Thanks for considering.

bye,
   Roland

[1] http://wiki.debian.org/Projects/DebSrc3.0


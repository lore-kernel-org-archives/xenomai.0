From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <40BF7732.801@domain.hid>
References: <40BF7732.801@domain.hid>
Content-Type: text/plain
Message-Id: <1086251506.682.28.camel@domain.hid>
Mime-Version: 1.0
Date: Thu, 03 Jun 2004 10:31:47 +0200
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Re: Patch/Code maintanance
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Wolfgang Grandegger <wolfgang.grandegger@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Thu, 2004-06-03 at 21:08, Wolfgang Grandegger wrote:
> Hi Philippe,
> 
> I started porting ADEOS to PowerPC with "2.4r11c1" and now I want to
> catch up with "24r13c2" before I release it. I realized that there are
> quite some differences and I wonder how you maintain the ADEOS code,
> especially how do you get or handle the files in "linux" and "patches".
> 

There are two major trees, one for 2.4, the other for 2.6, respectively
available under linux/v2.4 and linux/v2.6.

For each supported kernel version, I simply create some "shadow tree"
under linux/v2.x/<kernel-ver>-<arch>, only containing the kernel files
modified by Adeos.

The generic Adeos support which is the same for any version of the host
kernel in a given major branch is stored under linux/v2.x/adeos-core.

Basically, merging a kernel-specific tree with the Adeos generic support
gives you all the files applicable to a genuine kernel tree in order to
Adeos-enable it. This way, for working on Adeos, you just need to untar
the vanilla kernel tree of interest, and replace the set of affected
files by symlinks to the corresponding files in the CVS tree.

When a development milestone has been reached for a given kernel release
/ Adeos revision, I simply build a patch against the corresponding
vanilla tree, and feed patches/ with it. The same patch is then copied
to the download area on GNA, and a news is published there.

> Thanks.
> 
> Wolfgang.
-- 

Philippe.



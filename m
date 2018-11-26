From: Steve Pavao <stevep@korgrd.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Date: Mon, 26 Nov 2018 15:08:15 -0500
Subject: ipipe-arm64 kernel config questions
Message-Id: <47AB2CE9-6B2A-4C41-A82C-E07AA672AAFB@korgrd.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Is there a kernel config snippet available which contains only the =
real-time specific options of the ipipe-arm64 kernel?  If so, could =
someone please point me to it?  If not, could someone please make it =
available?  I need it so I can merge it with the config I use in Yocto =
to build my customized Linux system.

Background: Sometimes, I build my customized system to use the =
raspberrypi/linux kernel; other times I build it to use the ipipe-arm64 =
kernel.  I need to merge the real-time specific options of the =
ipipe-arm64 default config into my existing default config for my Yocto =
build, such that I can have an acceptable minimal default config for =
ipipe-arm64.  Currently, the two configs are wildly divergent, thus the =
desire to merge only the minimal config changes needed for ipipe-arm64 =
real-time benefits.

If this is possible, I plan to use the Linux utility script =
merge-configs to achieve this.  If this is not possible, I can provide =
the output of the diffconfig script, which shows a concise diff of the =
differences between the two config files.  Given that, maybe someone =
could analyze that, and inform me as to which of the kernel options that =
are different or added for ipie-arm64are the ones that truly have an =
impact on real-time performance.

Steve Pavao
Korg R&D



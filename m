Subject: Re: [Xenomai-core] ChangeLog for ADEOS IPIPE patches?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45F902ED.6050900@domain.hid>
References: <45F902ED.6050900@domain.hid>
Content-Type: text/plain
Date: Thu, 15 Mar 2007 09:44:17 +0100
Message-Id: <1173948257.8193.4.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Scholz <steven.scholz@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2007-03-15 at 09:25 +0100, Steven Scholz wrote:
> Hi all,
> 
> is there a ChangeLog for ADEOS IPIPE patches like
> ksrc/arch/arm/patches/adeos-ipipe-2.6.19-arm-1.6-03.patch ?
> 

No luck, not for this particular release, since we were transitioning
from CVS to git at that time, and such information has been lost in the
process.
The old ChangeLog (when we were using CVS) is there,
http://cvs.gna.org/cvsweb/ChangeLog?cvsroot=adeos
Since we are now git-based, and the ARM branch has been recently merged
into the official Adeos git repo, the summary of changes for this
architecture can be found here:
http://www.denx.de/cgi-bin/gitweb.cgi?p=ipipe-2.6.git;a=shortlog;h=ipipe-2.6.19-arm

-- 
Philippe.




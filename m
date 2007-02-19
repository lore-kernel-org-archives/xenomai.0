From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17882.10993.117100.127933@domain.hid>
Date: Mon, 19 Feb 2007 23:55:45 +0100
Subject: Re: [Xenomai-core] Re: RT-Socket-CAN versioning
In-Reply-To: <45D9E59B.8040002@domain.hid>
References: <45D9DF65.9000300@domain.hid>
	<45D9E59B.8040002@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Wolfgang Grandegger wrote:
 > > Hi Jan,
 > > 
 > > currently the RT-Socket-CAN drivers maintains it's own version or
 > > release number. As RT-Socket-CAN is part of Xenomai, I do not see the
 > > need for it (and so far I did not update it). What is the intended use
 > > of "driver_version" in "struct rtdm_device"?
 > 
 > Actually, I was thinking about this too yesterday. The idea of the
 > separate versioning for RTDM drivers is to signal the users if something
 > in the driver really changed. It's fairly obvious what to do with it for
 > out-of-tree drivers, but for in-tree it might be worth considering the
 > policy.
 > 
 > The current model, maintained more or less properly for the existing
 > drivers, is to increment independently of Xenomai according to major or
 > minor changes. One may ease this burden for the driver developer by
 > simply filling in Xenomai's version here. That would just let the
 > revisions increase on every Xenomai release, even if the driver remained
 > untouched. The tag would still have a meaning for out-of-tree drivers,
 > but for in-tree it would be fairly meaningless.
 > 
 > Well, whatever is commonly preferred, it should then be applied
 > consistently on all RTDM drivers in Xenomai. What are the opinions on
 > this list (I will comment afterwards)?
 > 
 > > Furthermore, there is also
 > > "profile_version" (which does not show up n the Doxygen docu for some
 > > strange reason).
 > 
 > The automatic update from the latest SVN must be broken on
 > www.xenomai.org, there is more stuff missing.

The automatic update only updates the web site from the contents of the
"generated" directory. In order to update this directory, go to the
"doc" subdirectory of the build tree and type "make generate-doc", then
run svn commit in the "generated" directory. I will install the proper
version of doxygen and regenerate the documentation.

-- 


					    Gilles Chanteperdrix.


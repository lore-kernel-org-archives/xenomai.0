Message-ID: <44182400.1050907@domain.hid>
Date: Wed, 15 Mar 2006 15:26:08 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] SVN usage
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


This is a quick note to provide everyone using Xenomai's SVN repositories the 
basic survival kit:

- Our repositories are hosted on the GNA site, which provides us with all the 
needed SCM infrastructure, among other things. The proper URL to visit in order to 
get started is this one: http://gna.org/svn/?group=xenomai

- The SCM we use there is Subversion ("SVN"). Subversion does not really impose 
any directory layout to hold its contents, but strongly recommends using one in 
particular, though. And since we are good boys, we use it too. The directories 
below can be found at the top of our SVN area, and we use them as follows:
	
	trunk/ is used for bleeding edge Xenomai development toward the next version, 
major or minor (e.g. from 1.x -> 2.x, or 2.x -> 2.y). Contributors with SVN write 
access try to keep this tree in a reasonably good shape, usually in a compilable 
state at least, but it's not always possible to only commit tested and validated 
code in this branch. Actually, it would even be counter-productive, since new 
developments need to have [brave] contributors giving them hell, and as many 
eyeballs as possible reviewing them. Therefore, don't use this tree for production 
or otherwise required-to-be-stable systems, unless you really, really know what 
you are doing. The trunk is currently heading to v2.2.

	tags/ is used to hold frozen snapshots of the trunk or maintenance branches, 
taken at the exact moment each release is made. At any point in time, when you 
need an older or the most recent release of Xenomai - for which you can also find 
an archive on the project's download area with the very same contents -, just tap 
into this directory. You will likely find what you are looking for. Both testing 
(i.e. -rc) and deemed stable versions are available from there.

	branches/ is used to hold the maintenance branches, i.e. SVN trees of released 
stable versions that entered a maintenance cycle. Those trees get updated over 
time with important/desirable fixes. Those updates never alter the functionalities 
or API specs of the base version, they are only there to fix stability or code 
correctness issues. For instance, v2.1 has now entered the maintenance cycle since 
it has been released as being the most recent stable Xenomai version. To this end, 
the 2.1.x tree has appeared under the branches/ top-level directory. Fixes for 
v2.1 will be done on this tree, and from time to time, a snapshot of it will be 
taken and copied to the tags/ top-level, leading to v2.1.1, v2.1.2 and so on. We 
currently have two maintenance branches, respectively for the v2.0 and v2.1 base 
versions.

-- 

Philippe.


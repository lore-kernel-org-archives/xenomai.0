Message-ID: <4F167BD2.306@domain.hid>
Date: Wed, 18 Jan 2012 08:59:14 +0100
From: RT <rwatollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] ensuring code running in kernel modules has realtime
	priority
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi all,

we have an interesting situation. We are using a module to do communication 
over a network (ethercat master module) to some remote IO.

The ethercat module is loaded against the kernel in the normal manner.

Now we possibly have overlooked that even though the call to the ethercat 
module (ioctl call) from our real-time application takes place in a xenomai 
real time task, the code of the ethercatmodule may be interrupted by other 
processes running on the machine. Due to the fact that the modules code is 
not running in any real-time prioritized space.

If this is indeed the case, what would be the best or easiest manner to 
ensure that the module does not get interrupted, ie. to encapsulate it into 
the xenomai real-time priority sphere?

Hope someone can point us in the right direction here. Its pretty urgent 
because the system is already running live and we are intermittently 
encountering this problem.

Kind regards,

Roland.


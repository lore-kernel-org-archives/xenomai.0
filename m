Message-ID: <4F16A454.5010602@domain.hid>
Date: Wed, 18 Jan 2012 11:52:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F167BD2.306@domain.hid>
In-Reply-To: <4F167BD2.306@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ensuring code running in kernel modules has
 realtime priority
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: RT <rwatollenaar@domain.hid>, Xenomai-help@domain.hid

On 01/18/2012 08:59 AM, RT wrote:
> Hi all,
> 
> we have an interesting situation. We are using a module to do communication 
> over a network (ethercat master module) to some remote IO.
> 
> The ethercat module is loaded against the kernel in the normal manner.
> 
> Now we possibly have overlooked that even though the call to the ethercat 
> module (ioctl call) from our real-time application takes place in a xenomai 
> real time task, the code of the ethercatmodule may be interrupted by other 
> processes running on the machine. Due to the fact that the modules code is 
> not running in any real-time prioritized space.
> 
> If this is indeed the case, what would be the best or easiest manner to 
> ensure that the module does not get interrupted, ie. to encapsulate it into 
> the xenomai real-time priority sphere?
> 
> Hope someone can point us in the right direction here. Its pretty urgent 
> because the system is already running live and we are intermittently 
> encountering this problem.

If I understand correctly, what you need is to rewrite the ethercat
driver as a real-time driver using the RTDM skin.

-- 
					    Gilles.


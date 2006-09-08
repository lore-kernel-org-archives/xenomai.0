From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17665.25952.422461.493251@domain.hid>
Date: Fri, 8 Sep 2006 14:43:12 +0200
Subject: Re: [Xenomai-help] Resource leaking problem
In-Reply-To: <45015AF8.6070004@domain.hid>
References: <450157A6.80000@domain.hid>
	<45015AF8.6070004@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:
 > > What do we have to do in order to clean up all resources properly,
 > > especially if our application is ended by SIGKILL?
 > 
 > Install a signal handler and do cleanup of all allocated objects (tasks
 > get deleted when they terminate).

Installing a signal handler for SIGKILL will not work, you should try
and handle SIGTERM gracefully, and accept, in case of SIGKILL (which
should remain rare anyway) to have to unload/reload Xenomai if it is
compiled as a module, or reboot if it is built-in.

-- 


					    Gilles Chanteperdrix.


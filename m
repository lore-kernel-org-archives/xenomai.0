Message-ID: <48641162.5040907@domain.hid>
Date: Fri, 27 Jun 2008 00:00:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <406CC9939904F143B9D42CEEA3E56E563331EA@oab1mx1.oneaccess.intra>
In-Reply-To: <406CC9939904F143B9D42CEEA3E56E563331EA@oab1mx1.oneaccess.intra>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] help: pipe + event flag group (or
 other	synchronisation mechanism
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Filip Van Rillaer <Filip.VanRillaer@domain.hid>
Cc: xenomai@xenomai.org

Filip Van Rillaer wrote:
> Hello, 
> 
> Our application is written with some kind of super-loop scheduling : we
> have many drivers that call rt_event_signal (when data have been written
> to the hardware or new data are available to be processed) and 1 task
> that is calling rt_event_wait. After receiving an event, the superloop
> task is then reading/writing the data from/to the appropriate driver.
> Those calls to the drivers must never block (except to some locking to
> protect the consistency of data-structures) to garantuee the real-time
> behaviour of the application.
> Now we want to communicate with the Linux-domain and thought we have to
> use the Xenomai pipe-object for that purpose.
> 
> How can the superloop task in Xenomai receive an event from the
> pipe-object when data are available to be read/written (so without
> already reading the data)?
> 
> The ideal solution would be if one can ask the pipe-driver to call a
> user-callback function when there is a change in the status (read/write)
> or an equivalent system to the EPOLL interface (from the uclinux
> domain).

Xenomai posix skin has support for the "select" call, which requires
some support from each driver, and you can already select from a posix
message queue. This is another solution.

-- 


					    Gilles.


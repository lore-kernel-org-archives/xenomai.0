Message-ID: <45F57B43.5040308@domain.hid>
Date: Mon, 12 Mar 2007 17:09:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] App with pthreads using rt_task_shadow locks up
References: <447063209@domain.hid>
In-Reply-To: <447063209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jochen Behnke <JK.Behnke@domain.hid>
Cc: xenomai@xenomai.org

Jochen Behnke wrote:
> Hello,
> 
> I am currently porting software form a windows based control system to Xenomai. The application creates 3 realtime tasks which build the core of the control unit. Up to this point everything worked fine. The next milestone of this project is to integrate network communication using sockets and pthreads with the control system. The implementation of my - let's call it "SimpleRPC" -  library uses sockets and pthreads. At runtime this library creates at least 3 pthreads (1 that listens for incoming connections, 1 that performs socket I/O per connected client, 1 that executes the requested functions). As the functions, that are called by the workerthread, use xenomai mutexes to synchronize critical sections of code, the workerthread needs to be a realtime task scheduled by xenomai. So I use rt_task_shadow, to "convert" the pthread into a xenomai realtime task. When this code is executed, my application locks up and I have to restart the whole system. When I remove the rt_task_s
hadow call everything is fine, except for the calls to rt_mutex_lock that return an error code because the calling context is not a realtime task.
> 
> I am using
> Xenomai 2.2.3
> Linux Kernel 2.6.17
> 
> What's wrong ?
> How can I debug this problem ?

Please try your example on the latest release of Xenomai. If it still
fails post here an example which fails, reduced to the minimum.

> 
> Any hint is appreciated.
> 
> 
> Jochen
> 
> 
> P.S.:
> Is there an easy way to search the xenomai mail archives ? At the moment I walk through them more or less manually.

Use google, simply add site:mail.gna.org at the end.

-- 
                                                 Gilles Chanteperdrix


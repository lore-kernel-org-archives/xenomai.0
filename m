Message-ID: <4460AEA5.2060201@domain.hid>
Date: Tue, 09 May 2006 17:00:53 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] IPIPE mutex?
References: <E1FdT2V-00013a-Lm@domain.hid>
In-Reply-To: <E1FdT2V-00013a-Lm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Florian Pose <florian@domain.hid>
Cc: adeos-main@gna.org

Florian Pose wrote:
> Hello everybody,
> 
> I'm using an IPIPE domain for a cyclic realtime task and I have a cyclic
> kernel timer applet running in the default domain. This two processes
> now share a common resource. So I have to use some locking method, that
> ensures, that if the process with the lower priority (e. g. the kernel
> timer) holds the lock and the process with the higher priority (RT task)
> is scheduled, the first one is scheduled again until it releases the lock.
> 
> In ADEOS there is a adeos_mutex_lock() call seeming to do exactly what I
> want. Unfortunately IPIPE  doesn't seem to have such a call.
> 
> How do I solve the problem with IPIPE?
> 

The only way is to provide your own support for that. The I-pipe is just 
a simple and straightforward real-time enabler a RTOS can use to build 
complex services. E.g. www.xenomai.org.

-- 

Philippe.


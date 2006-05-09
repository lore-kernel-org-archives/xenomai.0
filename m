Date: Tue, 09 May 2006 16:17:41 +0200
From: Florian Pose <florian@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <E1FdT2V-00013a-Lm@domain.hid>
Subject: [Adeos-main] IPIPE mutex?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hello everybody,

I'm using an IPIPE domain for a cyclic realtime task and I have a cyclic
kernel timer applet running in the default domain. This two processes
now share a common resource. So I have to use some locking method, that
ensures, that if the process with the lower priority (e. g. the kernel
timer) holds the lock and the process with the higher priority (RT task)
is scheduled, the first one is scheduled again until it releases the lock.

In ADEOS there is a adeos_mutex_lock() call seeming to do exactly what I
want. Unfortunately IPIPE  doesn't seem to have such a call.

How do I solve the problem with IPIPE?

Thanks a lot,
Florian


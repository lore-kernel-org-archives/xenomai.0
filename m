Message-ID: <49F9959E.2020504@domain.hid>
Date: Thu, 30 Apr 2009 14:12:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1a8178a117805c2dc47266d6a1b9d49f.squirrel@domain.hid>
In-Reply-To: <1a8178a117805c2dc47266d6a1b9d49f.squirrel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] --posix-ldflags and rt_task_shadow() of main
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Frederik Bayart <frederik.bayart@domain.hid>
Cc: xenomai@xenomai.org

Frederik Bayart wrote:
> Hallo,
> 
> I have a following question :
> 
> I have an executable linked linked with
> xeno-config --posix-ldflags
> 
> so depends on :
> libpthread_rt.so.1
> 
> If I want to turn my main function into a realtime task with
> rt_task_shadow like code sample below, EBUSY is returned and I get the
> message :
> 
> rt_task_shadow() failed: Device or resource busy.
> 
> This would mean that my main task is already a realtime task and I don't
> have to call rt_task_shadow anymore. Is this correct ? It seems very
> strange to me and I didn't find any documentation which confirms that if
> you link with posix-flags your main thread is automatically realtime.
> 
> I don't get this message if I link with the xeno-config --xeno-ldflags,
> but the reason that I want to link with the posix flags is that I also
> use the shm_open function in my binary.

You are correct, the main thread is automatically shadowed by the POSIX
skin library. This makes things much more consistent, and simplifies the
user experience: an applications using the POSIX API continues to
compile and to work without further changes with Xenomai posix skin,
automatically using Xenomai posix skin services when they exist.

You can disable this behaviour with the configure --enable-dlopen option.

Note that POSIX skin shared memory services are only useful to share
memory between kernel and user-space using the posix API. If you want to
share memory between user-space real-time applications, you can simply
use the libc shared memory services.

-- 
                                                 Gilles.


Message-ID: <49381646.5050305@domain.hid>
Date: Thu, 04 Dec 2008 18:41:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1227226604.13217.13.camel@domain.hid>	
	<4926859D.4090208@domain.hid>
	<1228242306.29066.5.camel@domain.hid>
	<1228409020.8435.25.camel@domain.hid>
In-Reply-To: <1228409020.8435.25.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] shared memory mlockall error w/ mono	interpreter?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henry Bausley <hbausley@domain.hid>
Cc: xenomai@xenomai.org

Henry Bausley wrote:
> This problem seemed to be caused by the boehm garbage collector used in
> mono.  The Boehm garbage collector uses SIGXCPU and SIGPWR to
> synchronize cross-thread garbage collection.  Recompiling the mono
> garbage collector to use a different signal values (SIGRTMIN + 5)
> instead of SIGXCPU seems to have solved the problem. Does this make
> sense.

Yes, it makes sense, since SIGXCPU is used before the creation of the
first real-time thread to signal that mlockall has not been called.

-- 
                                                 Gilles.


Message-ID: <3f7e4e30c68612bf269e955922cf6f82.squirrel@domain.hid>
In-Reply-To: <c024fefc0811200055r309fbedar73531c856f27565a@domain.hid>
References: <c024fefc0811200055r309fbedar73531c856f27565a@domain.hid>
Date: Thu, 20 Nov 2008 13:48:31 +0100 (CET)
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Interprocess Mutex
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrian Boeing <me@domain.hid>
Cc: xenomai@xenomai.org


Adrian Boeing wrote:
> Hi,
>
> Is it possible to create an inter-process mutex between kernel space and
> user space?
> If so, how is this done with the native API?
>
> The system has one real-time kernel process which communicates with other
> processes via shared memory.

See rt_mutex_bind:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__mutex.html#g39b3a0e7f6f6ee41b8068ed59e25d1d1
or, for the posix skin, pthread_mutexattr_setpshared:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__posix__mutex.html#g73bd8697b91e0ee9a63c30052ac9f72f
Note that for sharing a mutex with the posix skin, the pthread_mutex_t
structure needs to reside on a shared memory.

-- 
                    Gilles.



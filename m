Message-ID: <46430F23.9010501@domain.hid>
Date: Thu, 10 May 2007 14:25:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7289437c0705100445j228b59c0h950f366dd2e12b18@domain.hid>
In-Reply-To: <7289437c0705100445j228b59c0h950f366dd2e12b18@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Threads Posix real time and not real time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

Perrine Martignoni wrote:
> Is it possible to do communicate a thread posix real time and a thread
> posix non real time?

No, the native skin has such a feature (message pipes), but this feature
has no incarnation in the posix skin.

The way to do this with the posix skin is to create a thread with
SCHED_OTHER policy and priority set to 0, and to have this thread
communicate with real real-time threads with a posix message queue and
do non real-time duties.


> Can we create a thread posix non real time with some options?

To create a non real-time thread, use __real_pthread_create instead of
pthread_create.

-- 
                                                 Gilles Chanteperdrix


From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17540.21517.871383.751462@domain.hid>
Date: Mon, 5 Jun 2006 17:55:57 +0200
Subject: Re: [Xenomai-help] shm_open, ftruncate
In-Reply-To: <4484365A.7090007@domain.hid>
References: <4480595D.7040203@domain.hid>
	<17536.29324.723709.385494@domain.hid>
	<4484365A.7090007@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Lionel Perrin <perrin@domain.hid>
Cc: xenomai@xenomai.org

Lionel Perrin wrote:
 > Ok, thanks, i'll try. My old pc will have some job... :)
 > 
 > I still have a few questions :
 > - How can we load/unload posix skin ?

When configuring your kernel, configure the posix skin as a module. A
module xeno_posix.ko will then be compiled that you may load with
modprobe and unload with modprobe -r.

 > - Will this shared memory be accessible to non rt-task ?
 > - What's the simplest way to share information with a non rt-task ?

Shared memory are also accessible to non-rt tasks. Since user-space
realtime and non-realtime threads from the same process reside in the
same address space, the simplest way to share information from rt to
non-rt tasks is to create them as threads of the same process.

-- 


					    Gilles Chanteperdrix.


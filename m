From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17541.50338.44905.768689@domain.hid>
Date: Tue, 6 Jun 2006 20:08:34 +0200
Subject: Re: [Xenomai-help] shm_open, ftruncate
In-Reply-To: <44856CA7.30802@domain.hid>
References: <4480595D.7040203@domain.hid>
	<17536.29324.723709.385494@domain.hid>
	<4484365A.7090007@domain.hid>
	<17540.21517.871383.751462@domain.hid>
	<44856CA7.30802@domain.hid>
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
 > 
 > >  > - Will this shared memory be accessible to non rt-task ?
 > >  > - What's the simplest way to share information with a non rt-task ?
 > >
 > > Shared memory are also accessible to non-rt tasks. Since user-space
 > > realtime and non-realtime threads from the same process reside in the
 > > same address space, the simplest way to share information from rt to
 > > non-rt tasks is to create them as threads of the same process.
 > >   
 > Ok, but I figure out that it's possible to share memory between 
 > processes ? (rt and non rt?)
 > For the moment, i focus on sharing between two rt tasks, but in vain :(
 > I still have a ftruncate error (EBADF) when i launch two rt processes...
 > I explain :
 > I've tried the attached program. I've added a sleep(1) between mmap and 
 > munmap. I launch this appli twice with
 >  >> shm_test &
 >  >> shm_test &
 > For the second one, I got "ftruncate: Invalid argument". Am I the only 
 > one to have this problem ?

No, these errors were due to a few fixes in trunk that had not been
backported to the 2.1 branch. It should now be fixed in the repository.

-- 


					    Gilles Chanteperdrix.


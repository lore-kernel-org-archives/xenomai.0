MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18480.25075.894860.415321@domain.hid>
Date: Sun, 18 May 2008 19:05:55 +0200
In-Reply-To: <48305C5D.3020601@domain.hid>
References: <18459.38249.462320.715909@domain.hid>
	<18459.38430.835407.942336@domain.hid>
	<18459.38500.720338.652195@domain.hid>
	<18459.38558.684426.240775@domain.hid>
	<18459.38644.699369.801548@domain.hid>
	<18459.38704.252719.734650@domain.hid>
	<18459.38785.367098.763153@domain.hid>
	<18459.38879.202210.838294@domain.hid>
	<48305C5D.3020601@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [Patch 7/7] Re-implementation of mutexes,
 user-space support.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > Gilles Chanteperdrix wrote:
 > > Since binding of the semaphore heaps is now made by xeno_skin_bind, there is
 > > much less modifications in src/skins/posix/init.c. However, I had to do
 > > something really ugly: since binding the semaphore heaps by xeno_skin_bind
 > > requires calls to open, ioctl, mmap, close and munmap, I redefined these symbols
 > > to be the __real_ variants before including bind.h.
 > 
 > Is there any upside to do this instead of simply calling the __real_*
 > placeholders, since we do already provide weak wrappers for those when the
 > linker's wrapping magic is not invoked?

The point is that the wrappers and linker magic only take place for
POSIX skins. Other skins have to call the genuine open, ioctl, mmap,
close and munmap services.


-- 


					    Gilles.


From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17536.26455.989597.805286@domain.hid>
Date: Fri, 2 Jun 2006 18:29:11 +0200
Subject: Re: [Xenomai-help] shm_open, ftruncate
In-Reply-To: <4480595D.7040203@domain.hid>
References: <4480595D.7040203@domain.hid>
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
 > Hi,
 > 
 > I got some problems with shared memory.
 > I started from the shm_open example from opengroup.org.
 > When I compile it as non real time tasks, it works properly. But since I 
 > tried to compile it with
 > gcc $(xeno-config --posix-cflags) shm_open.c $(xeno-config 
 > --posix-ldflags) -o xeno_shm_open,
 > i get an EINVAL error from ftruncate that i can fix.
 > 
 > Does shm under xenomai require particular things ?

The posix skin does not use the new per-process cleanup callback yet, so
you have to clean yourself the mappings, i.e. do not forget to call
munmap before exiting your processes, or unload and reload the POSIX
skin module before running your program.

I tried your program and it did not fail here as it fails for you: mmap
is returning an error of ENXIO, because of some bug that I am currently
fixing.

-- 


					    Gilles Chanteperdrix.


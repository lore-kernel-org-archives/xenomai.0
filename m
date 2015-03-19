Date: Thu, 19 Mar 2015 22:29:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150319212905.GD6571@hermes.click-hack.org>
References: <20150319140703.GC25508@csclub.uwaterloo.ca>
 <20150319144041.GB787@hermes.click-hack.org>
 <20150319155939.GD25508@csclub.uwaterloo.ca>
 <20150319160403.GC787@hermes.click-hack.org>
 <20150319164326.GE25508@csclub.uwaterloo.ca>
 <CAEMXjGyOG8340cOOYJiPgugfka7L01yRGaXgufWDWiURZcVQcw@mail.gmail.com>
 <20150319165400.GE787@hermes.click-hack.org>
 <CAEMXjGxVHjAbLh0jEWF1fJbdVA+1PhiEa1oF9KbNXiEaqCJr8A@mail.gmail.com>
 <20150319200302.GA6571@hermes.click-hack.org>
 <20150319212204.GC6571@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150319212204.GC6571@hermes.click-hack.org>
Subject: Re: [Xenomai] Building with hard float: cannot open shared object
 file libpthread_rt.so.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve B <sbattazzo@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Mar 19, 2015 at 10:22:04PM +0100, Gilles Chanteperdrix wrote:
> 		if ((pow_int(f, n) != pow(f, n)) / pow_int(f, n) > 1e-6) {
It's                 pow_int(f,n) - pow(f, n)

-- 
					    Gilles.


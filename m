From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <1085039096.683.24.camel@domain.hid>
References: <20040513080053Z2337767-21100+17499@domain.hid>
	 <1084901992.2994.27.camel@domain.hid>
	 <Pine.LNX.4.53.0405191422130.4035@domain.hid>
	 <1085039096.683.24.camel@domain.hid>
Content-Type: text/plain
Message-Id: <1085430680.3905.25.camel@domain.hid>
Mime-Version: 1.0
Date: Mon, 24 May 2004 22:31:20 +0200
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Re: kernel 2.6.5 and HAL patch
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: rtai@domain.hid
Cc: adeos-main@gna.org

On Thu, 2004-05-20 at 09:44, Philippe Gerum wrote:
> On Wed, 2004-05-19 at 13:26, Rus V. Brushkoff wrote:
> > On Tue, 18 May 2004, Philippe Gerum wrote:
> > 
> > :> lines after stop (probably - made partialy from of some other succesful boot log, line feeding is too fast)>
> > :> VFS: Mounted root (ext2 filesystem) readonly.
> > :> Trying to move old root to /initrd ... okay
> > :> Freeing unused kernel memory: 156k freed
> > :> Usage: init 0123456SsQqAaBbCcUu
> > :> Usage: init 0123456SsQqAaBbCcUu
> > :> Usage: init 0123456SsQqAaBbCcUu
> > :> Usage: init 0123456SsQqAaBbCcUu
> > :> Usage: init 0123456SsQqAaBbCcUu
> > :> ... endlessly repeating
> > :>
> > :
> > :Ok, this one is framed now. It should also explain the lockup at boot,
> > :which looks like a variation of the same problem. I need a bit more time
> > :banging my head on the wall in order to solve it, but there's hope. In
> > :any case, it's a 2.6-specific Adeos bug in r5c2. Adeos patches for 2.4
> > :kernels are totally immune from this one.
> > 
> >  Strange, I tried 2.6.5, and now using 2.6.6 with slightly modified r5c2 -
> > no problem at boot. Though there are some problems with fifo - now I'm
> > investigating it ...
> >  Looks like corrupted init or corrupted kernel patch - in kernel source
> > (init/main.c:run_init_process()) init started with no options at all.
> > 
> 
> In fact, init is indeed called with no arg by the booting kernel. The
> problem is that some additions from r5c2 to the sysenter/sysexit support
> utterly trash the registers on the syscall return path; oh, well...
> So when init asks for its pid by calling getpid(), it gets back zero,
> instead of one. In reaction, it simply emits a plain usage message and
> exits, before being respawned a number of times, failing the same way.
> You and I did not experiment this problem because our glibc install
> still uses the traditional 'int 0x80' method for syscalling which is
> immune to this bug, not the newer sysenter/sysexit protocol.
> 
> I intend to come up with r5c3 fixing this bug next week, after a few
> days of stress testing.
> 

This nasty bug has been fixed:
http://download.gna.org/adeos/patches/v2.6/i386/candidates/adeos-linux-2.6.5-i386-r5c3.patch

-- 

Philippe.



Date: Fri, 26 Dec 2014 18:15:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141226171502.GC1692@daedalus>
References: <45638F48-3A57-4E45-929F-5514BAA38A72@gatech.edu>
 <20141226155843.GB1692@daedalus>
 <616956CF-ECB5-42BD-B1D4-CC8FBCC196DB@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <616956CF-ECB5-42BD-B1D4-CC8FBCC196DB@gatech.edu>
Subject: Re: [Xenomai] Spurious relax test?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: xenomai@xenomai.org

On Fri, Dec 26, 2014 at 11:55:57AM -0500, Yogi A. Patel wrote:
> 
> > On Dec 26, 2014, at 10:58, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> > 
> > On Fri, Dec 26, 2014 at 12:46:58AM -0500, Yogi A. Patel wrote:
> >> Hi -
> >> 
> >> I’ve implemented the code provided on the Xenomai website for finding spurious relaxes in Xenomai 2 - however I’m a bit skeptical about whether or not I’ve implemented it correctly since I don’t ever see any output to the terminal.
> >> 
> >> Is there any way to “induce” a relax to test the implementation and know that it is in fact catching any drops to secondary mode?
> > 
> > See examples/native/sigdebug.c
> 
> Thanks, Gilles. I implemented the warning method using the example as a guide.
> 
> It appears to be working - however I’m a bit puzzled by the output here.
> 
> The only error I am getting is: SIGDEBUG received, reason 2: invoked syscall
> rtxi(_Z17rt_switch_warningiP9siginfo_tPv+0x3d)[0x43883d]
> /lib/x86_64-linux-gnu/libpthread.so.0(+0x10340)[0x7f71e54a9340]
> /lib/x86_64-linux-gnu/libpthread.so.0(sem_post+0x2d)[0x7f71e54a790d]
> 
> The application I am testing is a Qt based application - I have a feeling these are all coming from the posting of events to the Qt event stack but can’t tell for sure.
> 
> Is there a way/how can I get more information from the trace?

gdb

-- 
					    Gilles.


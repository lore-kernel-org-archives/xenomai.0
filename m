Date: Tue, 20 Jan 2015 12:12:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150120111219.GG2963@hermes.click-hack.org>
References: <214896079.184274.1421401577183.JavaMail.zimbra@wandercraft.eu>
 <20150116165318.GC1157@hermes.click-hack.org>
 <1415631089.199145.1421752128845.JavaMail.zimbra@wandercraft.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1415631089.199145.1421752128845.JavaMail.zimbra@wandercraft.eu>
Subject: Re: [Xenomai] xenomai 3-next kernel boot failed exit signal 15
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Cc: xenomai@xenomai.org

On Tue, Jan 20, 2015 at 12:08:48PM +0100, Huy Cong Vu wrote:
> 
> 
> ----- Mail original -----
> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> > À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> > Cc: xenomai@xenomai.org
> > Envoyé: Vendredi 16 Janvier 2015 17:53:18
> > Objet: Re: [Xenomai] xenomai 3-next kernel boot failed exit signal 15
> 
> > On Fri, Jan 16, 2015 at 10:46:17AM +0100, Huy Cong Vu wrote:
> >> Hello everyone,
> >> I pulled the xenomai 3 - next branch & patch into linux 3.14.17 kernel on an x86
> >> Intel. The system failed to boot up.
> >> Here are the 2 lines in kernel log when failed:
> >> kernel: Kernel logging (proc) stopped.
> >> rsyslogd: [origin software="rsyslogd" swVersion="5.8.6" x-pid="580"
> >> x-info="http://www.rsyslog.com"] exiting on signal 15.
> >> I think I followed the guide in "TROUBLESHOOTING" section & "Configuring for
> >> x86-based dual kernels" but maybe I missed something.
> >> I attached the kernel config file, if any1 can show me where I was wrong I'll be
> >> very grateful.
> > 
> > As explained on this page:
> > https://xenomai.org//asking-for-help/
> > 
> > We need much more than two lines of the logs to help you.
> > 
> In fact, I tried to investigate further on the problem, it seems that it only occurs if I tried to build RTNet in kernel, if I builded it as module, I can boot into the kernel normally:
> CONFIG_XENO_DRIVERS_NET=m
> 
> Is this a normal behavior?

As explained here:
https://xenomai.org/pipermail/xenomai/2014-December/032750.html

RTnet should only be built as a module for now.

-- 
					    Gilles.


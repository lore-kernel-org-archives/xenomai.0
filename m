Date: Fri, 10 Apr 2015 18:14:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150410161403.GS20752@hermes.click-hack.org>
References: <5527DF9B.9020304@galauner.de>
 <20150410152959.GQ20752@hermes.click-hack.org>
 <5527F517.1090809@galauner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5527F517.1090809@galauner.de>
Subject: Re: [Xenomai] Xenomai on Linux 3.18 on Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Galauner <andreas@galauner.de>
Cc: xenomai@xenomai.org

On Fri, Apr 10, 2015 at 06:06:47PM +0200, Andreas Galauner wrote:
> On 10.04.2015 17:29, Gilles Chanteperdrix wrote:
> > Maybe you already tried since you tried "all kinds of things", but
> > better be sure, have you tried enabling Xenomai and I-pipe debugging
> > options? 
> 
> Sorry for that sloppy phrase, it's a side project and I lost track what
> exactly I did over the last weekends.
> 
> I just enabled the I-pipe debugging features. I didn't know that they
> are under "Kernel hacking". The Xenomai debugging features were enabled
> all the time.
> 
> Sadly, I don't get any messages that may relate to my system behaviour.
> Actually no messages at all except the initialization messages of i-pipe
> and Xenomai.
> 
> What I forgot to mention is, that it's not a complete freeze. It seems
> to me, that the system just gets horribly slow. The heartbeat LED stops
> blinking and I get occasional terminal output (1-2 lines) until it stops
> completely.
> 
> There seem to be three points where the kernel may hang:
> 1) Somewhere in the driver init phase
> 2) While mounting the rootfs
> 3) At the login prompt or idle shell
> 
> And as I said, sometimes I get a few more lines from the kernel after a
> while.

The classical issues to check are irq issues and timer issues. Since
you are using a non mainline kernel (I guess), you may simply lack
some changes to the code added by your non mainline kernel. To fix
that, you can use the following document:

https://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/

-- 
					    Gilles.


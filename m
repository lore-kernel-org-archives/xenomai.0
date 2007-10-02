From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1191341918.6019.25.camel@domain.hid>
References: <353969d40709180729s54307285i983eb7cc24c90642@domain.hid>
	<1190138931.15100.22.camel@domain.hid> <1191341918.6019.25.camel@domain.hid>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 18:32:32 +0200
Message-Id: <1191342752.6019.30.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Can't create more than one watchdog
	under	vxworks skin
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Guillaume Gaudonville <guillaume.gaudonville@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2007-10-02 at 18:18 +0200, Philippe Gerum wrote:
> On Tue, 2007-09-18 at 20:08 +0200, Philippe Gerum wrote:
> > On Tue, 2007-09-18 at 16:29 +0200, Guillaume Gaudonville wrote:
> > > Hi,
> > > 
> > > I use Xenomai since a few time. I have to port an application
> > > running under VxWorks on Linux. This application uses a lot of
> > > watchdog
> > > to delay job it has to do.
> > > 
> > > When I use the function wdCreate under the VxWorks skin (in User
> > > Space), 
> > > I am not able to create more than 1 watchdog. I watched to the
> > > function implementation in 
> > > user space and I saw that when I call wdCreate, a task is created with
> > > the name: wdserver.
> > > 
> > > When I call wdCreate a second time, it returns me 0 because he can't
> > > create 
> > > another task with the same name (wdServer). But my watchdog seems to
> > > be created in
> > > kernel space because I can see it
> > > in /proc/xenomai/registry/vxworks/watchdog.
> > > 
> > > Is it a mistake? If not, what is the reason for this behaviour? 
> > > 
> > 
> > The current implementation is definitely silly. It should create one
> > server for all outstanding watchdogs.
> 
> The attached patch against -rc3 does this.
> 

Please note the ABI change; we need this to be able to notify a
per-process watchdog server. As a consequence of this change, the
VxWorks shared library version has been incremented.

-- 
Philippe.




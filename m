Date: Mon, 26 Jan 2015 15:08:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150126140826.GI12812@hermes.click-hack.org>
References: <129277905.Ag2XebZWbK@soho> <8367559.zdLagntR1r@indiana>
 <20150126120824.GF12812@hermes.click-hack.org>
 <2052908.cWhQn5Pgch@soho>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2052908.cWhQn5Pgch@soho>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Packaging Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On Mon, Jan 26, 2015 at 01:39:31PM +0100, Leopold Palomo-Avellaneda wrote:
> El Dilluns, 26 de gener de 2015, a les 13:08:24, Gilles Chanteperdrix va 
> escriure:
> > On Sun, Jan 25, 2015 at 07:43:21PM +0100, Leopold Palomo-Avellaneda wrote:
> > > El Diumenge, 25 de gener de 2015, a les 19:10:16, Philippe Gerum va 
> escriure:
> > > > On 01/25/2015 12:14 PM, Leopold Palomo-Avellaneda wrote:
> > > > > But I was thinking in performance aspects comparing a system with
> > > > > cobalt
> > > > > vs a system with mercury.
> > > > 
> > > > Yes, but the results are now outdated (2011). This said, such benchmark
> > > > hardly reflected a use case. It was more a Xenomai 2.6.x vs 3.x analysis
> > > > of basic mechanisms (event notification, serialization, buffer exchange
> > > > etc) for measuring the impact of moving most of the real-time API
> > > > implementation to user-space, only keeping the core resource management
> > > > in kernel space. It proved to be positive.
> > > > 
> > > > Mercury vs Cobalt was only a by-product of those tests, specifically on
> > > > x86_32.
> > > 
> > > After this thread, I think more firmly that the libs should be renamed in
> > > the manner that they could be co-installed in the same root, standard
> > > places.
> > > 
> > > Please upstream, could you think about it?
> > 
> > This is a decision that upstream should not impose to all users.
> 
> Interesting sentence. You are developing a new version with an step forward. 
> You have reworked libraries and for instance libxenomai, libnative, librtdm 
> doesn't exists in Xenomai-3. Also you have introduced new ones (libalchemy, 
> libcobalt, libcopperplate, libtrank. 
> 
> You have developed xenomai in two main group of libraries (or use a cobalt 
> kernel or a mercury kernel) and are you saying that you cannot impose to all 
> users a suffix or something that the users could have both version co-
> installed in standards places in their systems?

What I am saying is that Xenomai user-space support is delivered
with a configure script giving users a choice to install things
wherever they want. I do not see any reason to hardcode a particular
choice in xenomai itself.

> 
> > Only users with your specific needs should do what you want. 
> 
> Maybe I'm wrong. But after reading this thread I understood that to have a 
> kernel with both patches (i-pipe and preempt_rt) and, I understand, Xenomai-3 
> with the two versions could be a very interesting system to work on.

Sure, but in that case you would have two xenomai build trees, that
you can configure with different options so that they do not collide
once installed.

> 
> For instance, I'm in the robotics field, and after that mails I thought that 
> it could be a good solution that fit the cases where you have several loops, 
> with several rates with different importance.
> 
> > And
> > in fact, I believe simply using the configure script options, it is
> > possible to install libraries in different directories. Maybe even
> > the --program* options apply to libraries too.
> 
> Not really. 

Do you dismiss it because you have tried and it did not work?
Because if that is the case, we would be interested to see any error
message you got, and help solve them.

> It's nice if you a have a package.

What has this to do with anything ? A "package" is just a script
which runs configure with some options chosen to fit a distribution
then make and make install. If you are the Debian maintainer then it
is your job to choose the options to pass to configure to fit the
need of Debian. But there is no reason to hardcode these options in
the upstream package, so that other distributions can choose other
options.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150126/6459bff5/attachment.sig>

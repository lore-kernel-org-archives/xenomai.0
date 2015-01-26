Date: Mon, 26 Jan 2015 15:55:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150126145505.GJ12812@hermes.click-hack.org>
References: <129277905.Ag2XebZWbK@soho> <2052908.cWhQn5Pgch@soho>
 <54C648B7.8040105@xenomai.org> <1511773.t4MVMy7lsq@soho>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1511773.t4MVMy7lsq@soho>
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

On Mon, Jan 26, 2015 at 03:47:03PM +0100, Leopold Palomo-Avellaneda wrote:
> El Dilluns, 26 de gener de 2015, a les 15:01:27, Philippe Gerum va escriure:
> > On 01/26/2015 01:39 PM, Leopold Palomo-Avellaneda wrote:
> > > Maybe I'm wrong. But after reading this thread I understood that to have a
> > > kernel with both patches (i-pipe and preempt_rt) and, I understand,
> > > Xenomai-3 with the two versions could be a very interesting system to
> > > work on.
> > > 
> > > For instance, I'm in the robotics field, and after that mails I thought
> > > that it could be a good solution that fit the cases where you have
> > > several loops, with several rates with different importance.
> > 
> > You are missing an important point: Xenomai 3 over Mercury is about
> > running non-POSIX RTOS APIs over a native kernel (with or without
> > preempt-rt, this is orthogonal to the issue).
> 
> this is an interesting point.
> 
> [...]
> 
> > 
> > Therefore, your proposal mainly addresses the issue of running a mixed
> > configuration, with some Mercury-based application(s) ported from a
> > traditional RTOS to linux, and other application(s) running over Cobalt
> > in dual kernel mode, concurrently on the same system. People who just
> > want to run POSIX apps over a native kernel don't need Xenomai 3. In
> > short, the potential user base for the mixed setup as described is quite
> > small.
> > 
> > With that in mind, using a mixed installation root between Mercury and
> > Cobalt also means that any 2.x Makefile currently using "xeno-config"
> > would have to be fixed up, to reflect the new suffixed path or call
> > pkg-config to retrieve it, whatever fits. We have been advertising
> > xeno-config since years, as a mean to stay away from installation
> > specifics, so this would be quite wrong to end up asking people to run
> > xeno-config-cobalt or xeno-config-mercury.
> 
> xeno-config --with-core=cobalt/mercury
> 
> could be a solution. But, some default core should be defined.
> 
> > As I mentioned already, we won't go for single binaries running over
> > both cores, the performance and maintenance impact would be a nightmare.
> 
> Yes, two types of binaries. Your argumentation was clear.
> 
> > Since all our build system is autoconfiscated, you can pick any root
> > prefix that makes sense, and even fine tune every installation directory
> > already (lib, include, bin etc). This means that having multiple roots
> > is definitely a non-issue, and does not introduce any limitation.
> > 
> > I don't buy the "suffix to disambiguate" argument either:
> > /usr/lib/libvxworks-m.so is not clearer than
> > /usr/lib/mercury/libvxworks.so, or
> > /usr/xenomai/mercury/lib/libvxworks.so. And this does not even work
> > better with /usr/lib/libvxworks-mercury.so.
> > 
> > Besides, there is no shortage of ways to find out which Xenomai
> > configuration your build system and even your application is currently
> > depending on. 
> 
> well, I usually ask to ldd. So, if I have a binary and I run:
> 
> ldd /usr/local/lib/libcpp4ec.so
> 	linux-vdso.so.1 (0x00007fffee0dc000)
> 	libsoemrt.so.1.3.0 => /usr/local/lib/libsoemrt.so.1.3.0 
> (0x00007feea2352000)
> 	librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007feea214a000)
> 	libnative.so.3 => /usr/lib/libnative.so.3 (0x00007feea1f40000)
> 	libxenomai.so.0 => /usr/lib/libxenomai.so.0 (0x00007feea1d39000)
> 	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 
> (0x00007feea1b1c000)
> 	libpugixml.so.1 => /usr/lib/x86_64-linux-gnu/libpugixml.so.1 
> (0x00007feea18e7000)
> 	librtdm.so.1 => /usr/lib/librtdm.so.1 (0x00007feea16e5000)
> 
> for example, if I had libvxworks-cobalt there, I knew that my binary was built 
> against xenomai with cobalt.
> 
> 
> > The only requirement is to query the right xeno-config
> > script or application, which may be as simple as setting the PATH
> > variable appropriately for your setup:
> > 
> > $ xeno-config --core
> > mercury
> > $ xeno-config --cflags
> 
> [...]
> 
> Yes, I liked. I thought that it was a good solution but I don't know if it's 
> fhs, if follow debian/fedora policies for instance. That's all. It was my 
> first idea to propose you but I asked and to put libraries in places non-
> standards isn't a good idea. I'm investigating it. 
> 
> But, for instance in debian mentors irc they found it "Sounds suspicious"

Again: pass to the configure script the option
--program-suffix=-cobalt 

And xeno-config will be named xeno-config-cobalt.

Please stop this useless discussion. Xenomai has all the flexibility
to allow you install things how you see fit.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150126/d19794da/attachment.sig>

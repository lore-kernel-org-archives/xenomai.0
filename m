Date: Wed, 25 Feb 2015 10:32:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150225093213.GM14148@hermes.click-hack.org>
References: <CANWkrRPBG=3+k4GkcrMEO4fBb=tmvn+XKRR6t8S+p+r_ffm6vg@mail.gmail.com>
 <54EB4E8E.8040804@xenomai.org>
 <CAB+DZ3=s-pHrt=U_YN5qYo7Vtic9f-WfQQBwK3znBTdN_iVOmw@mail.gmail.com>
 <54EC8CBD.6000500@xenomai.org>
 <CAB+DZ3=cB3URuV57Pa5g3fHkvuPyeKza_-8UYJkqvP8Ruj45hQ@mail.gmail.com>
 <54ED94CE.3040409@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54ED94CE.3040409@xenomai.org>
Subject: Re: [Xenomai] Failed testsuite/latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Michael Smith <2michael.smith@gmail.com>, xenomai@xenomai.org

On Wed, Feb 25, 2015 at 10:24:30AM +0100, Philippe Gerum wrote:
> On 02/25/2015 09:33 AM, Bart Vissers wrote:
> > Hi Philippe,
> > 
> > Before making any changes, I ran xeno-config --info:
> > Xenomai version: Xenomai/cobalt v3.0-rc3 --
> > Linux rtpc 3.16.7-xenomai-3.0-rc3 #1 SMP Mon Feb 23 12:30:46 CET 2015
> > i686 GNU/Linux
> > Kernel parameters: BOOT_IMAGE=/boot/vmlinuz-3.16.7-xenomai-3.0-rc3
> > root=UUID=0925426e-e058-4093-963c-8b7de072e229 ro quiet
> > I-pipe release #2 detected
> > Cobalt core 3.0-rc3 detected
> > Build args: --prefix=/usr --includedir=/usr/include/xenomai
> > --mandir=/usr/share/man --with-testdir=/usr/lib/xenomai/testsuite
> > --build i486-linux-gnu build_alias=i486-linux-gnu
> > 
> > namelist did not work, as latency does not contain any symbols. How
> > can I include these when building debian packages?
> 
> I don't have much knowledge of the Debian pkg system, but the way I used
> to do this was:
> 
> export DEB_BUILD_OPTIONS="debug nostrip"
> 
> before building the package, maybe adding "noopt" if you also want to
> disable the optimizer, although this is not required for keeping the
> namelist. Gilles certainly has more on this.

We separate packages on 2.6 with only the debug symbols, named
xenomai-runtime-debg and libxenomai1-dbg, you need to install them
to have the debug symbols. But I do not think you need the debug
symbols to list the dynamic symbols of a binary, the dynamic symbol
tables is not remove by the stripping process. Simply run:

nm -D /path/to/latency


-- 
					    Gilles.


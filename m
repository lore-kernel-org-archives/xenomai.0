From: Paul <paul_c@tuxcnc.org>
Date: Fri, 5 Sep 2014 22:21:10 +0100
References: <20140905184346.GN17690@csclub.uwaterloo.ca>
 <540A2563.1050304@xenomai.org> <20140905211515.GR17690@csclub.uwaterloo.ca>
In-Reply-To: <20140905211515.GR17690@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201409052221.11293.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] How to get debug symbols in xenomai libraries
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Friday 05 September 2014, Lennart Sorensen wrote:
> On Fri, Sep 05, 2014 at 11:04:35PM +0200, Gilles Chanteperdrix wrote:
> > On 09/05/2014 11:03 PM, Lennart Sorensen wrote:
> > > On Fri, Sep 05, 2014 at 10:57:10PM +0200, Gilles Chanteperdrix 
wrote:
> > >> On 09/05/2014 10:54 PM, Lennart Sorensen wrote:
> > >>> On Fri, Sep 05, 2014 at 10:31:35PM +0200, Gilles Chanteperdrix 
wrote:
> > >>>> Just tried a fresh build with minimal flags, simply:
> > >>>>
> > >>>> configure --enable-debug CFLAGS="-fomit-frame-pointer"
> > >>>> --host=arm-linux-gnueabihf
> > >>>> make
> > >>>> arm-linux-gnueabihf-gdb
> > >>>> src/skins/common/.libs/libxenomai.so.0.0.0
> > >>>>
> > >>>> and gdb says it can find symbols. (-fomit-frame-pointer is
> > >>>> needed with the toolchain I use, otherwise gcc complains that
> > >>>> it can not use the r7 register).
> > >>>
> > >>> I tried adding that option, and still gdb says no symbols.
> > >>>
> > >>> Toolchain is debian wheezy's gcc 4.6, and everything is
> > >>> natively compiled.
> > >>
> > >> Do you build the package manually, like I just did? Or do you
> > >> use the debian/rules stuff?
> > >
> > > I use the debian/rules, but I set
> > > DEB_CFLAGS_APPEND=-fomit-frame-pointer and I added --enable-debug
> > > to the configure line in debian/rules and I set
> > > DEB_BUILD_OPTIONS=nostrip
> >
> > Could you try a manual build?
>
> That makes installing such a pain and the gcc lines had all the right
> arguments (-g -fomit-frame-pointer etc).  And we did want to debug
> with as close to the normal runtime build as possible.

In which case, you will need to edit the debian/rules - Remove the 
dh_strip lines and you should retain the debug symbols.


Regards, Paul.




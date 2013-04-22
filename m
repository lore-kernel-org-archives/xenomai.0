MIME-Version: 1.0
In-Reply-To: <517468DB.1050701@zultron.com>
References: <CACWvio7X6LGNpmBk2MQXQZY3gyzHHMHrx3aJXTG7dM08mOM=LQ@mail.gmail.com>
	<51725772.7050305@zultron.com>
	<CACWvio61cz7SR-KWBFjOCbEnof6T6jqfmsKbvV6ubxRJ1E1RhA@mail.gmail.com>
	<517468DB.1050701@zultron.com>
From: Ankit Goila <agoila@umich.edu>
Date: Mon, 22 Apr 2013 14:47:58 -0400
Message-ID: <CACWvio5Y5QC_FK8LEV2TvzCidbHvZ34eY5MadsdBXToey6c=rA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Trouble with Xenomai - Desktop issues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: xenomai@xenomai.org

On Sun, Apr 21, 2013 at 6:31 PM, John Morris <john@zultron.com> wrote:

> On 04/21/2013 04:37 PM, Ankit Goila wrote:
> > Hi John,
> >
> > Thanks for your reply. I currently have Ubuntu 12.10 installed on my
> > machine. In order to use the pre-compiled packages, do I need to just
> > compile the code given online through the command line? Or do I need
> > some other packages as well? The Ubuntu currently has the kernel version
> > 3.5.0-17-generic.
> >
> > Regards,
> >
> > Ankit
>
>
>
>
> >
> >
> > On Sat, Apr 20, 2013 at 4:53 AM, John Morris <john@zultron.com
> > <mailto:john@zultron.com>> wrote:
> >
> >
> >
> >     On 04/19/2013 11:41 PM, Ankit Goila wrote:
> >     > Hello friends,
> >     >
> >     > I am working on setting up my machine for real time capability
> using
> >     > Xenomai. The specs are: Intel Xeon CPU (with 8 cores), Ubuntu 12.10
> >     > (Linux-3.5.0-17-generic).
> >     > Recently, I installed Ubuntu 12.10 on my machine and configured it
> for
> >     > Xenomai 2.6.2.1 kernel, following the instructions given on this
> page:
> >     >
> >
> http://www.stanley.gatech.edu/skelly/uncategorized/installing-xenomai-on-ubuntu-12-04/#comment-932
> >     >
> >     > I was successful with the setup and the grub menu shows the
> >     xenomai kernel
> >     > installed. But, on booting into the Xenomai option, a desktop is
> >     displayed
> >     > without any menu/task bar etc. The PC freezes upon booting, with no
> >     > internet connection available. Here is the screenshot of the
> post-boot
> >     > screen. I think this might be a problem with configuring the
> >     kernel, but
> >     > then there are no set rules for configuration for a particular
> >     machine. I
> >     > will be really grateful if somebody could help me out here.
> >     >
> >     > - Ankit
> >     >
> >
> >     Hi Ankit,
> >
> >     Want to give some pre-compiled Debian packages a try?  See here:
> >
> >     http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernelPackages
> >
> >     Also, if your NIC happens to be the r8168, you should compile that
> >     driver separately.  There's a Debian package for that one as well,
> >     pointed to in the above link.
> >
> >             John
>
>
Hi John,

I tried the Linux CNC pre-compiled packages mentioned in the link above, I
followed all the instructions as per the article. On reboot, I am able to
access the desktop from the Grub menu, however, the keyboard and the mouse
are unresponsive. In a way, I can see the desktop, everything as such, but
am not able to provide any input. Is this a configuration issue? Or is it
with the drivers?

- Ankit


-- 
Ankit Goila
U-M ID: 83509056
Graduate Student (2012-2014)
M.S.E Mechanical Engineering
University of Michigan, Ann Arbor
Contact: 734-747-0829

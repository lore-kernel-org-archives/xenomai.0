Message-ID: <517468DB.1050701@zultron.com>
Date: Sun, 21 Apr 2013 17:31:55 -0500
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <CACWvio7X6LGNpmBk2MQXQZY3gyzHHMHrx3aJXTG7dM08mOM=LQ@mail.gmail.com>
	<51725772.7050305@zultron.com>
	<CACWvio61cz7SR-KWBFjOCbEnof6T6jqfmsKbvV6ubxRJ1E1RhA@mail.gmail.com>
In-Reply-To: <CACWvio61cz7SR-KWBFjOCbEnof6T6jqfmsKbvV6ubxRJ1E1RhA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Trouble with Xenomai - Desktop issues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ankit Goila <agoila@umich.edu>
Cc: xenomai@xenomai.org

On 04/21/2013 04:37 PM, Ankit Goila wrote:
> Hi John,
> 
> Thanks for your reply. I currently have Ubuntu 12.10 installed on my
> machine. In order to use the pre-compiled packages, do I need to just
> compile the code given online through the command line? Or do I need
> some other packages as well? The Ubuntu currently has the kernel version
> 3.5.0-17-generic.
> 
> Regards,
> 
> Ankit

Hi Ankit,

Please read the instructions on the webpage linked to in the previous
email.  I believe you should be familiar with installing software
packages on Ubuntu, where no compilation is necessary.

For Ubuntu 12.10 you should use the 'precise' debian archive, so

  CODENAME=precise

then follow the rest of the instructions as usual.

Also take a look here, and avoid top-posting on this list:

http://en.wikipedia.org/wiki/Posting_style#Placement_of_replies

	John




> 
> 
> On Sat, Apr 20, 2013 at 4:53 AM, John Morris <john@zultron.com
> <mailto:john@zultron.com>> wrote:
> 
> 
> 
>     On 04/19/2013 11:41 PM, Ankit Goila wrote:
>     > Hello friends,
>     >
>     > I am working on setting up my machine for real time capability using
>     > Xenomai. The specs are: Intel Xeon CPU (with 8 cores), Ubuntu 12.10
>     > (Linux-3.5.0-17-generic).
>     > Recently, I installed Ubuntu 12.10 on my machine and configured it for
>     > Xenomai 2.6.2.1 kernel, following the instructions given on this page:
>     >
>     http://www.stanley.gatech.edu/skelly/uncategorized/installing-xenomai-on-ubuntu-12-04/#comment-932
>     >
>     > I was successful with the setup and the grub menu shows the
>     xenomai kernel
>     > installed. But, on booting into the Xenomai option, a desktop is
>     displayed
>     > without any menu/task bar etc. The PC freezes upon booting, with no
>     > internet connection available. Here is the screenshot of the post-boot
>     > screen. I think this might be a problem with configuring the
>     kernel, but
>     > then there are no set rules for configuration for a particular
>     machine. I
>     > will be really grateful if somebody could help me out here.
>     >
>     > - Ankit
>     >
> 
>     Hi Ankit,
> 
>     Want to give some pre-compiled Debian packages a try?  See here:
> 
>     http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernelPackages
> 
>     Also, if your NIC happens to be the r8168, you should compile that
>     driver separately.  There's a Debian package for that one as well,
>     pointed to in the above link.
> 
>             John
> 
> 
> 
> 
> -- 
> Ankit Goila
> U-M ID: 83509056
> Graduate Student (2012-2014)
> M.S.E Mechanical Engineering
> University of Michigan, Ann Arbor
> Contact: 734-747-0829
> 



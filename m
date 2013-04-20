Message-ID: <51725772.7050305@zultron.com>
Date: Sat, 20 Apr 2013 03:53:06 -0500
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <CACWvio7X6LGNpmBk2MQXQZY3gyzHHMHrx3aJXTG7dM08mOM=LQ@mail.gmail.com>
In-Reply-To: <CACWvio7X6LGNpmBk2MQXQZY3gyzHHMHrx3aJXTG7dM08mOM=LQ@mail.gmail.com>
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



On 04/19/2013 11:41 PM, Ankit Goila wrote:
> Hello friends,
> 
> I am working on setting up my machine for real time capability using
> Xenomai. The specs are: Intel Xeon CPU (with 8 cores), Ubuntu 12.10
> (Linux-3.5.0-17-generic).
> Recently, I installed Ubuntu 12.10 on my machine and configured it for
> Xenomai 2.6.2.1 kernel, following the instructions given on this page:
> http://www.stanley.gatech.edu/skelly/uncategorized/installing-xenomai-on-ubuntu-12-04/#comment-932
> 
> I was successful with the setup and the grub menu shows the xenomai kernel
> installed. But, on booting into the Xenomai option, a desktop is displayed
> without any menu/task bar etc. The PC freezes upon booting, with no
> internet connection available. Here is the screenshot of the post-boot
> screen. I think this might be a problem with configuring the kernel, but
> then there are no set rules for configuration for a particular machine. I
> will be really grateful if somebody could help me out here.
> 
> - Ankit
> 

Hi Ankit,

Want to give some pre-compiled Debian packages a try?  See here:

http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernelPackages

Also, if your NIC happens to be the r8168, you should compile that
driver separately.  There's a Debian package for that one as well,
pointed to in the above link.

	John


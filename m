Message-ID: <51760587.6030009@zultron.com>
Date: Mon, 22 Apr 2013 22:52:39 -0500
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <CACWvio7X6LGNpmBk2MQXQZY3gyzHHMHrx3aJXTG7dM08mOM=LQ@mail.gmail.com>
	<51725772.7050305@zultron.com>
	<CACWvio61cz7SR-KWBFjOCbEnof6T6jqfmsKbvV6ubxRJ1E1RhA@mail.gmail.com>
	<517468DB.1050701@zultron.com>
	<CACWvio5Y5QC_FK8LEV2TvzCidbHvZ34eY5MadsdBXToey6c=rA@mail.gmail.com>
In-Reply-To: <CACWvio5Y5QC_FK8LEV2TvzCidbHvZ34eY5MadsdBXToey6c=rA@mail.gmail.com>
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



On 04/22/2013 01:47 PM, Ankit Goila wrote:
>>> On Sat, Apr 20, 2013 at 4:53 AM, John Morris <john@zultron.com
>>> <mailto:john@zultron.com>> wrote:
>>> [...]
>>>     http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernelPackages
> [...]
>
> I tried the Linux CNC pre-compiled packages mentioned in the link above, I
> followed all the instructions as per the article. On reboot, I am able to
> access the desktop from the Grub menu, however, the keyboard and the mouse
> are unresponsive. In a way, I can see the desktop, everything as such, but
> am not able to provide any input. Is this a configuration issue? Or is it
> with the drivers?

Very unlikely either.  The dozen or more systems I'm aware of on which
these packages were tested never exhibited such symptoms.

There are a great many things that happen between the grub menu and the
point where one may 'access the desktop'.  I won't be able to hold your
hand through learning about those.  I suggest you do some basic
troubleshooting on your end, starting with checking system logs and
configuring grub and the kernel not to hide console messages and init
not to start graphics.

When you're at the point where you've captured and analyzed the various
sources of diagnostic output, googled error messages, and are still
stumped, copy the relevant output to a pastebin and ask again here.
That might increase your chances of getting help.

	John


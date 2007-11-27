Message-ID: <e4ef24880711270227x5cb86fb3vd83f72808a6ccc37@domain.hid>
Date: Tue, 27 Nov 2007 02:27:34 -0800
From: "Robert Gubler" <rgubler@domain.hid>
In-Reply-To: <5a4b7020711270211i9c996a8l25ba908cac47ae5b@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11939_22419680.1196159254757"
References: <5a4b7020711270211i9c996a8l25ba908cac47ae5b@domain.hid>
Subject: Re: [Xenomai-help] kernel panic - not syncing: VFS unable to mount
	root fs on unknown-block(0, 0) and mkinitrd
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jie zhang <xenomai.rtai@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_11939_22419680.1196159254757
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Its most likely because Debian is using initrd to initialize your hard drive
controller.  Fedora does this for their Volume Manager, and Ubuntu does it
for their root=UUID=...  I don't know what Debian does, but I suspect its
the same as Ubuntu since they baselined off of Debian to begin with.

I just recently built a kernel successfully with ipipe and xenomai patches
against a kernel that already had the ubuntu patches applied to a 2.6.22.
If you're not familiar with the mkinitrd program, I'd recommend trying to
apply xenomai to the kernel provided by your distribution (debian).  Take a
looking at:

http://www.howtoforge.com/kernel_compilation_ubuntu

and,

http://www.debian.org/doc/FAQ/ch-kernel.en.html.

-Rob


On Nov 27, 2007 2:11 AM, jie zhang <xenomai.rtai@domain.hid> wrote:

> hi ,
> I have a question, I built xenomai-2.4-rc5 and linux-2.6.23 on pc with
> debian distribution and same xenomai and same linux-2.6.23 on laptop
> with ubuntu, I always meet
>
> cannot open root device "hda2" or unknown-block(0,0)
> please append a correct root= boot option; here are the available
> partitions:
> kernel panic - not syncing: VFS unable to mount root fs on
> unknown-block(0,0)
>
> and Gilles Chanteperdrix told me I should mkinitrd, and I  do that,
> then it is booting now, but I want to know why I need this step just
> because in slackware distribution, I don't do that   Thank you
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

------=_Part_11939_22419680.1196159254757
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Its most likely because Debian is using initrd to initialize your hard drive controller.&nbsp; Fedora does this for their Volume Manager, and Ubuntu does it for their root=UUID=...&nbsp; I don&#39;t know what Debian does, but I suspect its the same as Ubuntu since they baselined off of Debian to begin with.
<br><br>I just recently built a kernel successfully with ipipe and xenomai patches against a kernel that already had the ubuntu patches applied to a 2.6.22.&nbsp; If you&#39;re not familiar with the mkinitrd program, I&#39;d recommend trying to apply xenomai to the kernel provided by your distribution (debian).&nbsp; Take a looking at:
<br><br><a href="http://www.howtoforge.com/kernel_compilation_ubuntu">http://www.howtoforge.com/kernel_compilation_ubuntu</a><br><br>and,<br><br><a href="http://www.debian.org/doc/FAQ/ch-kernel.en.html">http://www.debian.org/doc/FAQ/ch-kernel.en.html
</a>.<br><br>-Rob<br><br><br><div class="gmail_quote">On Nov 27, 2007 2:11 AM, jie zhang &lt;<a href="mailto:xenomai.rtai@domain.hid">xenomai.rtai@domain.hid</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
hi ,<br>I have a question, I built xenomai-2.4-rc5 and linux-2.6.23 on pc with<br>debian distribution and same xenomai and same linux-2.6.23 on laptop<br>with ubuntu, I always meet<br><br>cannot open root device &quot;hda2&quot; or unknown-block(0,0)
<br>please append a correct root= boot option; here are the available partitions:<br>kernel panic - not syncing: VFS unable to mount root fs on unknown-block(0,0)<br><br>and Gilles Chanteperdrix told me I should mkinitrd, and I &nbsp;do that,
<br>then it is booting now, but I want to know why I need this step just<br>because in slackware distribution, I don&#39;t do that &nbsp; Thank you<br><br>_______________________________________________<br>Xenomai-help mailing list
<br><a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br><a href="https://mail.gna.org/listinfo/xenomai-help" target="_blank">https://mail.gna.org/listinfo/xenomai-help</a><br></blockquote></div><br>

------=_Part_11939_22419680.1196159254757--


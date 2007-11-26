Message-ID: <e4ef24880711252034v12ca459ct4c09c3cb4cb4c306@domain.hid>
Date: Sun, 25 Nov 2007 20:34:36 -0800
From: "Robert Gubler" <rgubler@domain.hid>
In-Reply-To: <5a4b7020711252019s18f8248eyc251b050214fe55b@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5205_9220506.1196051676868"
References: <5a4b7020711251915v402411d7i5365c099a8668073@domain.hid>
	<e4ef24880711251933kf0afe5au3fa461821c82ef80@domain.hid>
	<5a4b7020711252019s18f8248eyc251b050214fe55b@domain.hid>
Subject: Re: [Xenomai-help] These options are known to cause troubles with
	Xenomai, Kernel panic - not syncing: VFS unable to mount root fs on
	unknown-block(8, 7)
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

------=_Part_5205_9220506.1196051676868
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Boot your kernel that does work. Send back what your /boot/grub/grub.conf
looks like and /etc/fstab might help too.  Are you building this on a i386
machine?  What is your kernel version?

-Rob

PS.  If you don't mind, CC the xenomai@xenomai.org mailing list -- this way
other people can chime in with their suggestions or get help if they're
having similar issues :)




On Nov 25, 2007 8:19 PM, jie zhang <xenomai.rtai@domain.hid> wrote:

> hi robert,
> I am so appreciated that you help me, but now I still have a question,
> when I compile the kernel about xenomai, I always meet the kernel
> panic:
> kernel panic - not syncing: VFS unable to mount root fs on
> unknown-block(0,0)
> Kernel panic - not syncing: VFS unable to mount root fs on
>  unknown-block(8,7)
>
> frankly, I don't know much about this kernel panic, Is this problem
> cased by I ingored?
> this is my lspci
> 00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family)
> SATA IDE Controller (rev 01)
>
> Device Drivers
>   [*] Block devices  --->
>        <M>   Promise SATA SX8 support
>
> I mean is it the right option for my IDE interface? are they have
> direct relation with the kernel panic?
>
>
>
>
>
> > > And finally, when I reboot the kernel , there is a kernel panic seems
> > > as Kernel panic - not syncing: VFS unable to mount root fs on
> > > unknown-block(8,7)
> >
> > It looks as though the kernel you built doesn't know how to find or read
> the
> > root device.  Check your grub.conf to see if it looks similar to your
> kernel
> > that does work.  I've had this happen with Fedora.  I know for example
> > Fedora uses some kind of Volume Manager that the vanilla kernel doesn't
> know
> > how to use.  I imagine its included in one of the Fedora patches, but I
> had
> > trouble getting their stuff working (inexperience on my part).  Anyway,
> not
> > that this is the case for you, but it might be a good idea to see if all
> > your Distribution patches are being applied to the kernel you are trying
> to
> > build with Xenomai support.
> >
> > -Rob
> >
>

------=_Part_5205_9220506.1196051676868
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Boot your kernel that does work. Send back what your /boot/grub/grub.conf looks like and /etc/fstab might help too.&nbsp; Are you building this on a i386 machine?&nbsp; What is your kernel version?<br><br>-Rob<br><br>PS.&nbsp; If you don&#39;t mind, CC the 
<a href="mailto:xenomai@xenomai.org">xenomai@xenomai.org</a> mailing list -- this way other people can chime in with their suggestions or get help if they&#39;re having similar issues :)<br><br><br><br><br><div class="gmail_quote">
On Nov 25, 2007 8:19 PM, jie zhang &lt;<a href="mailto:xenomai.rtai@domain.hid">xenomai.rtai@domain.hid</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
hi robert,<br>I am so appreciated that you help me, but now I still have a question,<br>when I compile the kernel about xenomai, I always meet the kernel<br>panic:<br>kernel panic - not syncing: VFS unable to mount root fs on unknown-block(0,0)
<br><div class="Ih2E3d">Kernel panic - not syncing: VFS unable to mount root fs on &nbsp;unknown-block(8,7)<br><br></div>frankly, I don&#39;t know much about this kernel panic, Is this problem<br>cased by I ingored?<br>this is my lspci
<br><div class="Ih2E3d">00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family)<br>SATA IDE Controller (rev 01)<br><br></div>Device Drivers<br> &nbsp; [*] Block devices &nbsp;---&gt;<br> &nbsp; &nbsp; &nbsp; &nbsp;&lt;M&gt; &nbsp; Promise SATA SX8 support
<br><br>I mean is it the right option for my IDE interface? are they have<br>direct relation with the kernel panic?<br><div><div></div><div class="Wj3C7c"><br><br><br><br><br>&gt; &gt; And finally, when I reboot the kernel , there is a kernel panic seems
<br>&gt; &gt; as Kernel panic - not syncing: VFS unable to mount root fs on<br>&gt; &gt; unknown-block(8,7)<br>&gt;<br>&gt; It looks as though the kernel you built doesn&#39;t know how to find or read the<br>&gt; root device. &nbsp;Check your 
grub.conf to see if it looks similar to your kernel<br>&gt; that does work. &nbsp;I&#39;ve had this happen with Fedora. &nbsp;I know for example<br>&gt; Fedora uses some kind of Volume Manager that the vanilla kernel doesn&#39;t know
<br>&gt; how to use. &nbsp;I imagine its included in one of the Fedora patches, but I had<br>&gt; trouble getting their stuff working (inexperience on my part). &nbsp;Anyway, not<br>&gt; that this is the case for you, but it might be a good idea to see if all
<br>&gt; your Distribution patches are being applied to the kernel you are trying to<br>&gt; build with Xenomai support.<br>&gt;<br>&gt; -Rob<br>&gt;<br></div></div></blockquote></div><br>

------=_Part_5205_9220506.1196051676868--


Message-ID: <e4ef24880711251933kf0afe5au3fa461821c82ef80@domain.hid>
Date: Sun, 25 Nov 2007 19:33:14 -0800
From: "Robert Gubler" <rgubler@domain.hid>
In-Reply-To: <5a4b7020711251915v402411d7i5365c099a8668073@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5004_25763086.1196047994273"
References: <5a4b7020711251915v402411d7i5365c099a8668073@domain.hid>
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

------=_Part_5004_25763086.1196047994273
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Nov 25, 2007 7:15 PM, jie zhang <xenomai.rtai@domain.hid> wrote:

> Real-time sub-system
> WARNING! You enabled APM, CPU Frequency scaling or ACPI 'processor'
>            --- option. These options are known to cause troubles with
> Xenomai.
>
>
> what does that mean? I don't know what happened?
>

The power management stuff (APM) decreases real-time performance so its
recommended that you turn it off in your kernel configuration.  You can find
a short list of all the kernel options that should be disabled, along with a
description as to why it should be disabled, here:
http://www.xenomai.org/index.php/FAQs.  Under Installation and Setup.



>
> And finally, when I reboot the kernel , there is a kernel panic seems
> as Kernel panic - not syncing: VFS unable to mount root fs on
> unknown-block(8,7)


It looks as though the kernel you built doesn't know how to find or read the
root device.  Check your grub.conf to see if it looks similar to your kernel
that does work.  I've had this happen with Fedora.  I know for example
Fedora uses some kind of Volume Manager that the vanilla kernel doesn't know
how to use.  I imagine its included in one of the Fedora patches, but I had
trouble getting their stuff working (inexperience on my part).  Anyway, not
that this is the case for you, but it might be a good idea to see if all
your Distribution patches are being applied to the kernel you are trying to
build with Xenomai support.

-Rob

------=_Part_5004_25763086.1196047994273
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div class="gmail_quote">On Nov 25, 2007 7:15 PM, jie zhang &lt;<a href="mailto:xenomai.rtai@domain.hid">xenomai.rtai@domain.hid</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Real-time sub-system<br>WARNING! You enabled APM, CPU Frequency scaling or ACPI &#39;processor&#39;<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;--- option. These options are known to cause troubles with<br>Xenomai.<br><br><br>what does that mean? I don&#39;t know what happened?
<br></blockquote><div><br>The power management stuff (APM) decreases real-time performance so its recommended that you turn it off in your kernel configuration.&nbsp; You can find a short list of all the kernel options that should be disabled, along with a description as to why it should be disabled, here: 
<a href="http://www.xenomai.org/index.php/FAQs">http://www.xenomai.org/index.php/FAQs</a>.&nbsp; Under Installation and Setup.<br><br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>And finally, when I reboot the kernel , there is a kernel panic seems<br>as Kernel panic - not syncing: VFS unable to mount root fs on<br>unknown-block(8,7)</blockquote><div><br>It looks as though the kernel you built doesn&#39;t know how to find or read the root device.&nbsp; Check your 
grub.conf to see if it looks similar to your kernel that does work.&nbsp; I&#39;ve had this happen with Fedora.&nbsp; I know for example Fedora uses some kind of Volume Manager that the vanilla kernel doesn&#39;t know how to use.&nbsp; I imagine its included in one of the Fedora patches, but I had trouble getting their stuff working (inexperience on my part).&nbsp; Anyway, not that this is the case for you, but it might be a good idea to see if all your Distribution patches are being applied to the kernel you are trying to build with Xenomai support.
<br><br>-Rob<br></div></div>

------=_Part_5004_25763086.1196047994273--


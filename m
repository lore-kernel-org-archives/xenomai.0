Message-ID: <4546494d0607102125w2817ccd1j746651214cac3a6d@domain.hid>
Date: Tue, 11 Jul 2006 12:25:00 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
In-Reply-To: <44B2216A.1060904@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_104937_21895595.1152591900655"
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>
	<44B1FDBD.4060600@domain.hid>
	<4546494d0607100148s1f5476e3tb3f58d7ae48d4a72@domain.hid>
	<44B218C5.9000804@domain.hid>
	<4546494d0607100231x469aa596s2513e5b36cad8550@domain.hid>
	<44B2216A.1060904@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

------=_Part_104937_21895595.1152591900655
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jan,

Sometimes there is situation to  protect a  Non-real time task in kernel
space NOT to be interrupted by Xenomai task.
Is disabling HW interrupt the only way? Can I stall Xenomai Domain from
handling interrupt while let the Linux domain
handle interrupt normally?

Thanks,

-Yi


On 7/10/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Li Yi (Adam) wrote:
> > I searched the web and find these RTDM sample drivers (Thanks for the
> > contributors):
> >
> > In Xenomai src tree: ksrc/drivers/16550A/16550A.c
>
> Also check the drivers/testing in recent Xenomai.
>
> > http://www.captain.at/xenomai-real-time-driver-example.php
> > http://www.rts.uni-hannover.de/rtnet/lxr/source/examples/xenomai/
> > http://www.captain.at/xenomai-serial-port-example.php
>
> The last two are usage examples, not drivers. But RTnet is indeed
> another, more complex example, see these parts:
>
> http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/packet/af_packet.c
> http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/ipv4
>
> http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/rtmac/tdma/tdma_dev.c
>
> >
> > Just wondering are there more samples?
>
> http://svn.berlios.de/viewcvs/rack/trunk/rack/main/tims/driver
> http://www.rts.uni-hannover.de/rtaddon
> http://developer.berlios.de/projects/usb4rt
> http://developer.berlios.de/projects/rtfirewire (only as API user, not
>     as RTDM device provider)
>
> And a full CAN stack is on the way, may show up on the list this week.
> Hope I'm not forgetting anything right now.
>
> Jan
>
>
>
>

------=_Part_104937_21895595.1152591900655
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jan,<font color="#000000"><br><br>Sometimes there is situation to&nbsp; protect a&nbsp; Non-real time task in kernel space NOT to be interrupted by Xenomai task.<br>Is disabling HW interrupt the only way? Can I stall Xenomai Domain from handling interrupt while let the Linux domain
<br>handle interrupt normally?<br><br>Thanks,<br><br>-Yi<br><br><br></font><div><span class="gmail_quote">On 7/10/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>
&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Li Yi (Adam) wrote:<br>&gt; I searched the web and find these RTDM sample drivers (Thanks for the
<br>&gt; contributors):<br>&gt;<br>&gt; In Xenomai src tree: ksrc/drivers/16550A/16550A.c<br><br>Also check the drivers/testing in recent Xenomai.<br><br>&gt; <a href="http://www.captain.at/xenomai-real-time-driver-example.php">
http://www.captain.at/xenomai-real-time-driver-example.php</a><br>&gt; <a href="http://www.rts.uni-hannover.de/rtnet/lxr/source/examples/xenomai/">http://www.rts.uni-hannover.de/rtnet/lxr/source/examples/xenomai/</a><br>&gt; 
<a href="http://www.captain.at/xenomai-serial-port-example.php">http://www.captain.at/xenomai-serial-port-example.php</a><br><br>The last two are usage examples, not drivers. But RTnet is indeed<br>another, more complex example, see these parts:
<br><br><a href="http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/packet/af_packet.c">http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/packet/af_packet.c</a><br><a href="http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/ipv4">
http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/ipv4</a><br><a href="http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/rtmac/tdma/tdma_dev.c">http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/rtmac/tdma/tdma_dev.c
</a><br><br>&gt;<br>&gt; Just wondering are there more samples?<br><br><a href="http://svn.berlios.de/viewcvs/rack/trunk/rack/main/tims/driver">http://svn.berlios.de/viewcvs/rack/trunk/rack/main/tims/driver</a><br><a href="http://www.rts.uni-hannover.de/rtaddon">
http://www.rts.uni-hannover.de/rtaddon</a><br><a href="http://developer.berlios.de/projects/usb4rt">http://developer.berlios.de/projects/usb4rt</a><br><a href="http://developer.berlios.de/projects/rtfirewire">http://developer.berlios.de/projects/rtfirewire
</a> (only as API user, not<br>&nbsp;&nbsp;&nbsp;&nbsp;as RTDM device provider)<br><br>And a full CAN stack is on the way, may show up on the list this week.<br>Hope I'm not forgetting anything right now.<br><br>Jan<br><br><br><br></blockquote>
</div><br>

------=_Part_104937_21895595.1152591900655--


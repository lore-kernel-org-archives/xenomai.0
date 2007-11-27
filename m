Message-ID: <e4ef24880711270901w3c1b0lde2fd40dd5bffd2f@domain.hid>
Date: Tue, 27 Nov 2007 09:01:10 -0800
From: "Rob Gubler" <rgubler@domain.hid>
In-Reply-To: <2ff1a98a0711270604n4abf25bdg6237ad5971c71959@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14370_22863402.1196182870912"
References: <5a4b7020711270211i9c996a8l25ba908cac47ae5b@domain.hid>
	<2ff1a98a0711270604n4abf25bdg6237ad5971c71959@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_14370_22863402.1196182870912
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Oh, thats good to know.  I didn't realize that.  I thought some
configurations, like with certain SCSI controllers *required* initrd to do
some pre-configuration before loading the root device.  Thanks for the info.

-Rob

On Nov 27, 2007 6:04 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Nov 27, 2007 11:11 AM, jie zhang <xenomai.rtai@domain.hid> wrote:
> > hi ,
> > I have a question, I built xenomai-2.4-rc5 and linux-2.6.23 on pc with
> > debian distribution and same xenomai and same linux-2.6.23 on laptop
> > with ubuntu, I always meet
> >
> > cannot open root device "hda2" or unknown-block(0,0)
> > please append a correct root= boot option; here are the available
> partitions:
> > kernel panic - not syncing: VFS unable to mount root fs on
> unknown-block(0,0)
> >
> > and Gilles Chanteperdrix told me I should mkinitrd, and I  do that,
> > then it is booting now, but I want to know why I need this step just
> > because in slackware distribution, I don't do that   Thank you
>
> As I said in previous mails, using an initrd is not mandatory.
> Distributions use an initrd because it allows to build a kernel that
> will fit any machine: the initrd scripts load the needed modules
> (namely the root device disk controller and the root filesystem), then
> continue the boot process.
>
> But if you are building a kernel for a fixed configuration, you do not
> need the initrd. All you have to do is to build in kernel (that is
> select 'y' instead of 'm' in the kernel configuration) the root device
> disk controller and the root filesystem. Then you can get rid of the
> initrd.
>
> --
>                                               Gilles Chanteperdrix
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

------=_Part_14370_22863402.1196182870912
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Oh, thats good to know.&nbsp; I didn&#39;t realize that.&nbsp; I thought some configurations, like with certain SCSI controllers *required* initrd to do some pre-configuration before loading the root device.&nbsp; Thanks for the info.<br>
<br>-Rob<br><br><div class="gmail_quote">On Nov 27, 2007 6:04 AM, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Nov 27, 2007 11:11 AM, jie zhang &lt;<a href="mailto:xenomai.rtai@domain.hid">xenomai.rtai@domain.hid</a>&gt; wrote:<br>&gt; hi ,<br>&gt; I have a question, I built xenomai-2.4-rc5 and linux-2.6.23 on pc with
<br>&gt; debian distribution and same xenomai and same linux-2.6.23 on laptop<br>&gt; with ubuntu, I always meet<br>&gt;<br>&gt; cannot open root device &quot;hda2&quot; or unknown-block(0,0)<br>&gt; please append a correct root= boot option; here are the available partitions:
<br>&gt; kernel panic - not syncing: VFS unable to mount root fs on unknown-block(0,0)<br>&gt;<br>&gt; and Gilles Chanteperdrix told me I should mkinitrd, and I &nbsp;do that,<br>&gt; then it is booting now, but I want to know why I need this step just
<br>&gt; because in slackware distribution, I don&#39;t do that &nbsp; Thank you<br><br></div>As I said in previous mails, using an initrd is not mandatory.<br>Distributions use an initrd because it allows to build a kernel that
<br>will fit any machine: the initrd scripts load the needed modules<br>(namely the root device disk controller and the root filesystem), then<br>continue the boot process.<br><br>But if you are building a kernel for a fixed configuration, you do not
<br>need the initrd. All you have to do is to build in kernel (that is<br>select &#39;y&#39; instead of &#39;m&#39; in the kernel configuration) the root device<br>disk controller and the root filesystem. Then you can get rid of the
<br>initrd.<br><br>--<br><font color="#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gilles Chanteperdrix<br></font><div><div></div><div class="Wj3C7c"><br>_______________________________________________<br>Xenomai-help mailing list
<br><a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br><a href="https://mail.gna.org/listinfo/xenomai-help" target="_blank">https://mail.gna.org/listinfo/xenomai-help</a><br></div></div></blockquote></div><br>

------=_Part_14370_22863402.1196182870912--


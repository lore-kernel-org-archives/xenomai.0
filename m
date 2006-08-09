Message-ID: <b647ffbd0608090842w6293eb37o94f4deaeb8a7310b@domain.hid>
Date: Wed, 9 Aug 2006 17:42:50 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Re: [Xenomai-help] -110 error on rt_task_send...
	bug?
In-Reply-To: <200608091709.57319.schwab@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_19440_8574421.1155138170028"
References: <44D7EDCF.9010409@domain.hid>
	<b647ffbd0608090235o2868571ajbe74c0b09dd27282@domain.hid>
	<b647ffbd0608090442q638115acw788da87969792cfb@domain.hid>
	<200608091709.57319.schwab@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Ulrich Schwab <schwab@domain.hid>
Cc: xenomai@xenomai.org, andrewg@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

------=_Part_19440_8574421.1155138170028
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> > So could anyone test this patch and let me know if it works?
> >
> > Note : I haven't compiled it even as I don't have a proper environment.
> But
> > the changes are pretty simple so it should be ok.
> I just did run the test program supplied by Vincent after applying Your
> patch
> (against 2.2.0)
> It did work !
>


That's good. Thanks for your assistance.

So synch. message passing interface (IOW, rt_task_send/receive/reply) is
mgmglmgmm... slightly broken at the moment for all versions.

The ones who need it may use this patch so far. I'll think a bit more on it
in the mean time but I tend to think that "Fixed Ownership" (expressed by
XNSYNCH_FOWNER) should really be a property of the synch. object indeed (as
in the current patch).



> Only one small typo was in the patch, it is fixed in the attached patch
> version.

Ok, now I need to run diff -u old-patch new-patch to find out this typo :)


-- 
Best regards,
Dmitry Adamushko

------=_Part_19440_8574421.1155138170028
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; So could anyone test this patch and let me know if it works?<br>&gt;<br>&gt; Note : I haven't compiled it even as I don't have a proper environment. But
<br>&gt; the changes are pretty simple so it should be ok.<br>I just did run the test program supplied by Vincent after applying Your patch<br>(against 2.2.0)<br>It did work !<br></blockquote><div><br>
<br>
That's good. Thanks for your assistance.<br>
<br>
So synch. message passing interface (IOW, rt_task_send/receive/reply)
is mgmglmgmm... slightly broken at the moment for all versions.<br>
<br>
The ones who need it may use this patch so far. I'll think a bit more
on it in the mean time but I tend to think that &quot;Fixed Ownership&quot;
(expressed by XNSYNCH_FOWNER) should really be a property of the synch.
object indeed (as in the current patch).<br>
<br>
<br>
<br>
&gt; Only one small typo was in the patch, it is fixed in the attached patch<br>
&gt; version.<br>
<br>
Ok, now I need to run diff -u old-patch new-patch to find out this typo :)<br>

<br>
&nbsp;</div></div>-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>

------=_Part_19440_8574421.1155138170028--


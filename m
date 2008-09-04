Message-ID: <67b6b3430809041446m2e716c04p7032c7ed606c354c@domain.hid>
Date: Thu, 4 Sep 2008 14:46:56 -0700
From: "Mark Saiia" <mark.saiia@domain.hid>
In-Reply-To: <200809041804.16435@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_39652_28527929.1220564816922"
References: <200808251743.26012@domain.hid> <48B2DCCC.4010303@domain.hid>
	<200809041804.16435@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_delete returns -EBUSY
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_39652_28527929.1220564816922
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

This is my first post, but I have been following the lists for a while.  I
just updated to xenomai 2.4.5 and noticed the same issue occurring in a
clean-up routine.

Thanks,
Mark

On Thu, Sep 4, 2008 at 9:04 AM, Petr Cervenka <grugh@domain.hid> wrote:

> rpm@xenomai.org wrote:
> >Petr Cervenka wrote:
> >> Hello,
> >> I tried xenomai 2.4.5, hoping that my problems with real-time queue
> will disappear. But there is another (perhaps very trivial) error.
> >> Function call rt_queue_delete always returns -EBUSY (at least for me).
> You don't have to bind it from another task or use it at all.
> >> I hope that I have used it in the right way.
> >
> >Classic chicken-and-egg issue. Ok, will fix.
> >
> Hello,
> I tried to have a look at this issue, but i it perhaps beyond my skills and
> xenomai knowledge.
> I have found in the sources, that the EBUSY is returned by the
> xnheap_destroy_mapped (probably) because the heap->archdep.numaps still
> includes actual task/process/whatever.
> So there should be some test if the current task isn't (accidentally ;-))
> the only referring task. But maybe the fix will be more complex ;-(
> Could you please fix it. It's strange that others don't have this problem
> with the new version...
> TIA
> Petr
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

------=_Part_39652_28527929.1220564816922
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hello,<br><br>This is my first post, but I have been following the lists for a while.&nbsp; I just updated to xenomai 2.4.5 and noticed the same issue occurring in a clean-up routine.&nbsp; <br><br>Thanks,<br>Mark<br>
<br><div class="gmail_quote">On Thu, Sep 4, 2008 at 9:04 AM, Petr Cervenka <span dir="ltr">&lt;<a href="mailto:grugh@domain.hid">grugh@domain.hid</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d"><a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a> wrote:<br>
&gt;Petr Cervenka wrote:<br>
&gt;&gt; Hello,<br>
&gt;&gt; I tried xenomai 2.4.5, hoping that my problems with real-time queue<br>
will disappear. But there is another (perhaps very trivial) error.<br>
&gt;&gt; Function call rt_queue_delete always returns -EBUSY (at least for me).<br>
You don&#39;t have to bind it from another task or use it at all.<br>
&gt;&gt; I hope that I have used it in the right way.<br>
&gt;<br>
&gt;Classic chicken-and-egg issue. Ok, will fix.<br>
&gt;<br>
</div>Hello,<br>
I tried to have a look at this issue, but i it perhaps beyond my skills and xenomai knowledge.<br>
I have found in the sources, that the EBUSY is returned by the xnheap_destroy_mapped (probably) because the heap-&gt;archdep.numaps still includes actual task/process/whatever.<br>
So there should be some test if the current task isn&#39;t (accidentally ;-)) the only referring task. But maybe the fix will be more complex ;-(<br>
Could you please fix it. It&#39;s strange that others don&#39;t have this problem with the new version...<br>
TIA<br>
<font color="#888888">Petr<br>
</font><div><div></div><div class="Wj3C7c"><br>
<br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href="https://mail.gna.org/listinfo/xenomai-help" target="_blank">https://mail.gna.org/listinfo/xenomai-help</a><br>
</div></div></blockquote></div><br></div>

------=_Part_39652_28527929.1220564816922--


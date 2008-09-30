Message-ID: <2b490f270809301326jd381307md432bd4cdfe36d3b@domain.hid>
Date: Tue, 30 Sep 2008 22:26:40 +0200
From: "Dehann Fourie" <dehann.fourie@domain.hid>
In-Reply-To: <48DD05F2.4040203@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_68034_4668195.1222806400198"
References: <2b490f270809260610w4573446x507ef059d4b3ca0b@domain.hid>
	<48DD05F2.4040203@domain.hid>
Subject: Re: [Xenomai-help] Segmentation Fault
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

------=_Part_68034_4668195.1222806400198
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Sorry for the lack of information, I'm still bit of a new guy. I have found
the following (I do use a mlockall(current | future)):

When i declare larger arrays in the real-time task I get the segmentation
fault. This is when I declare as follows
double arr[10000]; //some KB sized value

When I use malloc I don't get the problem. My question now is where does the
first one declare the memory. I am assuming that the malloc declares strait
into the RAM, becuase there I am safe to declare a couple of MB?

Thanks
Dehann

On Fri, Sep 26, 2008 at 5:55 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Dehann Fourie wrote:
> > Hi,
> >
> > I'm having trouble with a segmentation fault in my real-time application.
> > The problem seems to occur when I use large amounts of memory. The
> > application works fine when I don't try to populate the large arrays.
> >
> > I have tried changing parameters in the real time create call, but this
> > didn't work. The error message is:
> >
> > Xenomai: Switching nav to secondary mode after exception #14 from
> user-space
> > at 0x804ad13 (pid 1938)
> > nav [1938]; segfault at 26756e50 eip 0804ad13 esp b762ac28 error 6
> > Segmentation fault
> >
> > This is from text mode.
>
> You do not give us much information about your configuration. However,
> have you tried gdb ? In case of segmentation faults, it should stop you
> right at the point where the segmentation occurs.
>
> --
>                                             Gilles.
>

------=_Part_68034_4668195.1222806400198
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi,<br><br>Sorry for the lack of information, I&#39;m still bit of a new guy. I have found the following (I do use a mlockall(current | future)):<br><br>When i declare larger arrays in the real-time task I get the segmentation fault. This is when I declare as follows<br>
double arr[10000]; //some KB sized value<br><br>When I use malloc I don&#39;t get the problem. My question now is where does the first one declare the memory. I am assuming that the malloc declares strait into the RAM, becuase there I am safe to declare a couple of MB?<br>
<br>Thanks<br>Dehann<br><br><div class="gmail_quote">On Fri, Sep 26, 2008 at 5:55 PM, Gilles Chanteperdrix <span dir="ltr">&lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><div class="Wj3C7c">Dehann Fourie wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I&#39;m having trouble with a segmentation fault in my real-time application.<br>
&gt; The problem seems to occur when I use large amounts of memory. The<br>
&gt; application works fine when I don&#39;t try to populate the large arrays.<br>
&gt;<br>
&gt; I have tried changing parameters in the real time create call, but this<br>
&gt; didn&#39;t work. The error message is:<br>
&gt;<br>
&gt; Xenomai: Switching nav to secondary mode after exception #14 from user-space<br>
&gt; at 0x804ad13 (pid 1938)<br>
&gt; nav [1938]; segfault at 26756e50 eip 0804ad13 esp b762ac28 error 6<br>
&gt; Segmentation fault<br>
&gt;<br>
&gt; This is from text mode.<br>
<br>
</div></div>You do not give us much information about your configuration. However,<br>
have you tried gdb ? In case of segmentation faults, it should stop you<br>
right at the point where the segmentation occurs.<br>
<br>
--<br>
<font color="#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>
</font></blockquote></div><br></div>

------=_Part_68034_4668195.1222806400198--


Message-ID: <f48df4840606201226m4d6979eevcd4e730198b42875@domain.hid>
Date: Tue, 20 Jun 2006 21:26:28 +0200
From: "Bruno Rouchouse" <brouchouse@domain.hid>
Subject: Re: [Xenomai-help] Nucleus Documentation
In-Reply-To: <d87da8330606201027m19044b68lfa29d352297fa77a@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_134016_12844544.1150831588906"
References: <d87da8330606201027m19044b68lfa29d352297fa77a@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Pramode C E <pramode@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_134016_12844544.1150831588906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi !

On 6/20/06, Pramode C E <pramode@domain.hid> wrote:
>
> Hello,
>
> Is there some documentation (other than the API reference) which describes
> the Xenomai nucleus? I am trying to learn how to write an RTOS skin using
> the Nucleus and am finding the going a bit tough .... any help will be
> greatly appreciated.
>

Check this link (
http://wiki.rtai.dk/cgi-bin/gratiswiki.pl?How_To_Implement_A_New_Skin) which
may give you some information about how to start writing a new skin.

"Writing a Xenomai skin" is another piece of doc missing and the topics to
address are varied such as implementing the kernel part, writing the user
space layer and also how to use the simulator in order to develop and debug
the model.

A good exercise is maybe to start from a public specification (e.g. VRTX or
uiTRON) and read the source code of the model to understand how it has been
implemented.

For sure people who have already written complete skins will be able to give
you other advices ;)

Regards,

--
Bruno

Thanks and Regards,
> Pramode C.E
> -------------------------
>
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>
>

------=_Part_134016_12844544.1150831588906
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi !<br><br><div><span class="gmail_quote">On 6/20/06, <b class="gmail_sendername">Pramode C E</b> &lt;<a href="mailto:pramode@domain.hid">pramode@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>Hello,<br>
<br>
Is there some documentation (other than the API reference) which
describes the Xenomai nucleus? I am trying to learn how to write an
RTOS skin using the Nucleus and am finding the going a bit tough ....
any help will be greatly appreciated.</div></blockquote><div><br>Check this link (<a href="http://wiki.rtai.dk/cgi-bin/gratiswiki.pl?How_To_Implement_A_New_Skin">http://wiki.rtai.dk/cgi-bin/gratiswiki.pl?How_To_Implement_A_New_Skin
</a>) which may give you some information about how to start writing a new skin.<br><br>&quot;Writing a Xenomai skin&quot; is another piece of doc missing and the topics to address are varied such as implementing the kernel part, writing the user space layer and also how to use the simulator in order to develop and debug the model.
<br><br>A good exercise is maybe to start from a public specification (e.g. VRTX or uiTRON) and read the source code of the model to understand how it has been implemented.<br><br>For sure people who have already written complete skins will be able to give you other advices ;)
<br><br>Regards,<br><br>--<br>Bruno<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>
Thanks and Regards,<br></div><div><span class="sg">
Pramode C.E<br>
-------------------------<br clear="all"><br><br><br>

</span></div><br>_______________________________________________<br>Xenomai-help mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://mail.gna.org/listinfo/xenomai-help" target="_blank">
https://mail.gna.org/listinfo/xenomai-help</a><br><br><br></blockquote></div><br>

------=_Part_134016_12844544.1150831588906--


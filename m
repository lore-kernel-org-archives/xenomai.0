Message-ID: <f48df4840806121256y9724841s16436a846b1e0425@domain.hid>
Date: Thu, 12 Jun 2008 21:56:07 +0200
From: "Bruno Rouchouse" <brouchouse@domain.hid>
In-Reply-To: <2f7417810806120147u8b30070h8d7f5006d8504d4f@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_30961_15320296.1213300567919"
References: <2f7417810806120147u8b30070h8d7f5006d8504d4f@domain.hid>
Subject: Re: [Xenomai-help] Problems install xemosim .............
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: quinty <webquinty2@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_30961_15320296.1213300567919
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/6/12 quinty <webquinty2@domain.hid>:

> Hello,
>
> I use xenomai 2.4.2 with powerpc (MPC5200) and xenosim 2.4.2.
> I executed ./configure without problems, make and make install.
>
> But if I press a icon or selected a option from menu, always, I have the
> same problem:
> "...Error: Unknown option '-image'..."
>
> By other hand, I have some doubts about this program, xenosim. I try to
> look for information but
> I can not find a manual or tutorial of this program.


Please, check the svn repository where you can  find information on Xenomai
Virtual Machine. The virtual machine is an event-driven host-based
simulator.
http://svn.gna.org/viewcvs/xenomai/trunk/sim/doc/mvm-manual.txt?rev=153&view=markup


> 1.- This program is to test or debug xenomai task.


Yes but in a more general way, it is used to develop and test your whole
application code based on skins. As far as I know, Xenomai core developers
use it also to implement and test skins.

>
> 2.- What options have this program to debug a program??, for example,
> breakpoints, trace and watch variables.


As far as I remember, it has the same functionalities than a debugger and is
IMO even more powerful since it helps to understand precisely the behavior
of an application. Again the mvm is event-driven.
It does not require cross toolchain since the execution occurs on your host
platform. The consequence is that you can't use target dependent code. Note
also that this tool is not suitable for dimensioning your application
(performances as well as code sizing). You will have to use classical
target-based tools for that.

>
> 3.- Can I use it for test my xenomai task in a PowerPc (MPC5200)???


As stated above, if you want to test only application code based on the
public API of a skin: yes. Once you're application has been well tested, try
it on the real target. The mvm is very useful when you want to start
developing application code without having the hardware platform.

Hope it helps and that my understanding of the mvm is still accurate.
Otherwise, Xenomai developers will correct me!

Regards,

--Bruno


>
> Best regards.
> John Martin.
> Automation and Reasearch.
> Spain.
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>

------=_Part_30961_15320296.1213300567919
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">2008/6/12 quinty &lt;<a href="mailto:webquinty2@domain.hid" target="_blank">webquinty2@domain.hid</a>&gt;:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">


Hello,<br><br>I use xenomai 2.4.2 with powerpc (MPC5200) and xenosim <a href="http://2.4.2." target="_blank">2.4.2.</a><br>I executed ./configure without problems, make and make install.<br><br>But if I press a icon or selected a option from menu, always, I have the same problem:<br>



&quot;...Error: Unknown option &#39;-image&#39;...&quot;<br><br>By other hand, I have some doubts about this program, xenosim. I try to look for information but<br>I can not find a manual or tutorial of this program.</blockquote>


<div><br>Please, check the svn repository where you can&nbsp; find information on  Xenomai Virtual Machine. The virtual machine is an event-driven host-based simulator.<br><a href="http://svn.gna.org/viewcvs/xenomai/trunk/sim/doc/mvm-manual.txt?rev=153&amp;view=markup" target="_blank">http://svn.gna.org/viewcvs/xenomai/trunk/sim/doc/mvm-manual.txt?rev=153&amp;view=markup</a><br>


<br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
1.- This program is to test or debug xenomai task.</blockquote><div><br>Yes but in a more general way, it is used to develop and test your whole application code based on skins. As far as I know, Xenomai core developers use it also to implement and test skins.<br>

</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>2.- What options have this program to debug a program??, for example, breakpoints, trace and watch variables.</blockquote><div><br>As far as I remember, it has the same functionalities than a debugger and is IMO even more powerful since it helps to understand precisely the behavior of an application. Again the mvm is event-driven.<br>


It does not require cross toolchain since the execution occurs on your host platform. The consequence is that you can&#39;t use target dependent code. Note also that this tool is not suitable for dimensioning your application (performances as well as code sizing). You will have to use classical target-based tools for that. <br>

</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>3.- Can I use it for test my xenomai task in a PowerPc (MPC5200)???</blockquote><div><br>As stated above, if you want to test only application code based on the public API of a skin: yes. Once you&#39;re application has been well tested, try it on the real target. The mvm is very useful when you want to start developing application code without having the hardware platform.<br>


<br>Hope it helps and that my understanding of the mvm is still accurate. Otherwise, Xenomai developers will correct me!<br><br>Regards,<br><br>--Bruno<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">


<br>
<br>Best regards.<br>John Martin.<br>Automation and Reasearch.<br>Spain.<br><br><br>
<br>_______________________________________________<br>
Xenomai-help mailing list<br>
<a href="mailto:Xenomai-help@domain.hid" target="_blank">Xenomai-help@domain.hid</a><br>
<a href="https://mail.gna.org/listinfo/xenomai-help" target="_blank">https://mail.gna.org/listinfo/xenomai-help</a><br>
<br></blockquote></div><br>

------=_Part_30961_15320296.1213300567919--


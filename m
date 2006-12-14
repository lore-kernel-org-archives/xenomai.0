Date: Thu, 14 Dec 2006 08:27:06 -0800 (PST)
From: mani bhatti <imranbashirbhatti@domain.hid>
Subject: Re: [Xenomai-help] user space interrupt
In-Reply-To: <457997E5.7010206@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-473962387-1166113626=:81959"
Content-Transfer-Encoding: 8bit
Message-ID: <688800.81959.qm@domain.hid>
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

--0-473962387-1166113626=:81959
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Gilles and all
 Thanks for ur help.The error i get after replacing printf with 
 perror("iopl") is "iopl: Operation not permitted".
 Please suggest me some solution for this.Thanks again.

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote: mani bhatti wrote:
> Hi all
> i am trying to access parallel port form a user space task.i have copied
> code from an example which runs parallel port in interrupt mode but the
> problem is that when i run program i get following message
> 
> "iopl err"
> 
> due to this piece of  code
>        
> // ask for permission to access the parallel port from user-space
>         if (iopl(3)) {
>                 printf("iopl err\n");
>                 exit(1);
>         }
> 
> 
> i am working with interrupts for the first time and have no idea why
> this is happening .i am attaching the code also.Thanks all for the great
> help.

What is the error message if you replace printf("iopl err\n") with
perror("iopl") ?

-- 
                                                 Gilles Chanteperdrix


 
---------------------------------
Need a quick answer? Get one in minutes from people who know. Ask your question on Yahoo! Answers.
--0-473962387-1166113626=:81959
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Gilles and all<br> Thanks for ur help.The error i get after replacing printf with <br> perror("iopl") is "iopl: Operation not permitted".<br> Please suggest me some solution for this.Thanks again.<br><br><b><i>Gilles Chanteperdrix &lt;gilles.chanteperdrix@xenomai.org&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> mani bhatti wrote:<br>&gt; Hi all<br>&gt; i am trying to access parallel port form a user space task.i have copied<br>&gt; code from an example which runs parallel port in interrupt mode but the<br>&gt; problem is that when i run program i get following message<br>&gt; <br>&gt; "iopl err"<br>&gt; <br>&gt; due to this piece of  code<br>&gt;        <br>&gt; // ask for permission to access the parallel port from user-space<br>&gt;         if (iopl(3)) {<br>&gt;                 printf("iopl err\n");<br>&gt;                 exit(1);<br>&gt;         }<br>&gt; <br>&gt; <br>&gt; i am
 working with interrupts for the first time and have no idea why<br>&gt; this is happening .i am attaching the code also.Thanks all for the great<br>&gt; help.<br><br>What is the error message if you replace printf("iopl err\n") with<br>perror("iopl") ?<br><br>-- <br>                                                 Gilles Chanteperdrix<br></blockquote><br><p>&#32;

<hr size=1>Need a quick answer? Get one in minutes from people who know. Ask your question on
 <a href="http://answers.yahoo.com/;_ylc=X3oDMTFvbGNhMGE3BF9TAzM5NjU0NTEwOARfcwMzOTY1NDUxMDMEc2VjA21haWxfdGFnbGluZQRzbGsDbWFpbF90YWcx">Yahoo! Answers</a>.
--0-473962387-1166113626=:81959--


Message-ID: <20060613184708.6958.qmail@domain.hid>
Date: Tue, 13 Jun 2006 11:47:08 -0700 (PDT)
From: Cedric Herreman <glocker50@domain.hid>
Subject: Re: [Xenomai-help] Compaq nc6120 timer frequency
In-Reply-To: <17549.52124.344294.89351@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1624889140-1150224428=:5468"
Content-Transfer-Encoding: 8bit
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
Cc: xenomai-help <xenomai@xenomai.org>

--0-1624889140-1150224428=:5468
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Gilles,
 
 Disabling ACPI fixed the problem. Thanks for your help.
 
 Cedric.

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote: Cedric Herreman wrote:
 > I disabled CPU Frequency Scaling and recompiled kernel + modules, but the problem remains.
 >  

If it is not done, please also disable CONFIG_ACPI_PROCESSOR.

Do you observe the same behaviour with the latency test ? If yes, could
you send us your .config, if not, could you show us a minimal piece of
code which has a problem ?

-- 


         Gilles Chanteperdrix.


 __________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1624889140-1150224428=:5468
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Gilles,<br> <br> Disabling ACPI fixed the problem. Thanks for your help.<br> <br> Cedric.<br><br><b><i>Gilles Chanteperdrix &lt;gilles.chanteperdrix@xenomai.org&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Cedric Herreman wrote:<br> &gt; I disabled CPU Frequency Scaling and recompiled kernel + modules, but the problem remains.<br> &gt;  <br><br>If it is not done, please also disable CONFIG_ACPI_PROCESSOR.<br><br>Do you observe the same behaviour with the latency test ? If yes, could<br>you send us your .config, if not, could you show us a minimal piece of<br>code which has a problem ?<br><br>-- <br><br><br>         Gilles Chanteperdrix.<br></blockquote><br><p>&#32;__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-1624889140-1150224428=:5468--


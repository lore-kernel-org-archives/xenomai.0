Message-ID: <6132061f0805071406p72fde054i68e0d942bcff7748@domain.hid>
Date: Wed, 7 May 2008 18:06:33 -0300
From: "Breno Carneiro Pinheiro" <brenodee@domain.hid>
In-Reply-To: <2ff1a98a0805071052g1515edbam19ad164ce2e53b5d@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14066_32925028.1210194393089"
References: <3d3b73870805061301m4a89029eqa69c17b212274f38@domain.hid>
	<6132061f0805071046h65ce2f7eme4fade4c404223a9@domain.hid>
	<2ff1a98a0805071052g1515edbam19ad164ce2e53b5d@domain.hid>
Subject: Re: [Xenomai-help] Does Xenomai 2.4.x support Xenomm ?
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

------=_Part_14066_32925028.1210194393089
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Gilles, it seems compiled. But I tried to run it but I the command
./test_task is not enough, isn't it? I also tried xeno-load but it's a
coomand not found on my system.

Have any tips?

Thanks again,

Breno

2008/5/7 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:

> On Wed, May 7, 2008 at 7:46 PM, Breno Carneiro Pinheiro
>  > LDFLAGS := -lnative $(shell $(XENO_CONFIG) --xeno-ldflags)
>
> This should be:
>
>  LDFLAGS := $(shell $(XENO_CONFIG) --xeno-ldflags) -lnative
>
> Order matters.
>
> --
>  Gilles
>

------=_Part_14066_32925028.1210194393089
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Gilles, it seems compiled. But I tried to run it but I the command ./test_task is not enough, isn&#39;t it? I also tried xeno-load but it&#39;s a coomand not found on my system.<br><br>Have any tips?<br><br>Thanks again,<br>
<br>Breno<br><br><div class="gmail_quote">2008/5/7 Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Wed, May 7, 2008 at 7:46 PM, Breno Carneiro Pinheiro<br>
<div class="Ih2E3d">&nbsp;&gt; LDFLAGS := -lnative $(shell $(XENO_CONFIG) --xeno-ldflags)<br>
<br>
</div>This should be:<br>
<br>
&nbsp;LDFLAGS := $(shell $(XENO_CONFIG) --xeno-ldflags) -lnative<br>
<br>
Order matters.<br>
<br>
--<br>
<font color="#888888">&nbsp;Gilles<br>
</font></blockquote></div><br>

------=_Part_14066_32925028.1210194393089--


Date: Thu, 27 Jan 2011 09:58:58 +0100 (CET)
From: Michel Rinaldi <automation.03@domain.hid>
Message-ID: <29228600.131296118733562.JavaMail.SYSTEM@PC-MRINALDI>
In-Reply-To: <11269195.111296118370328.JavaMail.SYSTEM@PC-MRINALDI>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_10_26484724.1296118733562"
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

------=_Part_10_26484724.1296118733562
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Posted by Gilles Chanteperdrix on January 25, 2011 - 14:27: 

>Well, no. dd if=/dev/zero of=/dev/null is far from being a proper load. 
>What you should do is at least to create some disk and network activity, 
>continuously. And the ideal, is to run the LTP test in parallel. If you 
>can not, then at least run hackbench in a loop. All this during several 
>hours. 

Ok. I run LTP test and latency test in parallel for about 15 hours continuously. 
I have this result at the end: 

RTD| 6.182| 7.627| 47.662| 0| 0| 15:04:32/15:04:32 

I also run hackbench in a loop (with 100 groups) for about 14 hours and I obtain: 

RTD| 6.100| 8.341| 21.727| 0| 0| 13:39:24/13:39:24 

>We add ids to the smi.c table when people send patches, and report that 
>the workaround... works. Anyway, if you suspect that the ICH workaround 
>does not work with SCH chipsets, you should have a look at the SCH 
>chipsets datasheet, to check whether the method for disabling SMIs is 
>the same. 

I'll try to check this and I'll inform you if I succeed in disabling SMIs on SCH. 

>In facts, same test (only without file transfer) under another system with 
>1GHz Intel Atom on a SCH (Poulsbo) chipset (not supported by Xenomai to 
>disable SMIs) reports these results: 
> 
>RTD| 11.353| 13.808| 31.264| 3| 0| 2.934| 231.539 

>What I do not understand, in on which system you get the issue with your 
>test application. If you want to know if the system on which you run the 
>test has an isssue, then surely you should test this system, not another... 

Yes, I run test on this Atom system only to have results from another machine to compare with results from my develop host. 
I'm testing only my develop host, for ease I synthetize again its features: 
Intel Celeron M 600MHz 
512MB ram 
ICH4 chipset (Xenomai's SMI workaround applied) 
Ubuntu 10.04 with compiled kernel 2.6.35.7 
Xenomai 2.5.5.2 
Adeos patch 2.7-04 

Thank you! 
Mauro 


------=_Part_10_26484724.1296118733562
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: Times New Roman; font-size: 12pt; color: #000000'=
>Posted by Gilles Chanteperdrix on January 25, 2011 - 14:27:<br><br>&gt;Wel=
l, no. dd if=3D/dev/zero of=3D/dev/null is far from being a proper load.<br=
>&gt;What you should do is at least to create some disk and network activit=
y,<br>&gt;continuously. And the ideal, is to run the LTP test in parallel. =
If you<br>&gt;can not, then at least run hackbench in a loop. All this duri=
ng several<br>&gt;hours.<br><br>Ok. I run LTP test and latency test in para=
llel for about 15 hours continuously.<br>I have this result at the end:<br>=
<br>RTD| 6.182| 7.627| 47.662| 0| 0| 15:04:32/15:04:32<br><br>I also run ha=
ckbench in a loop (with 100 groups) for about 14 hours and I obtain:<br><br=
>RTD| 6.100| 8.341| 21.727| 0| 0| 13:39:24/13:39:24<br><br>&gt;We add ids t=
o the smi.c table when people send patches, and report that<br>&gt;the work=
around... works. Anyway, if you suspect that the ICH workaround<br>&gt;does=
 not work with SCH chipsets, you should have a look at the SCH<br>&gt;chips=
ets datasheet, to check whether the method for disabling SMIs is<br>&gt;the=
 same.<br><br>I'll try to check this and I'll inform you if I succeed in di=
sabling SMIs on SCH.<br><br>&nbsp;&nbsp;&nbsp; &gt;In facts, same test (onl=
y without file transfer) under another system with <br>&nbsp;&nbsp;&nbsp; &=
gt;1GHz Intel Atom on a SCH (Poulsbo) chipset (not supported by Xenomai to =
<br>&nbsp;&nbsp;&nbsp; &gt;disable SMIs) reports these results:<br>&nbsp;&n=
bsp;&nbsp; &gt;<br>&nbsp;&nbsp;&nbsp; &gt;RTD| 11.353| 13.808| 31.264| 3| 0=
| 2.934| 231.539 <br><br>&gt;What I do not understand, in on which system y=
ou get the issue with your<br>&gt;test application. If you want to know if =
the system on which you run the<br>&gt;test has an isssue, then surely you =
should test this system, not another...<br><br>Yes, I run test on this Atom=
 system only to have results from another machine to compare with results f=
rom my develop host.<br>I'm testing only my develop host, for ease I synthe=
tize again its features:<br>Intel Celeron M 600MHz<br>512MB ram<br>ICH4 chi=
pset (Xenomai's SMI workaround applied)<br>Ubuntu 10.04 with compiled kerne=
l 2.6.35.7<br>Xenomai 2.5.5.2<br>Adeos patch 2.7-04<br><br>Thank you!<br>Ma=
uro<br><br></div></body></html>
------=_Part_10_26484724.1296118733562--


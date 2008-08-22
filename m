Date: Fri, 22 Aug 2008 07:45:46 -0700 (PDT)
From: Stankiewicz Bredkjaer <stan.bred@domain.hid>
In-Reply-To: <d6c8ef150808220431q3c72b246r74bf39e3187a87a7@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1212899228-1219416346=:20698"
Message-ID: <814460.20698.qm@domain.hid>
Subject: Re: [Xenomai-help] ARM926EJ-S and Xenomai
Reply-To: stan.bred@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai@xenomai.org

--0-1212899228-1219416346=:20698
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi=A0 Bosko,
yeah Atmel's AT91SAM926x is similar to the one I'm using.
I am sure checking to see what I have to change and what not.
I'll let you know, if I'm stuck anywhere.

Thanks for the hints.

Regards,

Stan.


--- On Fri, 8/22/08, Bosko Radivojevic <bosko.radivojevic@domain.hid> wrote:
From: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Subject: Re: [Xenomai-help] ARM926EJ-S and Xenomai
To: stan.bred@domain.hid
Date: Friday, August 22, 2008, 9:31 PM

Hi Stan,

ARM926EJ CPU is fully supported both by vanilla Linux and by I-Pipe
Adeos (on which Xenomai relies). Gilles is right, a lot of changes
happen in Linux kernel between 2.6.10 and the newest 2.6.26 version.
In the meantime, a lot of davinci drivers are incorporated in 2.6.26
version. Besides that, I saw a few new patches that have good chance
to be part of 2.6.27.

>From my point of view, besides maybe some not so big changes on the
linux side, you'll have to add board support to the Xenomai. There are
similar (with the same CPU) boards supported, like Atmel's
AT91SAM926x. As Gilles said, you can copy&paste a lot of code from
Linux drivers (timer, gpio, etc) :)

If you need some help, please ask.

Sincerely,
Bosko
=0A=0A=0A      
--0-1212899228-1219416346=:20698
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;">Hi&nbsp; Bosko,<br><pre>yeah Atmel's AT91SAM926x is similar to the one I'm using.<br>I am sure checking to see what I have to change and what not.<br>I'll let you know, if I'm stuck anywhere.<br><br>Thanks for the hints.<br><br>Regards,<br><br>Stan.<br></pre><br><br>--- On <b>Fri, 8/22/08, Bosko Radivojevic <i>&lt;bosko.radivojevic@domain.hid&gt;</i></b> wrote:<br><blockquote style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;">From: Bosko Radivojevic &lt;bosko.radivojevic@domain.hid&gt;<br>Subject: Re: [Xenomai-help] ARM926EJ-S and Xenomai<br>To: stan.bred@domain.hid<br>Date: Friday, August 22, 2008, 9:31 PM<br><br><pre>Hi Stan,<br><br>ARM926EJ CPU is fully supported both by vanilla Linux and by I-Pipe<br>Adeos (on which Xenomai relies). Gilles is right, a lot of changes<br>happen in Linux kernel between 2.6.10 and the newest
 2.6.26 version.<br>In the meantime, a lot of davinci drivers are incorporated in 2.6.26<br>version. Besides that, I saw a few new patches that have good chance<br>to be part of 2.6.27.<br><br>From my point of view, besides maybe some not so big changes on the<br>linux side, you'll have to add board support to the Xenomai. There are<br>similar (with the same CPU) boards supported, like Atmel's<br>AT91SAM926x. As Gilles said, you can copy&amp;paste a lot of code from<br>Linux drivers (timer, gpio, etc) :)<br><br>If you need some help, please ask.<br><br>Sincerely,<br>Bosko<br></pre></blockquote></td></tr></table><br>

      
--0-1212899228-1219416346=:20698--


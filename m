From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Mon, 12 Nov 2007 01:55:17 +0100
References: <200709201549.13035.lepalom@domain.hid>
	<200711090014.57185.berlemont.hauw@domain.hid>
	<200711090037.14484.lepalom@domain.hid>
In-Reply-To: <200711090037.14484.lepalom@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="Boundary-01=_1R6NHloNar6CWQz"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711120155.17967.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] Comedi driver for use with xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: lepalom@domain.hid, xenomai@xenomai.org

--Boundary-01=_1R6NHloNar6CWQz
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,


> > Could you send me your kernel configuration file?
>
> send ...
>

Thanks to your configuration file, I was able to reproduce the bug on my emulator.

It was one of my many bugs: a queue initialization was missing. Then, a spinlock was not initialized and triggers in your case the spinning of the task insmod.

Fixed in svn. Please update.

Alexis.

--Boundary-01=_1R6NHloNar6CWQz
Content-Type: text/html;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

<html><head><meta name="qrichtext" content="1" /></head><body style="font-size:10pt;font-family:Sans Serif">
<p>Hi,</p>
<p></p>
<p></p>
<p><span style="color:#007000">&gt; &gt; Could you send me your kernel configuration file?</span></p>
<p><span style="color:#008000">&gt;</span></p>
<p><span style="color:#008000">&gt; send ...</span></p>
<p><span style="color:#008000">&gt;</span></p>
<p></p>
<p><span style="color:#ff0000">Thanks</span> <span style="color:#ff0000">to</span> <span style="color:#ff0000">your</span> configuration file, I <span style="color:#ff0000">was</span> <span style="color:#ff0000">able</span> <span style="color:#ff0000">to</span> <span style="color:#ff0000">reproduce</span> <span style="color:#ff0000">the</span> <span style="color:#ff0000">bug</span> on <span style="color:#ff0000">my</span> <span style="color:#ff0000">emulator</span>.</p>
<p></p>
<p>It was one of my many bugs: a queue initialization was missing. Then, a spinlock was not initialized and triggers in your case the spinning of the task insmod.</p>
<p></p>
<p>Fixed in svn. Please update.</p>
<p></p>
<p>Alexis.</p>
<p></p>
</body></html>
--Boundary-01=_1R6NHloNar6CWQz--



From: Bernhard Walle <bernhard.walle@domain.hid>
Date: Mon, 8 May 2006 00:21:06 +0200
Message-ID: <if82j3-9ug.ln1@domain.hid>
References: <050720061514.21865.445E0ED2000D33230000556922058863609C0E0301089BD2040A969B0799@domain.hid>
	<445E68C0.7060404@domain.hid>
	<200605072202.22555.witzel.thomas@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: news <news@domain.hid>
Subject: [Xenomai-help] Re: RTDM driver questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi Thomas,

Thomas Witzel <witzel.thomas@domain.hid> [2006-05-07]:
> 
> > Generally spoken, mmap can make sense if you have a significant amount
> > of data to transfer, not "just" a few kbyte/s. RTDM has the elementary
> > support for such device interfaces now, and this has already been used
> > for a frame-grabbing driver.
> What would be the proper procedure for just a few kbytes ? I expect less than 
> 500 kB./second in my application.

Simply read() / write() ?


Regards,
  Bernhard
-- 
Das Telefon hat zu viele ernsthaft zu bedenkende Mängel für ein
Kommunikationsmittel. Das Gerät ist von Natur aus von keinem Wert für
uns. -- »Western Union«, Interne Meldung (1876)



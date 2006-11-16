Message-ID: <54b161f50611160723r355a603awc1d8e1234e5ed44d@domain.hid>
Date: Thu, 16 Nov 2006 16:23:37 +0100
From: "Frits de Klark" <mailing.xenomai@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_92473_29330027.1163690617201"
Subject: [Xenomai-help] invalid parameter for xeno_rtcan_mem.ko
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

------=_Part_92473_29330027.1163690617201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everyone,

I tried to load the xeno_rtcan_mem module. I got a message that parameter
'io' is unknown. After a modinfo I found out that the actual parameter
should be 'mem'. I suggest you fix this, since it can be somewhat confusing.

Best regards,

Frits

------=_Part_92473_29330027.1163690617201
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everyone,<br>
<br>
I tried to load the xeno_rtcan_mem module. I got a message that
parameter 'io' is unknown. After a modinfo I found out that the actual
parameter should be 'mem'. I suggest you fix this, since it can be
somewhat confusing.<br>
<br>
Best regards,<br>
<br>
Frits<br>

------=_Part_92473_29330027.1163690617201--


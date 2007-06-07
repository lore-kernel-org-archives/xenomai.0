From: NZG <ngustavson@domain.hid>
Date: Thu, 7 Jun 2007 14:46:10 -0500
References: <200706071357.12212.ngustavson@domain.hid>
	<200706071413.10635.ngustavson@domain.hid>
	<1181244856.4998.133.camel@domain.hid>
In-Reply-To: <1181244856.4998.133.camel@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200706071446.10731.ngustavson@domain.hid>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] writing from NRT to a rt_pipe
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

> Yes, clearly.
Ah, that in conjunction with the
"can't use message pipe - Cannot allocate memory"
thread resolves my issues then.

My assumption was that data would exist in the pipe after the write until the 
pipe was destroyed, irrespective of the "openness" of the NRT side.

It's possible that this assumption is due to a lack of experience with pipes 
in general, I don't know.

thank you for all you help,
NZG



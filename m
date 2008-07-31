Message-ID: <4891AC9B.9020704@domain.hid>
Date: Thu, 31 Jul 2008 14:14:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <406CC9939904F143B9D42CEEA3E56E563AC067@domain.hid>	<48918FF9.6030804@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E563AC08E@oab1mx1.oneaccess.intra>
	<489194FD.8000004@domain.hid>
In-Reply-To: <489194FD.8000004@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xnpipe EPOLLIN starvation
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
Cc: xenomai@xenomai.org, Filip Van Rillaer <Filip.VanRillaer@domain.hid>

Philippe Gerum wrote:
> Filip Van Rillaer wrote:
>> Hello Gilles,
>>
>> EPOLLET is indeed enabled.
>> The first time EPOLLIN is received in the 2nd domain, I do a read (it
>> receives 1 byte in a buffer of 256).  So the read is exhausted and I
>> expect that the next time data arrives I should get the EPOLLIN (as it
>> BECOMES readable). 

My point is that, when edge-triggered, you will not get notified if you
receive data while the reading thread has not yet managed to handle the
first notification.

-- 
                                                 Gilles.


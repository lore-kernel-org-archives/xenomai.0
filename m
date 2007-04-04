Message-ID: <4613623A.6090008@domain.hid>
Date: Wed, 04 Apr 2007 10:30:50 +0200
From: Stephan Zimmermann <s.zimmermann@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Which thread holds a Mutex?
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

Hi,
I see a deadlock occur every now and than in my app. Is there a way to 
tell which thread is actually holding a lock from a normal userspace 
app? rt_mutex_inquire() only tells me that it is locked, but not who is 
holding it.

Tia, Stephan


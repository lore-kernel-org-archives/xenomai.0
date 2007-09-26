Message-ID: <1ce16a2c0709261252o67cebde3q8cf03a0d21a27288@domain.hid>
Date: Wed, 26 Sep 2007 21:52:24 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] rtdm driver development
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai <xenomai@xenomai.org>

Hi
I've implemented a ringbuffer which will buffer strings between a
pipe-read-task=>[buffer]=>rtdm-rtserial-writetask

The buffer has been implemented in userland and it works.
But in kernelspace (everything in a loaded in a kernel-module) things
doesn't work. It's the put(token) which doesn't work.
The function is put(char* c){ ... }

I've heard that there's an address difference. But how do I handle that?

http://www.xenomai.org/documentation/trunk/html/api/group__util.html#g9ce418051ccb7dd2366128efb8674262
is rtdm_strncpy_from_user() something I should use?

exactlly what is: rtdm_user_info_t *  else than a pointer?
Where do I declare it? There's no clickable link in the api for that that type..

The description sais: "User information pointer as passed to the
invoked device operation handler"
...

/B


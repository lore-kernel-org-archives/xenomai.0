MIME-Version: 1.0
Date: Wed, 29 Jul 2009 09:33:49 +0100
Message-ID: <abaf774b0907290133j6c2ec456s7be6c65de6993e3f@domain.hid>
From: Steve <sbxenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Setup LTTng with Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hi,

I've been looking into using LTTng with Xenomai and each time I try to
find more information I find a different post with new links to
various patches and websites.  The most recently dated information
that I have found is 24th Feb 2009:

https://mail.gna.org/public/adeos-main/2009-02/msg00031.html

Is this the latest info, and is 'git.kiszka.org' the best source for
LTTng - Adeos combinations?

Also, I have tried to apply the Xenomai patch given by the link in the
above post, the one at:

http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/6009

However, this does not work on my copy of Xenomai (2.4.8) - which
version of Xenomai was the patch designed for, and is there a more
recent patch for 2.4.8 (or am I doing something wrong)?

Finally, once I have the linux kernel tree with lttng and adeos (from
kiszka.org), and the patched Xenomai (using the patch from gmane.org),
I assume that I then prepare the kernel using Xenomai in the normal
fashion (omitting the adeos patch because it is already applied), and
then I can configure and compile the kernel as normal.  Is this
correct?

Thanks in advance for any help that you can give,

Steve


Message-ID: <48DD05F2.4040203@domain.hid>
Date: Fri, 26 Sep 2008 17:55:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2b490f270809260610w4573446x507ef059d4b3ca0b@domain.hid>
In-Reply-To: <2b490f270809260610w4573446x507ef059d4b3ca0b@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Segmentation Fault
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dehann Fourie <dehann.fourie@domain.hid>
Cc: xenomai@xenomai.org

Dehann Fourie wrote:
> Hi,
> 
> I'm having trouble with a segmentation fault in my real-time application.
> The problem seems to occur when I use large amounts of memory. The
> application works fine when I don't try to populate the large arrays.
> 
> I have tried changing parameters in the real time create call, but this
> didn't work. The error message is:
> 
> Xenomai: Switching nav to secondary mode after exception #14 from user-space
> at 0x804ad13 (pid 1938)
> nav [1938]; segfault at 26756e50 eip 0804ad13 esp b762ac28 error 6
> Segmentation fault
> 
> This is from text mode.

You do not give us much information about your configuration. However,
have you tried gdb ? In case of segmentation faults, it should stop you
right at the point where the segmentation occurs.

-- 
					    Gilles.


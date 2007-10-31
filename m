MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18216.57598.559447.478769@domain.hid>
Date: Wed, 31 Oct 2007 21:09:34 +0100
In-Reply-To: <20071031154106.29f66afc@domain.hid>
References: <20071031154106.29f66afc@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] rt_task_inquire and NULL 2nd arg
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai@xenomai.org

Daniel Simon wrote:
 > Hello all,
 > 
 > I am testing some former programs with xenomai-2.4-rc4/kernel-2.6.23.1/pentiumM;
 > 
 > Calling rt_task_inquire(Id, NULL) with a null second argument now
 > freezes or reboots the pc...
 > 
 > I had no problem with this call with a former (2.3.1) xenomai version. Is it a
 > known behaviour?

the rt_task_inquire system call checks that the "info" pointer points to
a piece of writable memory and returns -EFAULT otherwise. So, what you
should get is a segmentation fault, no freeze or reboot. Actually, I
have tested a small test which segfaults as expected. Could you provide
us with the simple test that causes a freeze or reboot ?

-- 


					    Gilles Chanteperdrix.


Message-ID: <4869EF09.2060908@domain.hid>
Date: Tue, 01 Jul 2008 10:47:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080626100340.308320@domain.hid>
	<20080630084032.317850@domain.hid>	<4868E463.5080103@domain.hid>
	<20080701074558.317840@domain.hid>
In-Reply-To: <20080701074558.317840@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with Threads and RTnet
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Reichert <Karl-Trampe@domain.hid>
Cc: xenomai@xenomai.org

Karl Reichert wrote:
>>> Forgot to close the socket when program finishes, this is why the
>>> second run always failed. Now it works :)
>>>
>>> I thought that the socket will be closed automatically when the
>>> program exits, as this is the case in POSIX?! Is there a reason why
>>> this is not done in RTnet?
>> RTDM should do it with Xenomai 2.4. Are you sure you are not using an 
>> older version of the kernel-space support ?
> 
> No, I'm using Xenomai 2.4.3 without any additional patches, so there is no older version of kernel-space support installed.

If you have a simple test program, I would be glade to cross-check here.

Moreover, you could have a look at /proc/xenomai/rtdm/open_fildes before
and after closing your app. It should give an overview on all open
descriptors. If they are stalled after closing your RTnet app, this is
definitely a bug that has to be understood and fixed.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux


Message-ID: <4A5388E1.7070800@domain.hid>
Date: Tue, 07 Jul 2009 19:41:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <206278.72023.qm@domain.hid>
In-Reply-To: <206278.72023.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_create memory size
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yigal Goldberger <yigal_gold@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Yigal Goldberger wrote:
> Hi Gilles,
> Thanks for your quick reply.
> I'd like to give some more details based on some expirements I've made .
> I tried an older version of linux and xenomai (linux 2.6.14.7 ) and when I enlarged the requested stack size to 32KB instead of 8KB I saw a **dramatic** reduction in memory consumption per thread (~30MB less!!!).
> I saw that there is some minimum stack size that if trying to create a thread with a smaller value will end up with the default (2MB ?) .
> This improved to some extent the memory usage of my application also in the new version (linux 2.6.29 + new xenoami - recently ported to mpc8272ads by DENX ) , but I am getting the following :
> 
> 2.6.14.7 :
> application usage :  ~31MB
> 
> 
> 2.6.29.4
> application usage : ~180MB 
> 
> The application is the same in both versions , so I can't think of where ~150MB are comming from ?

As I told you in the previous mail, see /proc/pid/maps to see how the
memory is spent.

-- 
					    Gilles.


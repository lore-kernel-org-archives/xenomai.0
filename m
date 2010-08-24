Message-ID: <4C73C649.1030908@domain.hid>
Date: Tue, 24 Aug 2010 15:16:57 +0200
From: Ramon <ramoncostacastello@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] periodical task in posix skin
Reply-To: ramoncostacastello@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Hi,

I'm sorry in my previous email I made an error.

If I use

clock_gettime      ( TIMER_ABSTIME, &now);
now.tv_nsec=now.tv_nsec+PERIOD;
out=pthread_make_periodic_np (pthread_self(), &now,&period);
......

it always says that "the start time has already passed\n". Differently 
if I use

clock_gettime      ( CLOCK_REALTIME, &now);
        now.tv_nsec=now.tv_nsec+PERIOD;
        out=pthread_make_periodic_np (pthread_self(), &now,&period);

  everything works fine.


Ramon


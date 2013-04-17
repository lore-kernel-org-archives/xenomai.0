MIME-Version: 1.0
In-Reply-To: <CAG5EsAHjpA0JTKHGVsq2Egbq+r3Hx=xV_U3bp+zWxHa0dUTrzg@mail.gmail.com>
References: <CAG5EsAGn8oNQkH-OkEpS6NHjW7y1vZfp5HjV3+FTGi-eh667pg@mail.gmail.com>
	<00DF7AD9-868B-4AFC-B385-8C47F8522E4B@mah.priv.at>
	<516F1510.3030608@xenomai.org>
	<CAG5EsAHjpA0JTKHGVsq2Egbq+r3Hx=xV_U3bp+zWxHa0dUTrzg@mail.gmail.com>
Date: Thu, 18 Apr 2013 01:51:53 +0200
Message-ID: <CAOiXNkDzXfpHc8a-LGCQ_fCqDvz44cc7Xg21K9sbEE4PC6_6Xw@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] rtdm and rasberry-pi GPIO
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ross Williamson <rwilliamson@astro.caltech.edu>
Cc: xenomai@xenomai.org

Hi Ross,

> I'm guessing that doesn't say much. Anyhow code is below - feel free to rip
> it apart or tell me better ways of doing things.

You might be interested to take a look at the following article:
http://veter-project.blogspot.com/2012/04/precise-pwms-with-gpio-using-xenomai.html
Corresponding sources are available here:
https://github.com/andreynech/rtdm-pwm

As suggested in this list, we were able to get better results with
timer-based approach instead of using tasks.


Regards,
Andrey.

web: http://veterobot.org
blog: http://veter-project.blogspot.com


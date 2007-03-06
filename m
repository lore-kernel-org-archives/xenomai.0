Message-ID: <bc4264770703060854h503da372k360face734eb8be4@domain.hid>
Date: Tue, 6 Mar 2007 16:54:15 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
In-Reply-To: <E1HOcnN-0005Ys-PH@mailer.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<45ED93AE.5050007@domain.hid>
	<bc4264770703060832x4ddab7b8mbb1d477588af8608@domain.hid>
	<E1HOcnN-0005Ys-PH@mailer.emlix.com>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

> > What does output of latency mean? Is the above result simply stating
> > that I have a crappy hardware structure and will never be able to
> > achieve better latency or does it tell me there is something wrong
> > with my application?
>
> That is still to discover. Please change the priorities of your RT Tasks lower
> than 99 and run again,
Will do.

>Alternatively, do it with rtcansend/rtcanrecv as I
> told you before.
Below is the output with those running. The node is active but not
moving and then the jump when the shaft is rotated.

My application is NOT running during this experiment.

RTD|      28.495|      29.333|      44.419|       0|      28.495|      44.419
RTD|      28.495|      29.333|      93.028|       0|      28.495|      93.028
RTD|      28.495|      29.333|      36.876|       0|      28.495|      93.028
RTD|      28.495|      29.333|      34.361|       0|      28.495|      93.028
RTD|      28.495|      29.333|      34.361|       0|      28.495|      93.028
RTD|      28.495|      29.333|      35.199|       0|      28.495|      93.028
RTD|      28.495|      29.333|      34.361|       0|      28.495|      93.028
RTD|      28.495|      29.333|      35.199|       0|      28.495|      93.028
RTD|      28.495|      29.333|      34.361|       0|      28.495|      93.028
RTD|      28.495|      29.333|      35.199|       0|      28.495|      93.028
RTD|      28.495|      34.361|     181.028|       0|      28.495|     181.028
RTD|      28.495|      51.123|     183.542|       0|      28.495|     183.542
RTD|      28.495|      49.447|     181.866|       0|      28.495|     183.542
RTD|      28.495|      37.714|     181.866|       0|      28.495|     183.542
RTD|      28.495|      37.714|     182.704|       0|      28.495|     183.542
RTD|      28.495|      34.361|     185.219|       0|      28.495|     185.219
RTD|      28.495|      48.609|     181.866|       0|      28.495|     185.219
RTD|      28.495|      58.666|     183.542|       0|      28.495|     185.219
RTD|      28.495|      58.666|     182.704|       0|      28.495|     185.219
RTD|      28.495|      42.742|     182.704|       0|      28.495|     185.219
RTD|      28.495|      31.847|     181.028|       0|      28.495|     185.219
---|------------|------------|------------|--------|-------------------------


Roland.



>
> --
> Sebastian
>


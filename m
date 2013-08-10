MIME-Version: 1.0
In-Reply-To: <520604C3.90903@gmail.com>
References: <52039EC3.4050908@gmail.com>
	<2A0F278E-ED28-46CC-8727-DC97BB89A6D6@mah.priv.at>
	<68671d77.6ce2003b.520526a4.3e2c@o2.pl> <520604C3.90903@gmail.com>
Date: Sat, 10 Aug 2013 11:36:01 +0200
Message-ID: <CAOiXNkAf0Aavoa04f4T66rC=PGHebTwbUGfeEH47woCOJXzmLg@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Using hardware PWM generators with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

> Me, I'd go for the gpio route only if the onboard PWM
> generation hardware does not provide sufficient number of PWMs.

This is the typical reason for it. At least it was the case in our
project - 3 was not enough.

Regards,
Andrey.


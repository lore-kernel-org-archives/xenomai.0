MIME-Version: 1.0
In-Reply-To: <CAM1yFZ8ecwqQ5C2s8Wunv-jxvwYV+AqfsHoZYVsQcBu2ZovADg@mail.gmail.com>
References: <CAM1yFZ9tDsgAYo1dJOc7CxoAEnLLkFqnQBL8QbO8Wb=K2yY4wg@mail.gmail.com>
	<4FC86B6E.6050705@xenomai.org>
	<CAM1yFZ-KEO3Z7K+YXDBZdZExrYe3jffd6jfS-FM7W=8Zu2jdsA@mail.gmail.com>
	<4FC8CCC2.9010103@xenomai.org>
	<CAM1yFZ8ecwqQ5C2s8Wunv-jxvwYV+AqfsHoZYVsQcBu2ZovADg@mail.gmail.com>
Date: Mon, 4 Jun 2012 10:16:15 +0530
Message-ID: <CAM1yFZ_6fkpLEYpUEMKhrefgGBKpMS9N2o0LM=Z8C_1kKizfKA@mail.gmail.com>
From: Anisha Kaul <born.rebel.83@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] CONFIG_CPU_FREQ, CONFIG_APM. kernel - 2.6.38.8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

>> The GUI has a "research" function. I believe in make menuconfig it is
>> the '/' character.

It is solved now. The problem was that APM depends on X86_32.
Mine machine is 64bit. That's why APM isn't there.

--
Anisha


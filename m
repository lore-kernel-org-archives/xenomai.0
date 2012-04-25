MIME-Version: 1.0
In-Reply-To: <CAKvQZ_3NQnhHWb32VuRxpFMC5RZRJQtukgx+nAzuUuqq6efUMA@mail.gmail.com>
References: <CAKvQZ_3NQnhHWb32VuRxpFMC5RZRJQtukgx+nAzuUuqq6efUMA@mail.gmail.com>
Date: Wed, 25 Apr 2012 11:57:04 +0200
Message-ID: <CAKvQZ_0d5OQnqEYkK5z7dTtRAXSyYEjY_hb7jfiwqj4atbV2og@domain.hid>
From: Willy Lambert <lambert.willy@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Using rt_dev_send from user space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

2012/4/23 Willy Lambert <lambert.willy@domain.hid>:
> Hi,
>
> The short story is that I tried to call rt_dev_send on a CAN RTDM
> driver, and it fails with an EPERM (Operation not permited) return
> code. It's as if I was using rtcansend without the "RT_TASK
> rt_task_desc;".
> Is it an intended behavior ?
> Do I have a way to configure this to be accessible from user space ?
> Do I have to call rt_task_shadow ?
>
> The long story is that I have a fully operationnal robot communicating
> over CAN with CanFestival with gluninux timers in the Orocos framework
> (only compiled for gnulinux). As it is showing CAN loop delays
> depending on CPU load, I am trying to switch CanFestival to xenomai in
> order to have a primary mode CAN SYNC timer, keeping my Framework
> Orocos out of xenomai (cause it is not stable in my version under
> xenomai). The problem is (I think) that none of my tasks are in
> xenomai primary mode, exept the CAN SYNC timer. As I would like to
> avoid using xenomai much before this summer, I'm looking for a simple
> way to send messages to rtcan driver from user space.

Sorry to bump this, but as it is a quite CAN related question should I
repost it on the socket can ML ? (related to some answers to an other
recent thread)


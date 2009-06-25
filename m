Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2009 11:36:27 +0200
Message-ID: <E5CDD68F7A516B4F863D651CDA2DBF71010A9E62@domain.hid>
References: <1245226350.3614.10.camel@domain.hid>
From: "LEMARCHAND Ludovic" <Ludovic.LEMARCHAND@tech.viveris.com>
Subject: [Xenomai-help] message pipe services
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello

I have an application with xenomai task and a standard linux process in =
order to establish a communication between them.
I have read that message pipe services is the best solution.

So, I tested the pipe.c exemple, but it doesn't compile. I have include =
native/pipe.h library but it doesn't find RT_PIPE_MSG and =
rt_pipe_alloc().
So, I take a look at the library and this elements are declared between =
ifdef __KERNEL__ ... endif, but this condition is never validate.

How can I register my xenomai task as __KERNEL__ ? Is it automatic, have =
I something to do ?

Thank you for any response and suggestions.

Ludovic Lemarchand


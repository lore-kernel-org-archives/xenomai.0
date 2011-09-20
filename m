MIME-Version: 1.0
Date: Tue, 20 Sep 2011 13:10:45 +0200
Message-ID: <CAMJ=MEc8-hCQQS3mQFta02=sMtsHtN4BwRu9Lfof1c13RG1ZwA@mail.gmail.com>
From: Ronny Meeus <ronny.meeus@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] pSOS skin in xenomai-solo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hello

We have ported a large pSOS based application to an Embedded Linux
environment using Xenomai.
A more or less stable version is running at this moment.

The application is not a real-time application at all, we basically
selected Xenomai for its pSOS interface.
Since our application uses also native Linux calls (for example socket
communication), we start to see some strange behavior.
Example: lower priority tasks are running in the xenomai domain while
higher priority tasks, sending data on a socket for example, have to
wait until all processing in the Xenomai domain is completed.

My feeling is that the Solo project would be better for us.
As far as I understand, this is just a thin layer on top of Linux,
purely running in user space that also offers the pSOS interface.
Is my understanding correct?

If it is, I would think that the socket issue described above will be
automatically solved since there will only be 1 scheduler (the Linux
one) and it will respect the thread/task priorities.

What is the status of this project?

Regards,
Ronny


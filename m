MIME-Version: 1.0
Date: Thu, 19 Jan 2012 16:50:37 +0100
Message-ID: <CA+fRa6evoCQZuWrRNQL2+SjLKTqcW1vJtfxAyZs60jS83sv5Gw@domain.hid>
From: Daniele <danielegottfried@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] error compiling pipe function
Reply-To: daniele.gottfried@domain.hid
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

Hi dear,


We are trying to implement pipe communication between real-time tasks
and non real-time main with:

[xenomai 2.6.0, kernel 2.6.38.8]

Compiling the program =A0we got several of the following error:

"implicit declaration of function 'rt_pipe_alloc'"

regarding pipe functions and typedef which seem not to be recognized,
although we included <native/pipe.h> in our C file.
Maybe it is necessary to modify also Makefile in oder to use pipe stuff?
Thank you in advance and best regards

Daniele


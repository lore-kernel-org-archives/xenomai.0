From: =?iso-8859-1?Q?Torsten_Kr=F6ger?= <t.kroeger@domain.hid>
Date: Thu, 9 Aug 2007 11:41:29 +0200
Message-ID: <000501c7da69$767922e0$c124a986@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <mailman.2979.1186650741.22887.xenomai@xenomai.org>
Subject: [Xenomai-help] POSIX Skin: Changing scheduling parameters of
	threads in other processes
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

Hello everybody,

this is my first email to this list, and I would like to start with a
question. I use the posix skin of Xenomai 2.3.1, and I have several
processes running, each consisting of several threads. Is there a
possibility for a thread A1 running in process A to change the
scheduling parameters, in particular the priority, of a thread B1
running in process B?

Regarding the posix specification I cannot find this functionality there
and so I guess there is no way doing it with "pthread_setschedparam()".
But is there another possibility?  

Any kind of feedback will be appreciated.


Best regards from Braunschweig,
Torsten



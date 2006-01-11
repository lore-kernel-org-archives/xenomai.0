From: Stephan Zimmermann <s.zimmermann@domain.hid>
Date: Wed, 11 Jan 2006 14:09:41 +0100
References: <43B8ED00.9070908@domain.hid>
In-Reply-To: <43B8ED00.9070908@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601111409.41282.s.zimmermann@domain.hid>
Subject: [Xenomai-help] Using Xenomai in C++ App.
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

Hello List, 
actually I am playing around with Xenomai 2.0.1 functions in a C++ 
Application. I Wrote some simple wrapper-classes to use mutexes, semaphores 
and tasks. Now, after thinking a while about message queues, I am confused 
somehow. Is it possible to use the standard 'new' Operator in a mutithreaded 
realtime application, or do I need to allocate memory inside a Xenomai heap 
(and overload operator new to do so)?

I would be thankful for some hints,
Greetings, Stephan


From: "Robert McCullough" <rob@domain.hid>
Date: Wed, 19 Mar 2008 18:05:19 -0400
Message-ID: <001a01c88a0d$5365af40$9601a8c0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Non-Real-Time Asynchronous Notification
Reply-To: rob@domain.hid
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

Hi,

How do I signal an asynchronous notification from a RTDM real-time task to a
non-real-time user-space Linux thread?
Do I use Non-Real-Time Signaling Services (rtdm_nrtsig_init,..)?
If so, how?

Here is the current code that I am trying to port to RTDM.

Current driver code to signal non-real-time Linux thread:

	// If event
	if(event){
		// and signal asynchronous readers 
		if (kmdpr_device->async_queue)
			kill_fasync(&kmdpr_device->async_queue, SIGIO,
POLL_IN);
	}

Current non-real-time Linux thread signal hander:

	// A static function to use for callback by OS
	static void signal_handler_func(int signo)
	{
		l_sighandler->signalHandler(signo);
	}

	void Kmss::startSignalHandler()
	{
		l_sighandler = this;

		struct sigaction action;

		memset(&action, 0, sizeof(action));
		action.sa_handler = signal_handler_func;
		action.sa_flags = 0;//SA_RESTART;

		sigaction(SIGIO, &action, NULL);
		fcntl(_fh, F_SETOWN, getpid());
		fcntl(_fh, F_SETFL, fcntl(_fh, F_GETFL) | FASYNC);
	}

	void Kmss::signalHandler(int signo)
	{
		kmdpr_events_t events;
	
		if (signo==SIGIO)
		{
			/* Process events */
		}
	}

Best regards, 
Rob




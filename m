MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18447.43488.713144.166771@domain.hid>
Date: Wed, 23 Apr 2008 23:28:00 +0200
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F1D@afsexc01.aurora.aero>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>
	<18446.32522.986935.299094@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F15@domain.hid>
	<2ff1a98a0804230658w57d54addu438948a91faed1d6@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F17@domain.hid>
	<2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid>
	<18447.31623.723753.421351@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F1D@afsexc01.aurora.aero>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Xenomai serial port c++ code and / or
	xeno--(xenomm-0.0.1) install problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org

Karch, Joshua wrote:
 > 
 > Gilles,
 > 
 > I decided to eliminate the pthread and create a task that handles the entire packet process, from reading the serial port, to decoding data, to disk io (saving the data to disk)  The only thing that's serviced occasionally is the main loop, which looks every half second for a keypress to quit.
 > 
 > Now, I get overrun errors once every 10 seconds to 30 seconds.  The machine is a PC/104 and I'm using fprintf to print the data received from the sensor to file-- should I use perhaps an RT version?.

No, as I already explained, you can not use fprintf and hope remaining
deterministic.

There is no function writing data to disk while remaining
deterministic. That would mean have disk drivers and so on written for
xenomai.

You have to design your application with an rt-task doing the rt work,
and a non rt-task doing the non rt work. This non rt-task can be a
classical pthread, in which case you will have to use an rt_pipe for
communications between the two tasks. Or the non rt-task can be a
xenomai thread with priority 0, in which case you can use any other
IPC.

For assistance in the daunting task of keeping deterministic, see the
bit T_WARNSW of the rt_task_set_mode service, or the bit PTHREAD_WARNSW
of the pthread_set_mode_np service.

-- 


					    Gilles.


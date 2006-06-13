Message-ID: <40729.155.98.4.39.1150217383.squirrel@domain.hid>
In-Reply-To: <448EE9C3.4060706@domain.hid>
References: <45045.155.98.4.39.1150149018.squirrel@domain.hid> 
	<448E5A2B.9060606@domain.hid>   
	<3384.206.81.135.88.1150211884.squirrel@domain.hid>   
	<448EDECA.7030302@domain.hid>
	<36429.155.98.4.39.1150216385.squirrel@domain.hid>
	<448EE9C3.4060706@domain.hid>
Date: Tue, 13 Jun 2006 10:49:43 -0600 (MDT)
Subject: Re: [Xenomai-help] strange periodic behavior
From: "Brandt Erickson" <brandt@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

 > Grmbl, my fault. Your test looks ok, but I was rather referring to your
> *code*.

Sorry, here's a small portion of what it outputs.  The first column is the
timestamp and the second is the overrun value from rt_task_wait_period. 
In this case, the "control loop" is supposed to be running at 10 KHz.

0.000087,	0
0.000302,	0
0.000522,	0
0.000742,	0
0.000962,	0
0.001182,	0
0.001402,	0
0.001623,	0
0.001843,	0
0.002063,	0
0.002283,	0
0.002503,	0
0.002723,	0
0.002944,	0
0.003164,	0
0.003384,	0
0.003604,	0
0.003824,	0
0.004045,	0
0.004265,	0
0.004485,	0
0.004705,	0
0.004925,	0
0.005146,	0
0.005366,	0
0.005586,	0
0.005806,	0
0.006026,	0
0.006246,	0
0.006467,	0
0.006687,	0
0.006907,	0
0.007127,	0
0.007347,	0
0.007568,	0
0.007788,	0
0.008008,	0
0.008228,	0
0.008448,	0
0.008669,	0
0.008889,	0
0.009109,	0
0.009329,	0
0.009549,	0
0.009769,	0
0.009990,	0
0.010210,	0



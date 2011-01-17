Date: Tue, 18 Jan 2011 00:26:33 +0100
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20110117232633.GA3023@domain.hid>
References: <CB64A448250ADE40A2D9459AEB556D5E02858217E5@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CB64A448250ADE40A2D9459AEB556D5E02858217E5@domain.hid>
Subject: Re: [Xenomai-help] Sample code about counter for quadrature encoder
 in S526 DAQ board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Kim, Jonghyun (NIH/CC) [F]" <jonghyun.kim@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Kim, Jonghyun (NIH/CC) [F] wrote:
> Hi.
> 

Sorry for the late reply.

> I wanna use S526 DAQ board under Xenomai 2.5.x.
> The major aim of S526 board is to measure angle by using quadrature encoder.
> 
> In contrast to AD and DA function of S526 board (e.g. insn_read and insn_write), 
> I was not able to find any sample code about counter function for quadrature encoder.
> 
> Could I get a sample code about counter for quadrature encoder in S526 board?
> (insn_read and insn_write are good example of the sample code)
> 

No sample program is available for this board. The main reason is that
we did not have enough time to work on a unified user-space API which
would work with any acquisition board (instead of developing a
specific test program for each board).

Simon ported the driver starting from the comedi version. In this
solution, the board registers were configured in user space thanks to
a configuration instruction.

A4L_INSN_CONFIG_GPCT_QUADRATURE_ENCODER:
		/*
		 * data[0]: Application Type
		 * data[1]: Counter Mode Register Value
		 * data[2]: Pre-load Register Value
		 * data[3]: Conter Control Register
		 */
A4L_INSN_CONFIG_GPCT_SINGLE_PULSE_GENERATOR:
		/*
		 * data[0]: Application Type
		 * data[1]: Counter Mode Register Value
		 * data[2]: Pre-load Register 0 Value
		 * data[3]: Pre-load Register 1 Value
		 * data[4]: Conter Control Register
		 */
A4L_INSN_CONFIG_GPCT_PULSE_TRAIN_GENERATOR:
		/*
		 * data[0]: Application Type
		 * data[1]: Counter Mode Register Value
		 * data[2]: Pre-load Register 0 Value
		 * data[3]: Pre-load Register 1 Value
		 * data[4]: Conter Control Register
		 */

> Or, how can I use the counter function of S526 board?
> 
> Thanks,
> 
> 
> Jonghyun
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Alexis.


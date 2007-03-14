MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-5
Content-Transfer-Encoding: 7bit
Message-ID: <17912.32723.685853.878873@domain.hid>
Date: Thu, 15 Mar 2007 00:05:55 +0100
Subject: Re: [Xenomai-help] mem usage and other application
In-Reply-To: <45F87F03.9090202@domain.hid>
References: <45F86426.9000309@domain.hid>
	<17912.26777.313494.393466@domain.hid>
	<45F87970.5060506@domain.hid>
	<17912.31765.786905.929691@domain.hid>
	<45F87F03.9090202@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Maksym Veremeyenko <verem@domain.hid>
Cc: Xenomai-help@domain.hid

Maksym Veremeyenko wrote:
 > Gilles Chanteperdrix ~~~~~:
 > 
 > > You should probably increase the system heap size, with the option
 > > CONFIG_XENO_OPT_SYS_HEAPSZ
 > There are problems with RT application, problem with non-RT application 
 > running on the same host, in the same time RT-application running...

What I would like to know is if switchtest fails in the same condition
as your non real-time applications, just to see if the situation you
observe is an FPU bug. But for switchtest to start correctly, you need
to increase CONFIG_XENO_OPT_SYS_HEAPSZ.

-- 


					    Gilles Chanteperdrix.


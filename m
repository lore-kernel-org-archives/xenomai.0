Message-ID: <497D628F.7020302@domain.hid>
Date: Mon, 26 Jan 2009 08:13:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <894886ec0901252258t12cef21dv863a921b10c042a1@domain.hid>
In-Reply-To: <894886ec0901252258t12cef21dv863a921b10c042a1@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ata revalidation failed?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rob Wheeler <wheeler@domain.hid>
Cc: xenomai@xenomai.org

Rob Wheeler wrote:
> We have a robot platform with 4 identical computers installed in its
> base.  Three of the computers are running an ubuntu 8.04 server
> distribution.  The fourth machine is running Xenomai 2.4.5 with a
> 2.6.24.3 kernel.  The Xenomai machine is used to send controls to the

Hi Rob,

what happened to your tests of Xenomai 2.4.6.1. You could not get it
running ?

I had a similar bug on my laptop, and it turned out that it was because
I used the ACPI processor module, which should not be used with Xenomai
anyway.

> Anyone have any ideas or suggestions on how to track this one down?

Try and enable the I-pipe tracer, and trigger a trace the first time you
get the revalidation error. Send the logs to the network using netconsole.

Enable other I-pipe debugging options such as context checking. Enable
Xenomai debugging options too.

-- 
					    Gilles.


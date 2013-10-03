Message-ID: <1bbd27a1a28522b51712cb856781b354.squirrel@127.0.0.1>
In-Reply-To: <524D764F.80301@axelsw.it>
References: <524ABEED.4090609@axelsw.it>
	<114ba7d302c4a7b01d85caf23c52fa10.squirrel@127.0.0.1>
	<524AC518.2040901@axelsw.it> <524B1E12.2010909@xenomai.org>
	<524D2C77.6050706@axelsw.it> <524D70A4.6020007@xenomai.org>
	<CAEk6gTB+KRO_3_x+i8hOiGXeRxSXP9WMk42CJCnz87SWSdKQjQ@mail.gmail.com>
	<524D764F.80301@axelsw.it>
Date: Thu, 3 Oct 2013 16:07:23 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] high latency with imx6q without smp
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roberto Bielli <roberto.bielli@axelsw.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Roberto Bielli wrote:
> Hi,
>
> the results of xeno-test are these.
> When i execute the xeno-test i run simultaneously a telnet with an 'ls
> -lr /' for increase etherne interrupts.

To get reliable results, the system should run several hour, with load
generated, for instance by running the dohell test.

Si xeno-test --help and dohell --help.

Even dohell without no argument is not a very good load.


-- 
                                              Gilles



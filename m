Message-ID: <4F68993E.5030503@domain.hid>
Date: Tue, 20 Mar 2012 15:50:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CB8DFE21.1EE1B%glen@domain.hid>
In-Reply-To: <CB8DFE21.1EE1B%glen@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Linux Serial Does not work
 with	CONFIG_XENO_OPT_PERVASIVE enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Glen Wernersbach <glen@domain.hid>
Cc: xenomai@xenomai.org

On 03/20/2012 02:28 PM, Glen Wernersbach wrote:
> Hi All,
> 
> I install Xenomai 2.6.0 on AT91SAM9G20 system and have found that when
> CONFIG_XENO_OPT_PERVASIVE is enabled my standard non real time linux serial
> write then read serial program does not work.
> 
> If I turn off CONFIG_XENO_OPT_PERVASIVE, my serial program does work.

Do you get a message on the kernel console about characters lost on
serial device? These seems to be more frequent when the interrupt
pipeline delays the interrupt than without the interrupt pipeline, but
always exists.

-- 
					    Gilles.


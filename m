Message-ID: <51713BD2.5060201@siemens.com>
Date: Fri, 19 Apr 2013 14:42:58 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <51713A81.7030704@arcor.de>
In-Reply-To: <51713A81.7030704@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno_16550A: only 115200 Baud possible
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Christopher Hahn <hahnchristopher@arcor.de>
Cc: xenomai@xenomai.org

On 2013-04-19 14:37, Christopher Hahn wrote:
> Hello,
> 
> I tried to send a message over a rt serial interface. Without the
> xeno_16550A module loaded everything works fine.
> 
> My steps are:
> 
> # deactive default serial port
> setserial /dev/ttyS1 uart none
> 
> # load real-time serial driver module
> modprobe xeno_16550A io=0x2f8 irq=3 baud_base=9600

Unless you have a very special UART adapter (I would say, you don't),
there is no need to play with baud_base. Check modinfo regarding the
semantic of the parameter.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux


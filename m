Message-ID: <52EBA769.9040605@siemens.com>
Date: Fri, 31 Jan 2014 14:38:49 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <52E67336.1010709@siemens.com> <52E6811E.10406@xenomai.org>
 <52E6813E.1050406@siemens.com> <52E6845E.2040300@xenomai.org>
 <52E68F5B.20805@siemens.com> <52E69418.5080700@xenomai.org>
 <52E699DF.4030609@siemens.com>
In-Reply-To: <52E699DF.4030609@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL][forge] Only export required CFLAGS via
	xeno-config
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2014-01-27 18:39, Jan Kiszka wrote:
> BTW, mercury's "make install" tries to create device nodes. I suppose
> that is not really required, is it?

Retested, and it was a false alarm, no device installation performed on
make install for mercury core.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux


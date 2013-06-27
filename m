Message-ID: <51CC899A.60407@xenomai.org>
Date: Thu, 27 Jun 2013 20:51:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.1.1371808801.4609.xenomai@xenomai.org>	<1371820048.30624.YahooMailNeo@web172205.mail.ir2.yahoo.com>	<51C45C6F.9080109@siemens.com>
	<000c01ce6f3f$ab320d50$019627f0$@de>	<51C7E9F2.6090307@siemens.com>
	<51C7F33B.6070800@siemens.com> <003701ce735b$7d70dd90$785298b0$@de>
In-Reply-To: <003701ce735b$7d70dd90$785298b0$@de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] High latency and smi with intel vendor chip
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Franz Engel <franz_lambert_engel@yahoo.de>
Cc: 'Jan Kiszka' <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 06/27/2013 07:26 PM, Franz Engel wrote:

> I cleared the bits (18, 17, 14, 13, 11, 6 and 3), rather, they were already
> cleared. The value of the register was 23.


Hi,

You may try to clear all bits except bits 0 and 1. Though, please run
tests, and check for overheating, in case one disabled SMI source is in
fact the fan control.


> But I have still latencies
> between 4us and 90us. Is there a best practice to find out what is the
> reason for this latencies?


First, please tell us which version of Linux you use, with which version
of the I-pipe patch. Then post your kernel configuration. For instance
if you have ACPI and/or USB disabled, you should enable them.

Regards.

-- 
                                                                Gilles.


Message-ID: <4EA66DF8.3050601@domain.hid>
Date: Tue, 25 Oct 2011 10:06:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1319490255.1417.YahooMailNeo@domain.hid>
In-Reply-To: <1319490255.1417.YahooMailNeo@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] address spaces of real-time task and standard
 linux process
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tom Z <tomz30@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/24/2011 11:04 PM, Tom Z wrote:
> Any ideas or suggestions will be highly appreciated. TomZ

Try gdb. If that fails, get the kernel to print the value of the
registers when the fault happens, then disassemble and look at why the
fault happens.

-- 
                                                                Gilles.


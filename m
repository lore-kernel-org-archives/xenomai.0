Message-ID: <4D2476A5.5080908@domain.hid>
Date: Wed, 05 Jan 2011 14:48:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <003001cbacde$f43fa500$dcbeef00$@com>
In-Reply-To: <003001cbacde$f43fa500$dcbeef00$@com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] XDDP socket problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gianni Perugini <gperugini@domain.hid>
Cc: xenomai@xenomai.org

Gianni Perugini wrote:
> Hi,
> 
>  
> 
> I would like to use XDDP-based RT/NRT threads communication on my
> application, but I'm having some problems. I can build successfully the file
> "XDDP-ECHO.C" found in the "EXAMPLES" folder, but when I start it, it fails
> with the following error: "socket: Address family not supported by
> protocol".
> 
>  
> 
> Please find attached config file, dmesg log and lsmod log.
> 
> I'm using kernel 2.6.35.7 and xenomai 2.5.5.2 with
> adeos-ipipe-2.6.35.7-x86-2.8-01.patch.

Then you probably do not compile it correctly. Please show us the result
of the command:

nm -s xddp-echo

-- 
					    Gilles.


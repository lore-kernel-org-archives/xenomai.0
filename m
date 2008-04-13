MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18434.11505.241730.648326@domain.hid>
Date: Sun, 13 Apr 2008 17:55:29 +0200
In-Reply-To: <003401c89d78$d187bf70$0202a8c0@domain.hid>
References: <001f01c89cc6$f269b250$0202a8c0@domain.hid>
	<18433.65.910459.873472@domain.hid>
	<000701c89d68$8857e380$0202a8c0@domain.hid>
	<48020FEA.20309@domain.hid>
	<003401c89d78$d187bf70$0202a8c0@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Communication between Xenomai and Linux domains
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: van der Linden <ejvanderlinden@domain.hid>
Cc: xenomai@xenomai.org

van der Linden wrote:
 > Jan,
 > 
 > I have two real-time requirements:
 > 
 > 1.  I have to get audio from ALSA and deliver it to a custom FPGA driver and 
 > vice versa each 5 miliseconds.
 >      So, I will set the chunk size for ALSA in such a way I get 5 ms audio 
 > samples. From the FPGA I also get chunks of 5ms.
 > 
 >      There may be some jitter in delivering between ALSA and FPGA but think 
 > of one or two miliseconds.
 > 
 > 2. I want to receive 5ms audio from ALSA and after filtering and processing 
 > it I have to sent it back to ALSA.
 >     This must be done within 10ms.

As long as you use ALSA, you will not be able to gain anything by using
Xenomai: in order to access the ALSA driver a real-time thread will
enter secondary mode, that is loose its real-time characteristic, and
you will get the same latencies as you would get with Linux. So, for
best performances, you will have to rewrite part of the Audio driver
using Xenomai services. The recommended way being to use the RTDM skin
to write a real-time driver.

-- 


					    Gilles.


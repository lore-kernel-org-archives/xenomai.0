Message-ID: <003401c89d78$d187bf70$0202a8c0@domain.hid>
From: "van der Linden" <ejvanderlinden@domain.hid>
References: <001f01c89cc6$f269b250$0202a8c0@domain.hid>	<18433.65.910459.873472@domain.hid>
	<000701c89d68$8857e380$0202a8c0@domain.hid>
	<48020FEA.20309@domain.hid>
Date: Sun, 13 Apr 2008 17:12:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
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
To: xenomai@xenomai.org

Jan,

I have two real-time requirements:

1.  I have to get audio from ALSA and deliver it to a custom FPGA driver and 
vice versa each 5 miliseconds.
     So, I will set the chunk size for ALSA in such a way I get 5 ms audio 
samples. From the FPGA I also get chunks of 5ms.

     There may be some jitter in delivering between ALSA and FPGA but think 
of one or two miliseconds.

2. I want to receive 5ms audio from ALSA and after filtering and processing 
it I have to sent it back to ALSA.
    This must be done within 10ms.

We tested the real-time patches but the interrupt latency was not good 
enough on our Blackfin 537 DSP (measured with a latency measuring tool).
With Xenomai installed the latency tool showed very good response. So I want 
to go the Xenomai way.

So therefor I like to know more about the Xenomai / Linux interaction and 
the performance measuring method (see original mailing).

Ernst-Jan 



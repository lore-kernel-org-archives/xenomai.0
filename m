Message-ID: <4B055F3B.2000508@domain.hid>
Date: Thu, 19 Nov 2009 16:07:39 +0100
From: Benjamin Biegel <biegel@domain.hid>
MIME-Version: 1.0
References: <4AFD01D3.1070604@domain.hid> <4AFD4C7F.1000106@domain.hid>
	<4AFD6013.9020608@domain.hid> <4AFE90A8.7090403@domain.hid>
	<4AFE91AC.6080904@domain.hid>
In-Reply-To: <4AFE91AC.6080904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] How to capture frames with RTcap without TDMA?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello all

We want to send data from a NIC and capture what we send using RTcap, 
but we do not want any TDMA discipline running.

So we want the VNIC but not TDMA running. The solution seems to be using 
nomac.

My attempt was to exchange 'insmod ../tdma.ko' with 'insmod ../nomac.ko' 
in the rtnet bash script, but it gives an '-1 Unknown symbol in module' 
error. How then is the nomac-discipline loaded?

I assume this module somehow must be loaded, where after i run 'nomaccfg 
rteth1attach'?

Thanks for any help

Benjamin


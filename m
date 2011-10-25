Message-ID: <4EA69486.4030106@domain.hid>
Date: Tue, 25 Oct 2011 12:50:46 +0200
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
>  8)     rt_task_create(&task_desc, "RealTimeImageProcessing", 4096, 99, T_FPU|T_CPU(0));

4096 bytes is a really small stack size, are you sure that the
segmentation fault is simply not a stack overflow?

-- 
					    Gilles.


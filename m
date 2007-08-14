Message-ID: <46C13B91.6020801@domain.hid>
Date: Tue, 14 Aug 2007 07:20:17 +0200
MIME-Version: 1.0
References: <46C0719B.1010102@domain.hid>
	<46C07AF2.60402@domain.hid>	<46C07D73.7070302@domain.hid>
	<46C080C8.10906@domain.hid>	<46C0835E.8010105@domain.hid>
	<46C0B036.3030306@domain.hid>	<46C0B1DF.6090509@domain.hid>
	<46C0B9F7.9060103@domain.hid> <46C0D686.6000007@domain.hid>
In-Reply-To: <46C0D686.6000007@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] rtcan bufferoverflow but no evidence
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Hi,

> Recall that up to Xenomai 2.4 RTDM device/socket closing may fail (with
> -EAGAIN) when some other thread is currently using it and doesn't
> release it immediately when being "asked". That means for now you should
> loop over [rt_dev_]close as long as EAGAIN is returned.

Excellent thanks. I did not know this. Is xenomai 2.4 stable yet? Would 
you advise it as the version of choice at the moment?


Roland


> 
> Jan
> 


Message-ID: <4F8E875C.4070907@domain.hid>
Date: Wed, 18 Apr 2012 11:20:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201204181024206179330@domain.hid>
In-Reply-To: <201204181024206179330@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Can't use interrupt after adeos patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: hustgongchen <hustgongchen@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On 04/18/2012 04:24 AM, hustgongchen wrote:
> Hi everyone:
>     I use linux kernel 2.6.33 and xenomai 2.5.3 to build my rt-embedded system based on S3c2440,
> but i found I can't use interrupt after put the adeos patch to linux kernel.The system crashes once
>  I insert a USB device to it or receive a ethernet packet(the net card i use is CS8900).
>     Because even i didn't build xenomai into kernel , the system still crashed once received a 
> hardware interrupt so i guess the problem is about adeos patch.Is there any bug with 
> adeos-ipipe-2.6.33-arm-1.16-01.patch?

Please try xenomai 2.6.0 and the patches it contains.

-- 
					    Gilles.


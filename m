Message-ID: <489AC254.2070407@domain.hid>
Date: Thu, 07 Aug 2008 11:37:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2b490f270808061420l5da130b1sb8a2ccd9c34d46f5@domain.hid>
In-Reply-To: <2b490f270808061420l5da130b1sb8a2ccd9c34d46f5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] SATA problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dehann Fourie <dehann.fourie@domain.hid>
Cc: xenomai@xenomai.org

Dehann Fourie wrote:
> Hi,
> 
> I have changed to a SATA hard drive on my Xeno machine, but now have kernel
> panic - not sync: unable to kill init! I have done some reading on the sda?
> destination for a SATA device. It seems to me that the PC doesn't find the
> SATA hard drive and I suspect the problem is at root="\dev\sda1" in the

It is /, not \

-- 
                                                 Gilles.


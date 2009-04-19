Message-ID: <49EAEBF8.9090006@domain.hid>
Date: Sun, 19 Apr 2009 11:16:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2b490f270904170749m3ec39cc8vddab1b5aa50f4b4c@domain.hid>	
	<49E89BC7.6000704@domain.hid>
	<2b490f270904190151n70cfc610u9a742da5c62e4076@domain.hid>
In-Reply-To: <2b490f270904190151n70cfc610u9a742da5c62e4076@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RT Serial, rt_dev_read blocking problem
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
> Hi Gilles,
> 
> Thanks a lot. Will give it a try. I have tried  .rx_timeout =
> RTSER_TIMEOUT_NONE before, but then I was not able to read any data. I am
> assuming the data expired before I had read it. This was on a different
> config however, so I will try it again.
> 
> Please excuse my lack of knowledge but I am not following you on:
> -  ... and apply the commit 3a23967f3cc8d6881d8e3280130bbc431195aa31
> -     from head.

Xenomai has a git repository now. See http://git.xenomai.org/
3a23967f3cc8d6881d8e3280130bbc431195aa31 is the identifier of a commit.

-- 
					    Gilles.


Message-ID: <4A547F31.5010003@domain.hid>
Date: Wed, 08 Jul 2009 13:12:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <336414.37218.qm@domain.hid>
In-Reply-To: <336414.37218.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_create memory size
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yigal Goldberger <yigal_gold@domain.hid>
Cc: xenomai@xenomai.org

Yigal Goldberger wrote:
> Hi Gilles,
> 
> I enlarged the stack size during thread creation to 256KB and reduced
> the memory usage by ~140MB , this is roughly explained by an 8MB
> stack per thread .So there is no memory problem . Your quick and
> helpful responses are much appreciated.

Ok. But to avoid doing this tuning blindly, you can use
PTHREAD_STACK_MIN, and I believe checking pthread_attr_setstacksize
return value should tell you if the stack size you try is accepted.

-- 
					    Gilles.


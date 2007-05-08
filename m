Message-ID: <46408558.9040604@domain.hid>
Date: Tue, 08 May 2007 16:12:40 +0200
From: Bernhard Michael <michael.bernhard@domain.hid>
MIME-Version: 1.0
References: <46407EC1.6070809@domain.hid>
	<17984.32675.944851.70015@domain.hid>
In-Reply-To: <17984.32675.944851.70015@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_create killed in user space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> 
> Maybe you forgot to call mlockall, don't you get an error message saying
> so ?
> 

Calling mlockall before rt_task_create solved the problem! Thank you Gilles.

I didn't get an error message saying something like that. Just 'killed'.
Because I have no swap memory and I disabled this kernel feature, I
thought that the call of mlockall is not necessary.

Thanks again

Michael


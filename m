Message-ID: <45007AF4.4050808@domain.hid>
Date: Thu, 07 Sep 2006 15:03:00 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Porting / API Questions
References: <44FF3C26.10501@domain.hid>
	<17663.64870.945605.117981@domain.hid>
In-Reply-To: <17663.64870.945605.117981@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
> There should be no problem mixing the POSIX API with other
> interfaces. If a POSIX service absolutely requires a POSIX skin thread,
> it will return an error of EPERM when called from an invalid
> context. 

Thanks!

> Now, if you want to exchange messages "the POSIX way", you can
> use POSIX message queues.

I will probably make this switch, but I would rather get the code ported to xenomai with as few changes as possible.  After that, I will try to go "the POSIX way" to future-proof the code as much as possible.

-Jeff


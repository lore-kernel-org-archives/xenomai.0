Date: Mon, 3 Apr 2006 15:46:04 +0200
From: Jens Niehaus <niehaus@domain.hid>
Subject: Re: [Xenomai-help] Problem with posix skin and Xenomai 2.1.0
Message-ID: <20060403154604.1cce63de@domain.hid>
In-Reply-To: <17457.5070.917000.693950@domain.hid>
References: <20060403111703.593b2b15@domain.hid>
	<17457.5070.917000.693950@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: xenomai@xenomai.org

On Mon, 3 Apr 2006 14:23:42 +0200 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

>  > Hi,
>  > 
>  > I am experiencing problems with xenomai 2.1.0 and pthread_mutex_init. 
> 
> There was a bug in syscall.c, which should be fixed by revision 870 in
> the trunk and by revision 871 in 2.1 branch.
> 

Thank you for the quick response. Unfortunately the bug still occurs with revision 871 (branch). 

If you cannot reproduce the bug on your system any more I'd like to help fixing this one. So tell me if you need some more output, configurations or printf/printk-stuff from within xenomai code.

Jens



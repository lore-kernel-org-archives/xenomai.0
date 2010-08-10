Message-ID: <4C61BC81.3000107@domain.hid>
Date: Tue, 10 Aug 2010 22:54:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTim1+--sP1vMpaduv9Sey+r6-1fN_L2HZ68X1-+T@mail.gmail.com>
In-Reply-To: <AANLkTim1+--sP1vMpaduv9Sey+r6-1fN_L2HZ68X1-+T@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Help on IPC example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ettore Pedretti <epedrett@domain.hid>
Cc: xenomai@xenomai.org, John Monnier <monnier@domain.hid>

Ettore Pedretti wrote:
> Hello All,
> 
> Since pipes will be soon removed from xenomai I would like to use
> sockets on ipc. I know the question have been already asked but is
> there any documentation other than the examples at present?
> 
> Also, I have compiled the examples in the ipc directory and I get the
> following error while executing any of the programmes:
> 
>  mirkwood:/home/ep41/ipc# ./bufp-label
> socket: Address family not supported by protocol
> 
> What am I doing wrong? Attached my .config file.

is the example compiled for xenomai posix skin? If you do not know what
I am talking about, see:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_flags.

-- 
					    Gilles.


Message-ID: <4BDAEF94.1050400@domain.hid>
Date: Fri, 30 Apr 2010 16:56:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <x2qa2d86cab1004300739z5dffe340o7df607e1dc2ec189@domain.hid>	
	<4BDAECA0.8030006@domain.hid>	
	<z2sa2d86cab1004300748n41fbef55t5fefc57827f2f089@domain.hid>	
	<4BDAEE48.3060507@domain.hid>
	<r2wa2d86cab1004300753g460979f8q2964646a5c362df@domain.hid>
In-Reply-To: <r2wa2d86cab1004300753g460979f8q2964646a5c362df@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] help with porting simple posix application
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leyrit Vincent <sec.leyrit@domain.hid>
Cc: xenomai@xenomai.org

Leyrit Vincent wrote:
> sorry i have forgot to post all the code :
> here printf is a define to the one provided by xenomai library :
> 
> #define xnarch_printf printf

If you do not believe me, use pthread_set_mode_np as explained in the howto.

-- 
					    Gilles.


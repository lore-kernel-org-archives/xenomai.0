Message-ID: <4BDAEE48.3060507@domain.hid>
Date: Fri, 30 Apr 2010 16:50:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <x2qa2d86cab1004300739z5dffe340o7df607e1dc2ec189@domain.hid>	
	<4BDAECA0.8030006@domain.hid>
	<z2sa2d86cab1004300748n41fbef55t5fefc57827f2f089@domain.hid>
In-Reply-To: <z2sa2d86cab1004300748n41fbef55t5fefc57827f2f089@domain.hid>
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
> Thanks you for the link, i have already have a look on it ...
> The only thing that i do not understand in the code i have posted, is
> that i never do any call to a linux domain syscall ...

printf sometimes results in a linux domain syscall, it is mentioned in
the howto.

-- 
					    Gilles.


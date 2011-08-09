Message-ID: <4E417900.7040005@domain.hid>
Date: Tue, 09 Aug 2011 20:14:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E412D63.4080105@domain.hid>
In-Reply-To: <4E412D63.4080105@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xenomai-head compile failure
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

On 08/09/2011 02:51 PM, Daniele Nicolodi wrote:
> Hello,
> 
> I'm compiling xenomai-head on i386 debian/testing. I found that the file
> src/skins/posix/wrappers.c is missing an include of signal.h for the
> definition of pthread_kill().

Fixed, thanks.

-- 
                                                                Gilles.


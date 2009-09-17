Message-ID: <4AB27E66.9080203@domain.hid>
Date: Thu, 17 Sep 2009 20:22:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <9b3e2dc20909171117x6fb3f8b7ka4491e2bf9259cce@domain.hid>
In-Reply-To: <9b3e2dc20909171117x6fb3f8b7ka4491e2bf9259cce@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] udev rules
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephen Sinclair <radarsat1@domain.hid>
Cc: xenomai@xenomai.org

Stephen Sinclair wrote:
> Hi,
> 
> I am successfully running Xenomai examples now.  Just wanted to note
> that it took me a little while to figure out why I was getting this
> error even though I had set up the xenomai group as suggested in the
> quick build guide:
> 
> $ ./trivial-periodic
> Xenomai: open: Permission denied
> Xenomai: mmap(local sem heap): Permission denied
> 
> I found that the /dev/rtheap node did not have the correct
> permissions. I finally found the rtheap.rules file included in
> xenomai.  I just wanted to suggest that installation of this rules
> file in /etc/udev/rules.d should perhaps be included as a step in this
> quick build guide.

This should happen automatically when running make install. You mean it
does not work ?

-- 
					    Gilles.


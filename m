Message-ID: <2ff1a98a0803050520r6c139665q4612995f0a20e635@domain.hid>
Date: Wed, 5 Mar 2008 14:20:36 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <7289437c0803050323k3c799667g8c53efce3640be85@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7289437c0803050323k3c799667g8c53efce3640be85@domain.hid>
Subject: Re: [Xenomai-help] error EPERM on a pthread_mutex_lock
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Wed, Mar 5, 2008 at 12:23 PM, Perrine Martignoni <perrmart@domain.hid> wrote:
> Hello,
>
> I have a problem with pthread_mutex_lock. I write a module RTDM which calls
> Linux code containing a pthread_mutex_lock.
> This returns the EPERM error.
> I would know if I can do this : lock a mutex which is in Linux code, in
> xenomai context.
>  If yes, have you any idea ?

I can understand EPERM if the mutex is a Xenomai mutex locked from a
non Xenomai context: this will not work. But the other way around, I
have no clue.

-- 
                                               Gilles Chanteperdrix


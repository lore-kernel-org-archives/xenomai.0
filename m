Message-ID: <4F949BBF.6020008@domain.hid>
Date: Mon, 23 Apr 2012 02:01:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKvQZ_2OhLoG4_rGJ1LgFnbdkK4X3zFV+4o-GnhSer8oS5U9Tw@domain.hid>
In-Reply-To: <CAKvQZ_2OhLoG4_rGJ1LgFnbdkK4X3zFV+4o-GnhSer8oS5U9Tw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] libnative and libxenomai dependy problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Willy Lambert <lambert.willy@domain.hid>
Cc: xenomai@xenomai.org

On 04/23/2012 01:57 AM, Willy Lambert wrote:
> Hi,
> 
> I just run into the same kind of problem of a one year old discussion :
> http://www.mail-archive.com/xenomai@xenomai.org
> 
> having such kind of errors :
> /usr/lib/libnative.so.3: undefined symbol: xeno_current_mode_key
> I have a xenomai 2.6.0 recompiled from sources with the --dl-open
> option enabled.
> root@domain.hid):~# cat /proc/xenomai/version
> 2.6.0
> 
> 
> I re-post something because I'm not sure it is up to date and as I
> have the next version I am suprised the problem still arises
> 
> I have 2 question :
> _ did I missconfigured something in my compiller flags or linking ?
> _ are the solutions of last thread still up to date ?
> 

You need to dlopen libxenomai in order for dlopen(libnative) to succeed.

-- 
                                                                Gilles.


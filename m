Message-ID: <4DC976C0.6000506@domain.hid>
Date: Tue, 10 May 2011 10:32:48 -0700
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <201105101823.50226.lux-integ@domain.hid>
In-Reply-To: <201105101823.50226.lux-integ@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] preferred  uid?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: luxInteg <lux-integ@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

luxInteg wrote:
> greetings
>
> I normally  compile stuff as an ordinary user,  but   I noticed in this area   
> people often compile as root as  kernel  modules are involved.   I note 
> xenomai can be compiled either as user or root so  is there a preferred way ?
>   
The patched kernel and fundamental Xenomai kernel modules must be 
installed and loaded as root, but can in principle be built by any user. 
The userland Xenomai libraries could be built by any user but (for my 
systems anyway) are installed in areas requiring root permissions. Code 
you build yourself on top of userland Xenomai can be built by any user 
(this is what I do), but must be run with a subset of root permissions 
to allow setting thread priorities etc.

hth

                                       - Tom



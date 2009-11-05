Message-ID: <4AF3005D.6000701@domain.hid>
Date: Thu, 05 Nov 2009 17:42:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BB99A6BA28709744BF22A68E6D7EB51F03310307D6@domain.hid>	<4AF20D2B.30508@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F033103081D@midas.usurf.usu.edu>
	<4AF29229.2090205@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F03310309AA@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F03310309AA@midas.usurf.usu.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Sharing Semaphores in Kernel and User Space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonathan Haws <Jonathan.Haws@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@domain.hid" <jan.kiszka@domain.hid>

Jonathan Haws wrote:
> I think for our application the RTDM driver is not necessary.  Simply
> synchronizing with a RT_SEM will do the trick for us.
> 
> Thanks for all the help!

Well, since you are at it, you can also use interrupts directly from
user-space with rt_intr* services.


-- 
                                          Gilles



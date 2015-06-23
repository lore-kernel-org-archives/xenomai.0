MIME-Version: 1.0
In-Reply-To: <b6faa54490b78e7d2d66d3143323d8d3.squirrel@sourcetrek.com>
References: <CAOL1OyMgNHaY4tgbUXM0Ytm9YnR3VGaJN-c60_5fuMayjz4aSw@mail.gmail.com>
 <558843FB.3040704@siemens.com>
 <CAOL1OyOWmGY2TFo6LaydWmeFqThHnVHNHtgk_iFZJ9aiwOM6uw@mail.gmail.com>
 <5588FA58.2080403@siemens.com>
 <CAOL1OyMJ9BS8jHWrHHVeCbP7tYJ7-Kgz6KzB4DAkBDpAGENUVA@mail.gmail.com>
 <20150623141142.GK17436@csclub.uwaterloo.ca> <55896A1A.2030408@siemens.com>
 <c2c68cadb110b6c7963aa06cadde978b.squirrel@sourcetrek.com>
 <CAOL1OyM2ViCuuD1BPRze0yhX6cSNqCRxMvu3mM=frnXA5Ly5NA@mail.gmail.com>
 <27e7da29c78157dc78e598cd191b3893.squirrel@sourcetrek.com>
 <CAOL1OyMEPWaM9tYSJRzutEy1=FDVquA1O86zjkSw=dnnb+vckw@mail.gmail.com>
 <b6faa54490b78e7d2d66d3143323d8d3.squirrel@sourcetrek.com>
From: Antoine Durand <wanipof@gmail.com>
Date: Tue, 23 Jun 2015 17:01:23 +0200
Message-ID: <CAOL1OyMgM42eG3_Vk0rKp6M+xuD5cz2+j0vEUsCFe2g1VK6KZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] I-Pipe Tracer and linux ftrace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

I don't need do disable nmi_watchdog anymore,
I can run dohell without any Hard Lockup kernel crash.
That's a good point !



2015-06-23 16:49 GMT+02:00 Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org>:

>
> Antoine Durand wrote:
> > It switched to refined-jiffies :
>
> Ok, indeed, this one is not supported by Xenomai, and will likely never
> be. We support HPET and 8254 only.
>
>
> --
>                                             Gilles.
> https://click-hack.org
>
>

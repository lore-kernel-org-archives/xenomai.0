Message-ID: <47782043.3040207@domain.hid>
Date: Sun, 30 Dec 2007 23:48:35 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200712302029.59827.paul_c@domain.hid>
In-Reply-To: <200712302029.59827.paul_c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH] printk documentation
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Paul wrote:
> Hi Philippe
> 
> Running some full kernel package builds with 2.6.23 & Xenomai v2.4.x, and once 
> again hit a problem I reported in May[1] - This issue as crept back in 
> causing the kernel documentation targets to fail.
> 

It seems that I only merged it to the 2.6.20-noarch branch at that time,
and for some reason, this patch slipped away from the latest versions.

>  Patch attached to resolve the problem.
> 
> 

Now merged in all active -noarch branches from my tree (2.6.20, 2.6.23
and 2.6.24), thanks.

-- 
Philippe.


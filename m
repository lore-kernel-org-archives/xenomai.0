Message-ID: <49184F13.7050309@domain.hid>
Date: Mon, 10 Nov 2008 16:11:15 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <49184D78.2070204@domain.hid>
In-Reply-To: <49184D78.2070204@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [BUG] build failure with newest i-pipe version
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Sebastian Smolorz wrote:
> Hi Philippe,
> 
> patching 2.6.27 with the i-pipe patch from Xenomai release 2.4.6 (i.e. 
> adeos-ipipe-2.6.27-x86-2.1-01.patch) causes a build failure of the 
> kernel when configuring i-pipe out. The reason is in line 271 of 
> kernel/panic.c. ipipe_processor_id() is not known at this point.
> 

Ok, will fix, thanks.

-- 
Philippe.


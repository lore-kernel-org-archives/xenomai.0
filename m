Message-ID: <4B858711.9040806@domain.hid>
Date: Wed, 24 Feb 2010 21:07:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B856ADF.1030100@domain.hid>
In-Reply-To: <4B856ADF.1030100@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interpreting the ksrc/arch/arm/patches directory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
> Lately I have been using the OpenEmbedded bitbake tool to build my Linux 
> systems (Angstrom for BeagleBoard based).  Has anyone created a recipe 
> set to build Xenomai under OpenEmbedded?
> 
> What I really want to do is install Xenomai into the BeagleBoard 
> Angstrom kernel.

Yes, recently someone reported using this method. However, he had issues
with -Wl,--as-needed which we did not elucidate completely.

> 
> Regards,
> Bob
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
					    Gilles.


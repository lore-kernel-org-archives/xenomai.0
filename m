Message-ID: <4C0381BF.80002@domain.hid>
Date: Mon, 31 May 2010 11:30:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C036DF6.8020201@domain.hid>
In-Reply-To: <4C036DF6.8020201@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] 2.6.32 patch for arm?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Albert Veli <albert.veli@domain.hid>
Cc: xenomai@xenomai.org

Albert Veli wrote:
> Dear xenomai-help list,
> 
> I am looking at the ipipe patch for a custom arm-board. The linux kernel
> version is 2.6.32.x (currently 2.6.32.14). It was chosen because it is
> defined to be a "long-term" stable release and we do not plan on
> changing the minor version very often.
> 
> Now the problem is that ipipe patches for 2.6.32.x are only available
> for x86 and ppc. For arm I can only find 2.6.30.x, 2.6.31.x and 2.6.33.x
> but not 2.6.32.x.
> 
> Are there any plans for creating an ipipe arm-patch for 2.6.32.x? I have
> tried to port the 2.6.33 patch back to 2.6.32 but it is a pretty
> intrusive patch and the chance for me to get it correctly done is
> somewhere between slim to none :-)

Well, 2.6.34 is out, so the plan was rather to work on 2.6.34 than on
2.6.32 if I have time to spend on this. However, the intrusive part of
the I-pipe patch is rather the FCSE patch, and this one exists for
2.6.32, see branch fcse-2.6.32:
http://git.xenomai.org/?p=ipipe-gch.git;a=summary

-- 
					    Gilles.


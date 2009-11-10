Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Wed, 11 Nov 2009 00:55:23 +0100
References: <200911101536.55579.leo@domain.hid>
In-Reply-To: <200911101536.55579.leo@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200911110055.23162.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] rtdm and comedi
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

On Tuesday 10 November 2009 15:36:55 Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> I would like to ask about comedi and xenomai because I'm a bit lost with
>  the situation in xenomai. I think that Alexis Berlemont did a branch of
>  xenomai with support for some drivers from comedi in xenomai.
>
We have the comedi core layer and the NI PCIMIO driver which are ported to 
rtdm. 

Concerning the branch you mentioned, if you speak about the comedi branch on 
my git repository, you must have noticed that this branch is no more active (I 
should remove it). 
Comedi/RTDM was renamed as analogy, here is a mail which explains the 
motivations.
https://mail.gna.org/public/xenomai-core/2009-09/msg00016.html

Consequently, an analogy branch was created in my repository instead. This one 
is maintained.

> I have read last week about the recommendation of use the comedi parallel
>  port driver and I'm a bit confused about the real status of comedi in
>  xenomai.
> 
> So, please, could you explain if comedi will be full integrated in xenomai
>  and when if yes?
> 
Analogy was integrated into xenomai's head and it is expected be released with 
the 2.5 version.

> Regards,
> 
> Leo
> 
Alexis.

